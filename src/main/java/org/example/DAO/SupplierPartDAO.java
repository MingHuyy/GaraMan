package org.example.DAO;

import org.example.Model.SupplierPart;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class SupplierPartDAO extends DAO {
    
    public SupplierPartDAO() {
        super();
    }


    public List<SupplierPart> searchByPartKeyword(String keyword) {
        List<SupplierPart> supplierParts = new ArrayList<>();
        
        String sql = "SELECT sp.supplier_part_id, sp.description, sp.price, sp.quantity, " +
                     "sp.supplier_id, sp.part_id, " +
                     "p.name as part_name, s.name as supplier_name " +
                     "FROM SupplierPart sp " +
                     "JOIN Part p ON sp.part_id = p.part_id " +
                     "JOIN Supplier s ON sp.supplier_id = s.supplier_id " +
                     "WHERE p.name LIKE ? " +
                     "ORDER BY p.name, s.name";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    SupplierPart sp = new SupplierPart();
                    sp.setSupplierPartId(rs.getInt("supplier_part_id"));
                    sp.setDescription(rs.getString("description"));
                    sp.setPrice(rs.getFloat("price"));
                    sp.setQuantity(rs.getInt("quantity"));
                    sp.setSupplierId(rs.getInt("supplier_id"));
                    sp.setPartId(rs.getInt("part_id"));

                    sp.setPartName(rs.getString("part_name"));
                    sp.setSupplierName(rs.getString("supplier_name"));
                    
                    supplierParts.add(sp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return supplierParts;
    }

    public List<SupplierPart> searchByPartKeywordAndSupplier(String keyword, Integer supplierId) {
        List<SupplierPart> supplierParts = new ArrayList<>();
        
        String sql = "SELECT sp.supplier_part_id, sp.description, sp.price, sp.quantity, " +
                     "sp.supplier_id, sp.part_id, " +
                     "p.name as part_name, s.name as supplier_name " +
                     "FROM SupplierPart sp " +
                     "JOIN Part p ON sp.part_id = p.part_id " +
                     "JOIN Supplier s ON sp.supplier_id = s.supplier_id " +
                     "WHERE p.name LIKE ? AND sp.supplier_id = ? " +
                     "ORDER BY p.name";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setString(1, "%" + keyword + "%");
            stmt.setInt(2, supplierId);

            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    SupplierPart sp = new SupplierPart();
                    sp.setSupplierPartId(rs.getInt("supplier_part_id"));
                    sp.setDescription(rs.getString("description"));
                    sp.setPrice(rs.getFloat("price"));
                    sp.setQuantity(rs.getInt("quantity"));
                    sp.setSupplierId(rs.getInt("supplier_id"));
                    sp.setPartId(rs.getInt("part_id"));

                    sp.setPartName(rs.getString("part_name"));
                    sp.setSupplierName(rs.getString("supplier_name"));
                    
                    supplierParts.add(sp);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return supplierParts;
    }

    public SupplierPart getSupplierPartById(Integer supplierPartId) {
        String sql = "SELECT sp.*, p.name as part_name, s.name as supplier_name " +
                     "FROM SupplierPart sp " +
                     "JOIN Part p ON sp.part_id = p.part_id " +
                     "JOIN Supplier s ON sp.supplier_id = s.supplier_id " +
                     "WHERE sp.supplier_part_id = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, supplierPartId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    SupplierPart sp = new SupplierPart();
                    sp.setSupplierPartId(rs.getInt("supplier_part_id"));
                    sp.setDescription(rs.getString("description"));
                    sp.setPrice(rs.getFloat("price"));
                    sp.setQuantity(rs.getInt("quantity"));
                    sp.setSupplierId(rs.getInt("supplier_id"));
                    sp.setPartId(rs.getInt("part_id"));
                    sp.setPartName(rs.getString("part_name"));
                    sp.setSupplierName(rs.getString("supplier_name"));
                    return sp;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    public boolean updateQuantity(Integer supplierPartId, Integer quantityToAdd) {
        String sql = "UPDATE SupplierPart SET quantity = quantity + ? WHERE supplier_part_id = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, quantityToAdd);
            stmt.setInt(2, supplierPartId);

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}

