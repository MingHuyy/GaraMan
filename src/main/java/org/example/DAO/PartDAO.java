package org.example.DAO;

import org.example.Model.Part;
import org.example.Model.SupplierPart;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO để thao tác với bảng Part và SupplierPart
 */
public class PartDAO {

    /**
     * Tìm kiếm phụ tùng theo tên
     * 
     * @param keyword từ khóa tìm kiếm
     * @return danh sách phụ tùng
     */
    public List<Part> searchByName(String keyword) {
        List<Part> parts = new ArrayList<>();
        String sql = "SELECT * FROM Part WHERE name LIKE ? ORDER BY name";

        try (Connection conn = DatabaseConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, "%" + keyword + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Part part = new Part();
                    part.setPartId(rs.getInt("part_id"));
                    part.setName(rs.getString("name"));
                    parts.add(part);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return parts;
    }

    /**
     * Lấy danh sách nhà cung cấp của một phụ tùng
     * 
     * @param partId ID của phụ tùng
     * @return danh sách SupplierPart
     */
    public List<SupplierPart> getSupplierPartsByPartId(Integer partId) {
        List<SupplierPart> supplierParts = new ArrayList<>();
        String sql = "SELECT * FROM SupplierPart WHERE part_id = ? ORDER BY unit_price";

        try (Connection conn = DatabaseConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, partId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    SupplierPart sp = new SupplierPart();
                    sp.setSupplierPartId(rs.getInt("supplier_part_id"));
                    sp.setDescription(rs.getString("description"));
                    sp.setUnitPrice(rs.getFloat("unit_price"));
                    sp.setStockQty(rs.getInt("stock_qty"));
                    sp.setSupplierId(rs.getInt("supplier_id"));
                    sp.setPartId(rs.getInt("part_id"));
                    supplierParts.add(sp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return supplierParts;
    }

    /**
     * Lấy tất cả phụ tùng
     * 
     * @return danh sách tất cả phụ tùng
     */
    public List<Part> getAllParts() {
        List<Part> parts = new ArrayList<>();
        String sql = "SELECT * FROM Part ORDER BY name";

        try (Connection conn = DatabaseConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql);
                ResultSet rs = stmt.executeQuery()) {

            while (rs.next()) {
                Part part = new Part();
                part.setPartId(rs.getInt("part_id"));
                part.setName(rs.getString("name"));
                parts.add(part);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return parts;
    }

    /**
     * Lấy phụ tùng theo ID
     * 
     * @param partId ID của phụ tùng
     * @return Part object hoặc null
     */
    public Part getPartById(Integer partId) {
        String sql = "SELECT * FROM Part WHERE part_id = ?";

        try (Connection conn = DatabaseConfig.getConnection();
                PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, partId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Part part = new Part();
                    part.setPartId(rs.getInt("part_id"));
                    part.setName(rs.getString("name"));
                    return part;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}
