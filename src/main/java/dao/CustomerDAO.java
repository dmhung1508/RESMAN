package dao;

import model.Customer;
import model.Users;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CustomerDAO extends DAO {

    public CustomerDAO() {
        super();
    }

    /**
     * Đăng ký tài khoản customer mới
     * @param user Thông tin user
     * @return Customer ID nếu thành công, 0 nếu thất bại
     */
    public int register(Users user) {
        try {
            // Insert vào bảng tblUser trước với role='customer'
            String sqlUser = "INSERT INTO tblUser (username, password, name, `date`, address, phone, role) " +
                           "VALUES (?, ?, ?, ?, ?, ?, 'customer')";
            PreparedStatement psUser = con.prepareStatement(sqlUser, PreparedStatement.RETURN_GENERATED_KEYS);
            psUser.setString(1, user.getUsername());
            psUser.setString(2, user.getPassword());
            psUser.setString(3, user.getName());
            psUser.setDate(4, user.getDate());
            psUser.setString(5, user.getAddress());
            psUser.setString(6, user.getPhone());
            
            int userRows = psUser.executeUpdate();
            if (userRows == 0) {
                psUser.close();
                return 0;
            }
            
            // Lấy ID vừa tạo
            ResultSet rs = psUser.getGeneratedKeys();
            int userId = 0;
            if (rs.next()) {
                userId = rs.getInt(1);
            }
            rs.close();
            psUser.close();
            
            // Insert vào bảng tblCustomer
            String sqlCustomer = "INSERT INTO tblCustomer (ID) VALUES (?)";
            PreparedStatement psCustomer = con.prepareStatement(sqlCustomer);
            psCustomer.setInt(1, userId);
            
            int customerRows = psCustomer.executeUpdate();
            psCustomer.close();
            
            return customerRows > 0 ? userId : 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }

    /**
     * Lấy thông tin customer theo phone
     * @param phone Số điện thoại
     * @return Customer object hoặc null
     */
    public Customer getCustomerByPhone(String phone) {
        Customer customer = null;
        String sql = "SELECT c.ID, u.* FROM tblCustomer c " +
                    "JOIN tblUser u ON c.ID = u.ID " +
                    "WHERE u.phone = ? AND u.role = 'customer'";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                customer = new Customer();
                customer.setId(rs.getInt("ID"));
                
                // Thông tin user
                Users user = new Users();
                user.setId(rs.getInt("ID"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setDate(rs.getDate("date"));
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                
                customer.setUser(user);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return customer;
    }

    /**
     * Lấy thông tin customer theo tên hoặc SĐT
     * @param info Tên hoặc SĐT khách hàng
     * @return Customer object hoặc null
     */
    public Customer getCustomerByNameOrPhone(String info) {
        Customer customer = null;
        String sql = "SELECT c.ID, u.* FROM tblCustomer c " +
                    "JOIN tblUser u ON c.ID = u.ID " +
                    "WHERE (u.name LIKE ? OR u.phone = ?) AND u.role = 'customer'";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + info + "%");
            ps.setString(2, info);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                customer = new Customer();
                customer.setId(rs.getInt("ID"));
                
                Users user = new Users();
                user.setId(rs.getInt("ID"));
                user.setUsername(rs.getString("username"));
                user.setPassword(rs.getString("password"));
                user.setName(rs.getString("name"));
                user.setDate(rs.getDate("date"));
                user.setAddress(rs.getString("address"));
                user.setPhone(rs.getString("phone"));
                user.setRole(rs.getString("role"));
                
                customer.setUser(user);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return customer;
    }

    /**
     * Kiểm tra phone đã tồn tại chưa
     * @param phone Số điện thoại cần kiểm tra
     * @return true nếu đã tồn tại, false nếu chưa
     */
    public boolean checkPhoneExists(String phone) {
        String sql = "SELECT COUNT(*) FROM tblUser WHERE phone = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, phone);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                int count = rs.getInt(1);
                rs.close();
                ps.close();
                return count > 0;
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return false;
    }
}

