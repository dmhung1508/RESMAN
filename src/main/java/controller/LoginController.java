package controller;

import dao.StaffDAO;
import model.Staff;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

@WebServlet(name = "LoginController", urlPatterns = {"/LoginController"})
public class LoginController extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Hiển thị trang login
        request.getRequestDispatcher("Login.jsp").forward(request, response);
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        StaffDAO staffDAO = new StaffDAO();
        Staff staff = staffDAO.login(username, password);
        
        if (staff != null) {
            // Đăng nhập thành công
            HttpSession session = request.getSession();
            session.setAttribute("staff", staff);
            session.setAttribute("staffID", staff.getId());
            session.setAttribute("username", staff.getUser().getUsername());
            session.setAttribute("fullname", staff.getUser().getName());
            session.setAttribute("position", staff.getPosition());
            session.setAttribute("role", staff.getUser().getRole()); // Thêm role vào session
            
            // Chuyển hướng đến trang quản lý
            response.sendRedirect("MainStaffUI.jsp");
        } else {
            // Đăng nhập thất bại
            request.setAttribute("errorMessage", "Tên đăng nhập hoặc mật khẩu không đúng!");
            request.getRequestDispatcher("Login.jsp").forward(request, response);
        }
    }
}


