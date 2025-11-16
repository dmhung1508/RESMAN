package dao;

import model.Staff;
import model.Users;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class StaffDAO extends DAO {

    public StaffDAO() {
        super();
    }

    /**
     * Đăng nhập cho staff
     * @param username Tên đăng nhập
     * @param password Mật khẩu
     * @return Staff nếu đăng nhập thành công, null nếu thất bại
     */
    public Staff login(String username, String password) {
        Staff staff = null;
        String sql = "SELECT s.*, u.* FROM tblStaff s " +
                    "JOIN tblUser u ON s.ID = u.ID " +
                    "WHERE u.username = ? AND u.password = ? AND u.role = 'staff'";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                staff = new Staff();
                staff.setId(rs.getInt("ID"));
                staff.setPosition(rs.getString("position"));
                
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
                
                staff.setUser(user);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return staff;
    }

    /**
     * Đăng ký tài khoản staff mới
     * @param user Thông tin user
     * @param position Vị trí (manager/cashier/waiter/chef)
     * @return true nếu đăng ký thành công, false nếu thất bại
     */
    public boolean register(Users user, String position) {
        try {
            // Insert vào bảng tblUser trước với role='staff'
            String sqlUser = "INSERT INTO tblUser (username, password, name, `date`, address, phone, role) " +
                           "VALUES (?, ?, ?, ?, ?, ?, 'staff')";
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
                return false;
            }
            
            // Lấy ID vừa tạo
            ResultSet rs = psUser.getGeneratedKeys();
            int userId = 0;
            if (rs.next()) {
                userId = rs.getInt(1);
            }
            rs.close();
            psUser.close();
            
            // Insert vào bảng tblStaff
            String sqlStaff = "INSERT INTO tblStaff (ID, position) VALUES (?, ?)";
            PreparedStatement psStaff = con.prepareStatement(sqlStaff);
            psStaff.setInt(1, userId);
            psStaff.setString(2, position);
            
            int staffRows = psStaff.executeUpdate();
            psStaff.close();
            
            return staffRows > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Kiểm tra username đã tồn tại chưa
     * @param username Tên đăng nhập cần kiểm tra
     * @return true nếu đã tồn tại, false nếu chưa
     */
    public boolean checkUsernameExists(String username) {
        String sql = "SELECT COUNT(*) FROM tblUser WHERE username = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, username);
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

