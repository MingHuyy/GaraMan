package org.example.DAO;

import org.example.Model.Employee;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class EmployeeDAO extends DAO {

    public EmployeeDAO() {
        super();
    }

    public Employee validateLogin(String username, String password) {
        String sql = "SELECT * FROM employee WHERE username = ? AND password = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Employee employee = new Employee();
                    employee.setEmployeeId(rs.getInt("employee_id"));
                    employee.setUsername(rs.getString("username"));
                    employee.setPassword(rs.getString("password"));
                    employee.setPhone(rs.getString("phone"));
                    employee.setName(rs.getString("name"));
                    employee.setEmail(rs.getString("email"));
                    employee.setAddress(rs.getString("address"));
                    employee.setRole(rs.getString("role"));
                    return employee;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public Employee getEmployeeById(Integer employeeId) {
        String sql = "SELECT * FROM employee WHERE employee_id = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, employeeId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Employee employee = new Employee();
                    employee.setEmployeeId(rs.getInt("employee_id"));
                    employee.setUsername(rs.getString("username"));
                    employee.setPassword(rs.getString("password"));
                    employee.setPhone(rs.getString("phone"));
                    employee.setName(rs.getString("name"));
                    employee.setEmail(rs.getString("email"));
                    employee.setAddress(rs.getString("address"));
                    employee.setRole(rs.getString("role"));
                    return employee;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public Employee getEmployeeByUsername(String username) {
        String sql = "SELECT * FROM employee WHERE username = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Employee employee = new Employee();
                    employee.setEmployeeId(rs.getInt("employee_id"));
                    employee.setUsername(rs.getString("username"));
                    employee.setPassword(rs.getString("password"));
                    employee.setPhone(rs.getString("phone"));
                    employee.setName(rs.getString("name"));
                    employee.setEmail(rs.getString("email"));
                    employee.setAddress(rs.getString("address"));
                    employee.setRole(rs.getString("role"));
                    return employee;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
