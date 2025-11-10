package org.example.DAO;

import org.example.Model.Part;
import org.example.Model.SupplierPart;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

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
}
