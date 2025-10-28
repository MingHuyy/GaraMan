package org.example.DAO;

import org.example.Model.Supplier;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * DAO để thao tác với bảng Supplier
 */
public class SupplierDAO extends DAO {
    
    public SupplierDAO() {
        super();
    }

    /**
     * Lấy Supplier theo ID
     */
    public Supplier getSupplierById(Integer supplierId) {
        String sql = "SELECT * FROM Supplier WHERE supplier_id = ?";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {
            stmt.setInt(1, supplierId);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    Supplier supplier = new Supplier();
                    supplier.setSupplierId(rs.getInt("supplier_id"));
                    supplier.setName(rs.getString("name"));
                    supplier.setPhone(rs.getString("phone"));
                    supplier.setEmail(rs.getString("email"));
                    supplier.setAddress(rs.getString("address"));
                    return supplier;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }
}

