package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DAO {
    protected Connection con;

    public DAO() {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
            
            // Database connection parameters
            String url = "jdbc:mysql://localhost:3306/resmanto";
            String username = "root";
            String password = "hung1234";
            
            // Create connection
            con = DriverManager.getConnection(url, username, password);
            
        } catch (ClassNotFoundException e) {    
            System.err.println("MySQL JDBC Driver not found!");
            e.printStackTrace();
        } catch (SQLException e) {
            System.err.println("Connection failed!");
            e.printStackTrace();
        }
    }

    public Connection getConnection() {
        return con;
    }

    public void closeConnection() {
        if (con != null) {
            try {
                con.close();
            } catch (SQLException e) {
                e.printStackTrace();
            }
        }
    }
}

