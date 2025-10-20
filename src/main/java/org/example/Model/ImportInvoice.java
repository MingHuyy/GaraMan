package org.example.Model;

import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Model ImportInvoice - Hóa đơn nhập phụ tùng
 */
public class ImportInvoice implements Serializable {
    
    private static final long serialVersionUID = 1L;
    
    private Integer importId;
    private Date date;             // Ngày nhập
    private Float totalAmount;     // Tổng tiền
    private String status;         // PENDING, COMPLETED, CANCELLED
    
    // Foreign keys
    private Integer supplierId;    // FK to Supplier
    private Integer employeeId;    // FK to Employee
    
    // List chi tiết
    private List<ImportInvoiceItem> listImportInvoiceItem;
    
    // Constructors
    
    public ImportInvoice() {
    }
    
    public ImportInvoice(Date date, Float totalAmount, String status) {
        this.date = date;
        this.totalAmount = totalAmount;
        this.status = status;
    }
    
    // Getters and Setters
    
    public Integer getImportId() {
        return importId;
    }
    
    public void setImportId(Integer importId) {
        this.importId = importId;
    }
    
    public Date getDate() {
        return date;
    }
    
    public void setDate(Date date) {
        this.date = date;
    }
    
    public Float getTotalAmount() {
        return totalAmount;
    }
    
    public void setTotalAmount(Float totalAmount) {
        this.totalAmount = totalAmount;
    }
    
    public String getStatus() {
        return status;
    }
    
    public void setStatus(String status) {
        this.status = status;
    }
    
    public Integer getSupplierId() {
        return supplierId;
    }
    
    public void setSupplierId(Integer supplierId) {
        this.supplierId = supplierId;
    }
    
    public Integer getEmployeeId() {
        return employeeId;
    }
    
    public void setEmployeeId(Integer employeeId) {
        this.employeeId = employeeId;
    }
    
    public List<ImportInvoiceItem> getListImportInvoiceItem() {
        return listImportInvoiceItem;
    }
    
    public void setListImportInvoiceItem(List<ImportInvoiceItem> listImportInvoiceItem) {
        this.listImportInvoiceItem = listImportInvoiceItem;
    }
    
    @Override
    public String toString() {
        return "ImportInvoice{" +
                "importId=" + importId +
                ", date=" + date +
                ", totalAmount=" + totalAmount +
                ", status='" + status + '\'' +
                '}';
    }
}

