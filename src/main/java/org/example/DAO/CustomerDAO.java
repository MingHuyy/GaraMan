package org.example.DAO;

import org.example.Model.Customer;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * DAO để thao tác với bảng Customer
 */
public class CustomerDAO extends DAO {
    
    public CustomerDAO() {
        super();
    }

    /**
     * Xác thực đăng nhập của Customer
     * 
     * @param username tên đăng nhập
     * @param password mật khẩu
     * @return Customer object nếu đăng nhập thành công, null nếu thất bại
     */
    public Customer validateLogin(String username, String password) {
        String sql = "SELECT * FROM employee WHERE username = ? AND password = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password); // TODO: Nên hash password trong thực tế

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setUsername(rs.getString("username"));
                    customer.setPassword(rs.getString("password"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setName(rs.getString("name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setAddress(rs.getString("address"));
                    return customer;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Lấy thông tin Customer theo ID
     * 
     * @param customerId ID của customer
     * @return Customer object hoặc null nếu không tìm thấy
     */
    public Customer getCustomerById(Integer customerId) {
        String sql = "SELECT * FROM Customer WHERE customer_id = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, customerId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setUsername(rs.getString("username"));
                    customer.setPassword(rs.getString("password"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setName(rs.getString("name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setAddress(rs.getString("address"));
                    return customer;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Lấy thông tin Customer theo username
     * 
     * @param username tên đăng nhập
     * @return Customer object hoặc null nếu không tìm thấy
     */
    public Customer getCustomerByUsername(String username) {
        String sql = "SELECT * FROM Customer WHERE username = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, username);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Customer customer = new Customer();
                    customer.setCustomerId(rs.getInt("customer_id"));
                    customer.setUsername(rs.getString("username"));
                    customer.setPassword(rs.getString("password"));
                    customer.setPhone(rs.getString("phone"));
                    customer.setName(rs.getString("name"));
                    customer.setEmail(rs.getString("email"));
                    customer.setAddress(rs.getString("address"));
                    return customer;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    /**
     * Thêm Customer mới (đăng ký)
     * 
     * @param customer Customer object
     * @return true nếu thêm thành công
     */
    public boolean addCustomer(Customer customer) {
        String sql = "INSERT INTO Customer (username, password, phone, name, email, address) VALUES (?, ?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, customer.getUsername());
            stmt.setString(2, customer.getPassword()); // TODO: Hash password
            stmt.setString(3, customer.getPhone());
            stmt.setString(4, customer.getName());
            stmt.setString(5, customer.getEmail());
            stmt.setString(6, customer.getAddress());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Cập nhật thông tin Customer
     * 
     * @param customer Customer object
     * @return true nếu cập nhật thành công
     */
    public boolean updateCustomer(Customer customer) {
        String sql = "UPDATE Customer SET username = ?, phone = ?, name = ?, email = ?, address = ? WHERE customer_id = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, customer.getUsername());
            stmt.setString(2, customer.getPhone());
            stmt.setString(3, customer.getName());
            stmt.setString(4, customer.getEmail());
            stmt.setString(5, customer.getAddress());
            stmt.setInt(6, customer.getCustomerId());

            return stmt.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
