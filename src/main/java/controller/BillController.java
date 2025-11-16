package controller;

import dao.BillDAO;
import dao.DishDAO;
import dao.CustomerDAO;
import model.Order;
import model.OrderItem;
import model.Dish;
import model.Staff;
import model.Customer;
import model.Table;
import model.Bill;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet(name = "BillController", urlPatterns = {"/BillController"})
public class BillController extends HttpServlet {

    private void doAddToCart(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        int dishID = Integer.parseInt(request.getParameter("dishID"));
        int quantity = Integer.parseInt(request.getParameter("quantity"));
        
        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        
        if (cart == null) {
            cart = new HashMap<>();
        }
        
        // Cộng dồn số lượng nếu món đã có trong giỏ
        cart.put(dishID, cart.getOrDefault(dishID, 0) + quantity);
        session.setAttribute("cart", cart);
        
        // Quay lại trang chọn món
        response.sendRedirect("SelectDish.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "addToCart":
                doAddToCart(request, response);
                break;
            case "confirm":
                doConfirmOrder(request, response);
                break;
            case "save":
                doSaveBill(request, response);
                break;
            case "view":
                doViewBill(request, response);
                break;
            case "history":
                doViewHistory(request, response);
                break;
            default:
                doViewHistory(request, response);
                break;
        }
    }

    private void doConfirmOrder(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("errorMessage", "Giỏ hàng trống!");
            request.getRequestDispatcher("SelectDish.jsp").forward(request, response);
            return;
        }
        
        request.getRequestDispatcher("ConfirmUI.jsp").forward(request, response);
    }

    private void doSaveBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        
        // Lấy thông tin từ session
        @SuppressWarnings("unchecked")
        Map<Integer, Integer> cart = (Map<Integer, Integer>) session.getAttribute("cart");
        Table selectedTable = (Table) session.getAttribute("selectedTable");
        Staff staff = (Staff) session.getAttribute("staff");
        
        // Lấy thông tin khách hàng từ session
        Customer currentCustomer = (Customer) session.getAttribute("currentCustomer");
        String customerPhone = (String) session.getAttribute("customerPhone");
        
        if (cart == null || cart.isEmpty()) {
            request.setAttribute("errorMessage", "Không có thông tin đặt hàng!");
            request.getRequestDispatcher("SelectDish.jsp").forward(request, response);
            return;
        }
        
        if (selectedTable == null) {
            request.setAttribute("errorMessage", "Chưa chọn bàn!");
            request.getRequestDispatcher("SearchTableUI.jsp").forward(request, response);
            return;
        }
        
        if (staff == null) {
            request.setAttribute("errorMessage", "Vui lòng đăng nhập!");
            response.sendRedirect("Login.jsp");
            return;
        }
        
        // Tìm hoặc tạo khách hàng
        CustomerDAO customerDAO = new CustomerDAO();
        int customerId = 0;
        
        if (currentCustomer != null) {
            // Customer đã tồn tại trong session
            customerId = currentCustomer.getId();
        } else if (customerPhone != null && !customerPhone.isEmpty()) {
            // Tìm customer theo phone
            model.Customer customer = customerDAO.getCustomerByPhone(customerPhone);
            
            if (customer != null) {
                customerId = customer.getId();
            } else {
                // Tạo khách hàng mới với thông tin cơ bản
                String customerName = request.getParameter("customerName");
                if (customerName == null || customerName.isEmpty()) {
                    customerName = "Khách hàng";
                }
                
                model.Users newUser = new model.Users();
                newUser.setUsername(customerPhone); // Username = phone
                newUser.setPassword("123456"); // Mật khẩu mặc định
                newUser.setName(customerName);
                newUser.setPhone(customerPhone);
                newUser.setRole("customer");
                
                customerId = customerDAO.register(newUser);
            }
        } else {
            request.setAttribute("errorMessage", "Không có thông tin khách hàng!");
            request.getRequestDispatcher("ConfirmUI.jsp").forward(request, response);
            return;
        }
        
        if (customerId == 0) {
            request.setAttribute("errorMessage", "Không thể tạo thông tin khách hàng!");
            request.getRequestDispatcher("ConfirmUI.jsp").forward(request, response);
            return;
        }
        
        // Tính tổng tiền
        DishDAO dishDAO = new DishDAO();
        BigDecimal totalAmount = BigDecimal.ZERO;
        
        for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
            Dish dish = dishDAO.getDishInfo(entry.getKey());
            if (dish != null) {
                BigDecimal lineTotal = dish.getPrice().multiply(BigDecimal.valueOf(entry.getValue()));
                totalAmount = totalAmount.add(lineTotal);
            }
        }
        
        // Tạo đơn hàng
        Order order = new Order();
        order.setTotalAmount(totalAmount);
        
        // Lưu hóa đơn
        BillDAO billDAO = new BillDAO();
        boolean success = billDAO.saveBill(order, customerId, selectedTable.getId(), staff.getId());
        
        if (success) {
            // Lưu chi tiết đơn hàng
            for (Map.Entry<Integer, Integer> entry : cart.entrySet()) {
                Dish dish = dishDAO.getDishInfo(entry.getKey());
                if (dish != null) {
                    BigDecimal lineTotal = dish.getPrice().multiply(BigDecimal.valueOf(entry.getValue()));
                    billDAO.saveOrderItem(order.getOrderID(), entry.getKey(), entry.getValue(), lineTotal);
                }
            }
            
            // Cập nhật trạng thái bàn
            dao.TableDAO tableDAO = new dao.TableDAO();
            tableDAO.updateTableStatus(selectedTable.getId(), "Đã đặt");
            
            // Lưu thông tin đơn hàng vào session
            session.setAttribute("order", order);
            
            // Xóa giỏ hàng và session data
            session.removeAttribute("cart");
            session.removeAttribute("selectedTable");
            session.removeAttribute("currentCustomer");
            session.removeAttribute("customerPhone");
            
            // Chuyển đến trang thông báo thành công
            response.sendRedirect("OrderSavedUI.jsp");
        } else {
            request.setAttribute("errorMessage", "Lưu đơn hàng thất bại!");
            request.getRequestDispatcher("ConfirmUI.jsp").forward(request, response);
        }
    }

    private void doViewBill(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        int billId = Integer.parseInt(request.getParameter("billId"));
        BillDAO billDAO = new BillDAO();
        
        Order order = billDAO.getBillById(billId);
        
        if (order != null) {
            List<OrderItem> orderItems = billDAO.getOrderItemsByBillId(billId);
            order.setOrderItems(orderItems);
            
            request.setAttribute("order", order);
            request.getRequestDispatcher("ViewBillUI.jsp").forward(request, response);
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy hóa đơn!");
            request.getRequestDispatcher("NotificationUI.jsp").forward(request, response);
        }
    }

    private void doViewHistory(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        BillDAO billDAO = new BillDAO();
        List<Bill> bills = billDAO.getAllBillsWithInfo();
        
        request.setAttribute("bills", bills);
        request.getRequestDispatcher("StaffOrderHistoryUI.jsp").forward(request, response);
    }
}
