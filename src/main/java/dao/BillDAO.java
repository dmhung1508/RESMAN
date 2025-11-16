package dao;

import model.Order;
import model.OrderItem;
import model.Dish;
import model.Bill;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

public class BillDAO extends DAO {

    public BillDAO() {
        super();
    }

    /**
     * Lưu hóa đơn vào database
     * @param order Đối tượng Order cần lưu
     * @param customerId ID khách hàng
     * @param tableId ID bàn
     * @param staffId ID nhân viên
     * @return true nếu lưu thành công, false nếu thất bại
     */
    public boolean saveBill(Order order, int customerId, int tableId, int staffId) {
        String sqlBill = "INSERT INTO tblBill (`date`, totalprice, status, CustomerID, tblStaffID) VALUES (?, ?, 'Chưa thanh toán', ?, ?)";
        
        try {
            PreparedStatement ps = con.prepareStatement(sqlBill, Statement.RETURN_GENERATED_KEYS);
            ps.setDate(1, new Date(System.currentTimeMillis()));
            ps.setFloat(2, order.getTotalAmount().floatValue());
            ps.setInt(3, customerId);
            ps.setInt(4, staffId);
            
            int rowsAffected = ps.executeUpdate();
            
            if (rowsAffected > 0) {
                // Lấy ID vừa được tạo
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    order.setOrderID(rs.getInt(1));
                }
                rs.close();
                
                // Lưu tblOrderedTable
                String sqlOrderedTable = "INSERT INTO tblOrderedTable (`date`, TableID, BillID) VALUES (?, ?, ?)";
                PreparedStatement psTable = con.prepareStatement(sqlOrderedTable);
                psTable.setDate(1, new Date(System.currentTimeMillis()));
                psTable.setInt(2, tableId);
                psTable.setInt(3, order.getOrderID());
                psTable.executeUpdate();
                psTable.close();
            }
            
            ps.close();
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lưu chi tiết đơn hàng (OrderItem) vào tblOrderedDish
     * @param billID ID của hóa đơn
     * @param dishID ID của món ăn
     * @param quantity Số lượng
     * @param price Giá (line total)
     * @return true nếu lưu thành công, false nếu thất bại
     */
    public boolean saveOrderItem(int billID, int dishID, int quantity, BigDecimal price) {
        String sql = "INSERT INTO tblOrderedDish (quantity, price, BillID, DishID) VALUES (?, ?, ?, ?)";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, quantity);
            ps.setFloat(2, price.floatValue());
            ps.setInt(3, billID);
            ps.setInt(4, dishID);
            
            int rowsAffected = ps.executeUpdate();
            ps.close();
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy thông tin hóa đơn theo ID
     * @param billID ID của hóa đơn
     * @return Đối tượng Order
     */
    public Order getBillById(int billID) {
        Order order = null;
        String sql = "SELECT * FROM tblBill WHERE ID = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, billID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                order = new Order();
                order.setOrderID(rs.getInt("ID"));
                order.setTotalAmount(BigDecimal.valueOf(rs.getFloat("totalprice")));
                // Set orderDate from date field
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return order;
    }

    /**
     * Lấy tất cả hóa đơn với đầy đủ thông tin (dành cho nhân viên)
     * @return Danh sách Bill
     */
    public List<Bill> getAllBillsWithInfo() {
        List<Bill> bills = new ArrayList<>();
        String sql = "SELECT b.*, t.description as table_desc, u.name as customer_name, u.phone as customer_phone " +
                    "FROM tblBill b " +
                    "LEFT JOIN tblOrderedTable ot ON b.ID = ot.BillID " +
                    "LEFT JOIN tblTable t ON ot.TableID = t.ID " +
                    "LEFT JOIN tblCustomer c ON b.CustomerID = c.ID " +
                    "LEFT JOIN tblUser u ON c.ID = u.ID " +
                    "ORDER BY b.`date` DESC";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Bill bill = new Bill();
                bill.setBillID(rs.getInt("billID"));
                bill.setTotalAmount(BigDecimal.valueOf(rs.getFloat("totalprice")));
                bill.setStatus(rs.getString("status"));
                bill.setCustomerName(rs.getString("customer_name"));
                bill.setCustomerPhone(rs.getString("customer_phone"));
                bill.setTableDescription(rs.getString("table_desc"));
                
                // Set billDate từ date field
                if (rs.getDate("date") != null) {
                    bill.setBillDate(new java.sql.Timestamp(rs.getDate("date").getTime()));
                }
                
                // Lấy chi tiết các món
                bill.setOrderItems(getOrderItemsByBillId(bill.getBillID()));
                
                bills.add(bill);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return bills;
    }

    /**
     * Lấy danh sách món trong hóa đơn
     * @param billId ID hóa đơn
     * @return Danh sách OrderItem
     */
    public List<OrderItem> getOrderItemsByBillId(int billId) {
        List<OrderItem> items = new ArrayList<>();
        String sql = "SELECT od.*, d.name, d.price as dish_price " +
                    "FROM tblOrderedDish od " +
                    "JOIN tblDish d ON od.DishID = d.ID " +
                    "WHERE od.BillID = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, billId);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                OrderItem item = new OrderItem();
                item.setOrderItemID(rs.getInt("ID"));
                item.setQuantity(rs.getInt("quantity"));
                item.setLineTotal(BigDecimal.valueOf(rs.getFloat("price")));
                
                // Tạo đối tượng Dish
                Dish dish = new Dish();
                dish.setId(rs.getInt("DishID"));
                dish.setName(rs.getString("name"));
                dish.setPrice(BigDecimal.valueOf(rs.getFloat("dish_price")));
                item.setDish(dish);
                
                items.add(item);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return items;
    }
}
