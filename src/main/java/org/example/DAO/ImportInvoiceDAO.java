package org.example.DAO;

import org.example.Model.ImportInvoice;
import org.example.Model.ImportInvoiceItem;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.Date;

public class ImportInvoiceDAO extends DAO {
    
    public ImportInvoiceDAO() {
        super();
    }

    public int createImportInvoice(ImportInvoice invoice) {
        String sql = "INSERT INTO ImportInvoice (invoice_code, date, total_amount, status, supplier_id, employee_id) " +
                     "VALUES (?, ?, ?, ?, ?, ?)";
        
        try (PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            stmt.setString(1, invoice.getInvoiceCode());
            stmt.setDate(2, new java.sql.Date(invoice.getDate().getTime()));
            stmt.setFloat(3, invoice.getTotalAmount());
            stmt.setString(4, invoice.getStatus());
            stmt.setInt(5, invoice.getSupplierId());
            stmt.setInt(6, invoice.getEmployeeId());
            
            int affectedRows = stmt.executeUpdate();
            
            if (affectedRows > 0) {
                // Lấy ID vừa được tạo
                try (ResultSet rs = stmt.getGeneratedKeys()) {
                    if (rs.next()) {
                        return rs.getInt(1);
                    }
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return -1;
    }
}

