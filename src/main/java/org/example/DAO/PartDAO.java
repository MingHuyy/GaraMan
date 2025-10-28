package org.example.DAO;

import org.example.Model.Part;
import org.example.Model.SupplierPart;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 * DAO để thao tác với bảng Part và SupplierPart
 */
public class PartDAO extends DAO {
    
    public PartDAO() {
        super();
    }

    public List<Part> searchByName(String keyword) {
        List<Part> parts = new ArrayList<>();
        String sql = "SELECT * FROM Part WHERE name LIKE ? ORDER BY name";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

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

    public List<SupplierPart> getSupplierPartsByPartId(Integer partId) {
        List<SupplierPart> supplierParts = new ArrayList<>();
        String sql = "SELECT * FROM SupplierPart WHERE part_id = ? ORDER BY price";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, partId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    SupplierPart sp = new SupplierPart();
                    sp.setSupplierPartId(rs.getInt("supplier_part_id"));
                    sp.setDescription(rs.getString("description"));
                    sp.setPrice(rs.getFloat("price"));
                    sp.setQuantity(rs.getInt("quantity"));
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

    public List<Part> getAllParts() {
        List<Part> parts = new ArrayList<>();
        String sql = "SELECT * FROM Part ORDER BY name";

        try (PreparedStatement stmt = con.prepareStatement(sql);
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


    public Part getPartById(Integer partId) {
        String sql = "SELECT * FROM Part WHERE part_id = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

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
