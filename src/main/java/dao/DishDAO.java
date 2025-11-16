package dao;

import model.Dish;
import java.math.BigDecimal;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class DishDAO extends DAO {

    public DishDAO() {
        super();
    }

    /**
     * Lấy danh sách món ăn theo tên
     * @param name Tên món ăn cần tìm
     * @return Danh sách món ăn
     */
    public List<Dish> getDishListByName(String name) {
        List<Dish> dishList = new ArrayList<>();
        String sql = "SELECT * FROM tblDish WHERE name LIKE ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, "%" + name + "%");
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Dish dish = new Dish();
                dish.setId(rs.getInt("ID"));
                dish.setName(rs.getString("name"));
                dish.setPrice(BigDecimal.valueOf(rs.getFloat("price")));
                dish.setType(rs.getString("type"));
                dish.setStatus(rs.getString("status"));
                dish.setDescription(rs.getString("description"));
                dish.setDishComboID(rs.getObject("DishComboID", Integer.class));
                dishList.add(dish);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return dishList;
    }

    /**
     * Lấy thông tin chi tiết một món ăn
     * @return Đối tượng Dish
     */
    public Dish getDishInfo(int dishID) {
        Dish dish = null;
        String sql = "SELECT * FROM tblDish WHERE ID = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, dishID);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                dish = new Dish();
                dish.setId(rs.getInt("ID"));
                dish.setName(rs.getString("name"));
                dish.setPrice(BigDecimal.valueOf(rs.getFloat("price")));
                dish.setType(rs.getString("type"));
                dish.setStatus(rs.getString("status"));
                dish.setDescription(rs.getString("description"));
                dish.setDishComboID(rs.getObject("DishComboID", Integer.class));
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return dish;
    }

    /**
     * Cập nhật thông tin món ăn
     * @param dish Đối tượng Dish cần cập nhật
     * @return true nếu cập nhật thành công, false nếu thất bại
     */
    public boolean updateDish(Dish dish) {
        String sql = "UPDATE tblDish SET name = ?, price = ?, type = ?, status = ?, description = ? WHERE ID = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, dish.getName());
            ps.setFloat(2, dish.getPrice().floatValue());
            ps.setString(3, dish.getType());
            ps.setString(4, dish.getStatus());
            ps.setString(5, dish.getDescription());
            ps.setInt(6, dish.getId());
            
            int rowsAffected = ps.executeUpdate();
            ps.close();
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Lấy tất cả món ăn
     * @return Danh sách tất cả món ăn
     */
    public List<Dish> getAllDishes() {
        List<Dish> dishList = new ArrayList<>();
        String sql = "SELECT * FROM tblDish";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Dish dish = new Dish();
                dish.setId(rs.getInt("ID"));
                dish.setName(rs.getString("name"));
                dish.setPrice(BigDecimal.valueOf(rs.getFloat("price")));
                dish.setType(rs.getString("type"));
                dish.setStatus(rs.getString("status"));
                dish.setDescription(rs.getString("description"));
                dish.setDishComboID(rs.getObject("DishComboID", Integer.class));
                dishList.add(dish);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return dishList;
    }

    /**
     * Lấy món ăn theo ID
     * @param id ID của món ăn
     * @return Đối tượng Dish
     */
    public Dish getDishInfoId(int id) {
        return getDishInfo(id);
    }

    /**
     * Lấy danh sách món ăn theo loại
     * @param dishType Loại món ăn (Món chính, Khai vị, etc.)
     * @return Danh sách các món ăn thuộc loại đó
     */
    public List<Dish> getDishListByType(String dishType) {
        List<Dish> dishList = new ArrayList<>();
        String sql = "SELECT * FROM tblDish WHERE type = ? AND status = 'Còn món'";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, dishType);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Dish dish = new Dish();
                dish.setId(rs.getInt("ID"));
                dish.setName(rs.getString("name"));
                dish.setPrice(BigDecimal.valueOf(rs.getFloat("price")));
                dish.setType(rs.getString("type"));
                dish.setStatus(rs.getString("status"));
                dish.setDescription(rs.getString("description"));
                dish.setDishComboID(rs.getObject("DishComboID", Integer.class));
                dishList.add(dish);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return dishList;
    }

    /**
     * Tìm món ăn theo tên HOẶC loại (tìm trong cùng 1 từ khóa)
     * @param searchTerm Từ khóa tìm kiếm (có thể là tên hoặc loại)
     * @return Danh sách các món ăn khớp với tên hoặc loại
     */
    public List<Dish> searchDishByNameOrType(String searchTerm) {
        List<Dish> dishList = new ArrayList<>();
        String sql = "SELECT * FROM tblDish WHERE (name LIKE ? OR type LIKE ?) AND status = 'Còn món'";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            String searchPattern = "%" + searchTerm + "%";
            ps.setString(1, searchPattern);
            ps.setString(2, searchPattern);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Dish dish = new Dish();
                dish.setId(rs.getInt("ID"));
                dish.setName(rs.getString("name"));
                dish.setPrice(BigDecimal.valueOf(rs.getFloat("price")));
                dish.setType(rs.getString("type"));
                dish.setStatus(rs.getString("status"));
                dish.setDescription(rs.getString("description"));
                dish.setDishComboID(rs.getObject("DishComboID", Integer.class));
                dishList.add(dish);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return dishList;
    }
}

