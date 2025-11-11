package org.example.Model;

import java.io.Serializable;

public class ImportInvoiceItem implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer importItemId;
    private Integer qty;
    private float unitPrice;
    private Float lineAmount;
    private Integer importId;
    private SupplierPart supplierPart;

    public ImportInvoiceItem() {
    }

    public ImportInvoiceItem(Integer qty, Float unitPrice, Float lineAmount, Integer importId, SupplierPart supplierPart) {
        this.qty = qty;
        this.unitPrice = unitPrice;
        this.lineAmount = lineAmount;
        this.importId = importId;
        this.supplierPart = supplierPart;
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

    public float getUnitPrice() {
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

    public SupplierPart getSupplierPart() {
        return supplierPart;
    }

    public void setSupplierPart(SupplierPart supplierPart) {
        this.supplierPart = supplierPart;
    }
    
    // Helper method để lấy supplierPartId từ object
    public Integer getSupplierPartId() {
        return supplierPart != null ? supplierPart.getSupplierPartId() : null;
    }

    public void calculateLineAmount() {
        this.lineAmount = this.qty * this.unitPrice;
    }
}
