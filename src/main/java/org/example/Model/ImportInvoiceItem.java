package org.example.Model;

import java.io.Serializable;

/**
 * Model ImportInvoiceItem - Chi tiết hóa đơn nhập
 * Liên kết với SupplierPart thay vì chỉ Part (để nhập đúng loại hàng của nhà
 * cung cấp)
 */
public class ImportInvoiceItem implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer importItemId;
    private Integer qty; // Số lượng nhập
    private Float unitPrice; // Đơn giá nhập
    private Float lineAmount; // Thành tiền (qty * unitPrice)

    // Foreign keys
    private Integer importId; // FK to ImportInvoice
    private Integer supplierPartId;// FK to SupplierPart

    // Constructors

    public ImportInvoiceItem() {
    }

    public ImportInvoiceItem(Integer qty, Float unitPrice, Float lineAmount, Integer importId, Integer supplierPartId) {
        this.qty = qty;
        this.unitPrice = unitPrice;
        this.lineAmount = lineAmount;
        this.importId = importId;
        this.supplierPartId = supplierPartId;
    }

    // Getters and Setters

    public Integer getImportItemId() {
        return importItemId;
    }

    public void setImportItemId(Integer importItemId) {
        this.importItemId = importItemId;
    }

    public Integer getQty() {
        return qty;
    }

    public void setQty(Integer qty) {
        this.qty = qty;
    }

    public Float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Float getLineAmount() {
        return lineAmount;
    }

    public void setLineAmount(Float lineAmount) {
        this.lineAmount = lineAmount;
    }

    public Integer getImportId() {
        return importId;
    }

    public void setImportId(Integer importId) {
        this.importId = importId;
    }

    public Integer getSupplierPartId() {
        return supplierPartId;
    }

    public void setSupplierPartId(Integer supplierPartId) {
        this.supplierPartId = supplierPartId;
    }

    @Override
    public String toString() {
        return "ImportInvoiceItem{" +
                "importItemId=" + importItemId +
                ", qty=" + qty +
                ", unitPrice=" + unitPrice +
                ", lineAmount=" + lineAmount +
                ", importId=" + importId +
                ", supplierPartId=" + supplierPartId +
                '}';
    }
}
