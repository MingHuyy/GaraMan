package org.example.DAO;

import org.example.Model.Service;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO để thao tác với bảng Service
 */
public class ServiceDAO extends DAO {
    
    public ServiceDAO() {
        super();
    }

    /**
     * Tìm kiếm dịch vụ theo tên
     * 
     * @param keyword từ khóa tìm kiếm
     * @return danh sách dịch vụ
     */
    public List<Service> searchByName(String keyword) {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service WHERE name LIKE ? ORDER BY name";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setString(1, "%" + keyword + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Service service = new Service();
                    service.setServiceId(rs.getInt("service_id"));
                    service.setName(rs.getString("name"));
                    service.setDescription(rs.getString("description"));
                    service.setPrice(rs.getFloat("price"));
                    service.setDuration(rs.getInt("duration"));
                    services.add(service);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return services;
    }

    /**
     * Lấy tất cả dịch vụ
     * 
     * @return danh sách tất cả dịch vụ
     */
    public List<Service> getAllServices() {
        List<Service> services = new ArrayList<>();
        String sql = "SELECT * FROM Service ORDER BY name";

        try (PreparedStatement stmt = con.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Service service = new Service();
                service.setServiceId(rs.getInt("service_id"));
                service.setName(rs.getString("name"));
                service.setDescription(rs.getString("description"));
                service.setPrice(rs.getFloat("price"));
                service.setDuration(rs.getInt("duration"));
                services.add(service);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return services;
    }

    /**
     * Lấy dịch vụ theo ID
     * 
     * @param serviceId ID của dịch vụ
     * @return Service object hoặc null
     */
    public Service getServiceById(Integer serviceId) {
        String sql = "SELECT * FROM Service WHERE service_id = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, serviceId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Service service = new Service();
                    service.setServiceId(rs.getInt("service_id"));
                    service.setName(rs.getString("name"));
                    service.setDescription(rs.getString("description"));
                    service.setPrice(rs.getFloat("price"));
                    service.setDuration(rs.getInt("duration"));
                    return service;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
