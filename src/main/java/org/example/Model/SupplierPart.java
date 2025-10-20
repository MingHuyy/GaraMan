package org.example.Model;

import java.io.Serializable;

/**
 * Model SupplierPart - Bảng trung gian giữa Supplier và Part (n-n chi tiết)
 * Lưu thông tin riêng của mỗi phụ tùng theo từng nhà cung cấp
 */
public class SupplierPart implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer supplierPartId;
    private String description;
    private Float unitPrice; // Giá từ nhà cung cấp
    private Integer stockQty; // Số lượng tồn kho

    // Foreign keys
    private Integer supplierId; // FK to Supplier
    private Integer partId; // FK to Part

    // Constructors

    public SupplierPart() {
    }

    public SupplierPart(String description, Float unitPrice, Integer stockQty, Integer supplierId, Integer partId) {
        this.description = description;
        this.unitPrice = unitPrice;
        this.stockQty = stockQty;
        this.supplierId = supplierId;
        this.partId = partId;
    }

    // Getters and Setters

    public Integer getSupplierPartId() {
        return supplierPartId;
    }

    public void setSupplierPartId(Integer supplierPartId) {
        this.supplierPartId = supplierPartId;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Float getUnitPrice() {
        return unitPrice;
    }

    public void setUnitPrice(Float unitPrice) {
        this.unitPrice = unitPrice;
    }

    public Integer getStockQty() {
        return stockQty;
    }

    public void setStockQty(Integer stockQty) {
        this.stockQty = stockQty;
    }

    public Integer getSupplierId() {
        return supplierId;
    }

    public void setSupplierId(Integer supplierId) {
        this.supplierId = supplierId;
    }

    public Integer getPartId() {
        return partId;
    }

    public void setPartId(Integer partId) {
        this.partId = partId;
    }

    @Override
    public String toString() {
        return "SupplierPart{" +
                "supplierPartId=" + supplierPartId +
                ", description='" + description + '\'' +
                ", unitPrice=" + unitPrice +
                ", stockQty=" + stockQty +
                ", supplierId=" + supplierId +
                ", partId=" + partId +
                '}';
    }
}
