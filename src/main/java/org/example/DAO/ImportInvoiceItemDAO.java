package org.example.DAO;

import org.example.Model.ImportInvoiceItem;

import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ImportInvoiceItemDAO extends DAO{
    public ImportInvoiceItemDAO(){
        super();
    }

    public boolean createImportInvoiceItem(ImportInvoiceItem item) {
        String sql = "INSERT INTO ImportInvoiceItem (qty, unit_price, line_amount, import_id, supplier_part_id) " +
                "VALUES (?, ?, ?, ?, ?)";

        try (PreparedStatement stmt = con.prepareStatement(sql)) {

            stmt.setInt(1, item.getQty());
            stmt.setFloat(2, item.getUnitPrice());
            stmt.setFloat(3, item.getLineAmount());
            stmt.setInt(4, item.getImportId());
            stmt.setInt(5, item.getSupplierPartId());

            return stmt.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
}
