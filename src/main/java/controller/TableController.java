package controller;

import dao.TableDAO;
import dao.CustomerDAO;
import model.Table;
import model.Customer;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "TableController", urlPatterns = {"/TableController"})
public class TableController extends HttpServlet {

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
        TableDAO tableDAO = new TableDAO();
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "searchByCustomer":
                doSearchByCustomer(request, response, tableDAO);
                break;
            case "search":
                doSearch(request, response, tableDAO);
                break;
            case "select":
                doSelectTable(request, response, tableDAO);
                break;
            case "updateStatus":
                doUpdateStatus(request, response, tableDAO);
                break;
            default:
                doList(request, response, tableDAO);
                break;
        }
    }

    private void doSearchByCustomer(HttpServletRequest request, HttpServletResponse response, TableDAO tableDAO)
            throws ServletException, IOException {
        
        String customerInfo = request.getParameter("customerInfo");
        CustomerDAO customerDAO = new CustomerDAO();
        HttpSession session = request.getSession();
        
        // Tìm khách hàng theo SĐT hoặc tên
        Customer customer = customerDAO.getCustomerByPhone(customerInfo);
        
        if (customer != null) {
            // Lưu customer vào session để dùng khi lưu bill
            session.setAttribute("currentCustomer", customer);
            
            // Tìm các bàn đã đặt của khách hàng này
            // Giả sử bàn đã đặt được lưu trong session hoặc database
            // Tạm thời trả về bàn có status "Đã đặt"
            List<Table> foundTables = tableDAO.getTablesByStatus("Đã đặt");
            request.setAttribute("foundTables", foundTables);
        } else {
            // Nếu không tìm thấy, lưu phone vào session để tạo customer mới sau
            session.setAttribute("customerPhone", customerInfo);
            request.setAttribute("foundTables", new java.util.ArrayList<Table>());
            request.setAttribute("message", "Khách hàng mới, vui lòng chọn bàn và đặt món!");
        }
        
        request.getRequestDispatcher("SearchTableUI.jsp").forward(request, response);
    }

    private void doSearch(HttpServletRequest request, HttpServletResponse response, TableDAO tableDAO)
            throws ServletException, IOException {
        
        String status = request.getParameter("status");
        List<Table> tableList;
        
        if (status != null && !status.isEmpty()) {
            tableList = tableDAO.getTablesByStatus(status);
        } else {
            tableList = tableDAO.getAllTables();
        }
        
        request.setAttribute("tableList", tableList);
        request.setAttribute("searchStatus", status);
        request.getRequestDispatcher("SearchTableUI.jsp").forward(request, response);
    }

    private void doSelectTable(HttpServletRequest request, HttpServletResponse response, TableDAO tableDAO)
            throws ServletException, IOException {
        
        HttpSession session = request.getSession();
        int tableId = Integer.parseInt(request.getParameter("tableId"));
        
        Table table = tableDAO.getTableById(tableId);
        
        if (table != null) {
            session.setAttribute("selectedTable", table);
            response.sendRedirect("SelectDish.jsp");
        } else {
            request.setAttribute("errorMessage", "Không tìm thấy bàn!");
            request.getRequestDispatcher("SearchTableUI.jsp").forward(request, response);
        }
    }

    private void doUpdateStatus(HttpServletRequest request, HttpServletResponse response, TableDAO tableDAO)
            throws ServletException, IOException {
        
        int tableId = Integer.parseInt(request.getParameter("tableId"));
        String status = request.getParameter("status");
        
        boolean success = tableDAO.updateTableStatus(tableId, status);
        
        if (success) {
            request.setAttribute("message", "Cập nhật trạng thái bàn thành công!");
        } else {
            request.setAttribute("message", "Cập nhật trạng thái bàn thất bại!");
        }
        
        request.getRequestDispatcher("NotificationUI.jsp").forward(request, response);
    }

    private void doList(HttpServletRequest request, HttpServletResponse response, TableDAO tableDAO)
            throws ServletException, IOException {
        
        List<Table> tableList = tableDAO.getAllTables();
        request.setAttribute("tableList", tableList);
        request.getRequestDispatcher("SearchTableUI.jsp").forward(request, response);
    }
}
