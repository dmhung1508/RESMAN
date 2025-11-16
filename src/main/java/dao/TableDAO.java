package dao;

import model.Table;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class TableDAO extends DAO {

    public TableDAO() {
        super();
    }

    /**
     * Lấy danh sách tất cả các bàn
     * @return Danh sách Table
     */
    public List<Table> getAllTables() {
        List<Table> tables = new ArrayList<>();
        String sql = "SELECT * FROM tblTable ORDER BY ID";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Table table = new Table();
                table.setId(rs.getInt("ID"));
                table.setDescription(rs.getString("description"));
                table.setStatus(rs.getString("status"));
                tables.add(table);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return tables;
    }

    /**
     * Lấy thông tin bàn theo ID
     * @param id ID của bàn
     * @return Table object hoặc null
     */
    public Table getTableById(int id) {
        Table table = null;
        String sql = "SELECT * FROM tblTable WHERE ID = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            
            if (rs.next()) {
                table = new Table();
                table.setId(rs.getInt("ID"));
                table.setDescription(rs.getString("description"));
                table.setStatus(rs.getString("status"));
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return table;
    }

    /**
     * Lấy danh sách bàn theo trạng thái
     * @param status Trạng thái bàn ('Trống','Đã đặt','Đang dùng')
     * @return Danh sách Table
     */
    public List<Table> getTablesByStatus(String status) {
        List<Table> tables = new ArrayList<>();
        String sql = "SELECT * FROM tblTable WHERE status = ? ORDER BY ID";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ResultSet rs = ps.executeQuery();
            
            while (rs.next()) {
                Table table = new Table();
                table.setId(rs.getInt("ID"));
                table.setDescription(rs.getString("description"));
                table.setStatus(rs.getString("status"));
                tables.add(table);
            }
            
            rs.close();
            ps.close();
            
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return tables;
    }

    /**
     * Cập nhật trạng thái bàn
     * @param tableId ID của bàn
     * @param status Trạng thái mới
     * @return true nếu thành công, false nếu thất bại
     */
    public boolean updateTableStatus(int tableId, String status) {
        String sql = "UPDATE tblTable SET status = ? WHERE ID = ?";
        
        try {
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, status);
            ps.setInt(2, tableId);
            
            int rowsAffected = ps.executeUpdate();
            ps.close();
            
            return rowsAffected > 0;
            
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
