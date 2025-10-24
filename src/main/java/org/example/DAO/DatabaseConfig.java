package org.example.DAO;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Cấu hình kết nối Database
 */
public class DatabaseConfig {

    private static final String URL = "jdbc:mysql://localhost:3306/GaraMan";
    private static final String USERNAME = "root";
    private static final String PASSWORD = "lohuyls123"; // Thay đổi password của bạn ở đây

    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USERNAME, PASSWORD);
    }
}
