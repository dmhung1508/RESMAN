package controller;

import dao.DishDAO;
import model.Dish;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "DishController", urlPatterns = {"/DishController"})
public class DishController extends HttpServlet {

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
        DishDAO dishDAO = new DishDAO();
        
        if (action == null) {
            action = "list";
        }
        
        switch (action) {
            case "search":
                doSearch(request, response, dishDAO);
                break;
            case "searchForOrder":
                doSearchForOrder(request, response, dishDAO);
                break;
            case "edit":
                doEdit(request, response, dishDAO);
                break;
            case "update":
                doUpdate(request, response, dishDAO);
                break;
            case "listForOrder":
                doListForOrder(request, response, dishDAO);
                break;
            default:
                doList(request, response, dishDAO);
                break;
        }
    }

    private void doSearch(HttpServletRequest request, HttpServletResponse response, DishDAO dishDAO)
            throws ServletException, IOException {
        
        String dishName = request.getParameter("dishName");
        List<Dish> dishList = dishDAO.getDishListByName(dishName);
        
        request.setAttribute("dishList", dishList);
        request.setAttribute("searchName", dishName);
        request.getRequestDispatcher("ManageDishUI.jsp").forward(request, response);
    }

    private void doSearchForOrder(HttpServletRequest request, HttpServletResponse response, DishDAO dishDAO)
            throws ServletException, IOException {
        
        String searchTerm = request.getParameter("searchTerm");
        List<Dish> dishList;
        
        // Tìm theo tên hoặc loại trong cùng 1 ô search
        if (searchTerm != null && !searchTerm.trim().isEmpty()) {
            dishList = dishDAO.searchDishByNameOrType(searchTerm.trim());
        } else {
            dishList = dishDAO.getAllDishes();
        }
        
        request.setAttribute("dishList", dishList);
        request.getRequestDispatcher("SelectDish.jsp").forward(request, response);
    }

    private void doListForOrder(HttpServletRequest request, HttpServletResponse response, DishDAO dishDAO)
            throws ServletException, IOException {
        
        List<Dish> dishList = dishDAO.getAllDishes();
        request.setAttribute("dishList", dishList);
        request.getRequestDispatcher("SelectDish.jsp").forward(request, response);
    }

    private void doEdit(HttpServletRequest request, HttpServletResponse response, DishDAO dishDAO)
            throws ServletException, IOException {
        
        int dishID = Integer.parseInt(request.getParameter("dishID"));
        Dish dish = dishDAO.getDishInfo(dishID);
        
        request.setAttribute("dish", dish);
        request.getRequestDispatcher("EditDishUI.jsp").forward(request, response);
    }

    private void doUpdate(HttpServletRequest request, HttpServletResponse response, DishDAO dishDAO)
            throws ServletException, IOException {
        
        int dishID = Integer.parseInt(request.getParameter("dishID"));
        String name = request.getParameter("txtDishName");
        java.math.BigDecimal price = new java.math.BigDecimal(request.getParameter("txtPrice"));
        String description = request.getParameter("txtDescription");
        String type = request.getParameter("txtType");
        String status = request.getParameter("cbStatus");
        
        Dish dish = new Dish(dishID, name, price, type, status, description);
        boolean success = dishDAO.updateDish(dish);
        
        // Lấy danh sách món ăn để hiển thị
        List<Dish> dishList = dishDAO.getAllDishes();
        request.setAttribute("dishList", dishList);
        
        if (success) {
            request.setAttribute("successMessage", "Cập nhật món ăn thành công!");
        } else {
            request.setAttribute("errorMessage", "Cập nhật món ăn thất bại!");
        }
        
        request.getRequestDispatcher("ManageDishUI.jsp").forward(request, response);
    }

    private void doList(HttpServletRequest request, HttpServletResponse response, DishDAO dishDAO)
            throws ServletException, IOException {
        
        List<Dish> dishList = dishDAO.getAllDishes();
        request.setAttribute("dishList", dishList);
        request.getRequestDispatcher("ManageDishUI.jsp").forward(request, response);
    }
}

