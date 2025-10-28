package org.example.Model;

import java.io.Serializable;

/**
 * Model SupplierPart - Bảng trung gian giữa Supplier và Part (n-n chi tiết)
 * Lưu thông tin riêng của mỗi phụ tùng theo từng nhà cung cấp
 */
public class SupplierPart implements Serializable {

    private static final long serialVersionUID = 1L;

    private int supplierPartId;
    private String description;
    private float price;
    private int quantity;

    // Foreign keys
    private Integer supplierId; // FK to Supplier
    private Integer partId; // FK to Part
    
    // Thông tin bổ sung (không lưu DB, chỉ dùng để hiển thị)
    private transient String partName;
    private transient String supplierName;

    // Constructors

    public SupplierPart() {
    }

    public SupplierPart(String description, Float price, Integer quantity, Integer supplierId, Integer partId) {
        this.description = description;
        this.price = price;
        this.quantity = quantity;
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

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public Integer getQuantity() {
        return quantity;
    }

    public void setQuantity(Integer quantity) {
        this.quantity = quantity;
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

    public String getPartName() {
        return partName;
    }

    public void setPartName(String partName) {
        this.partName = partName;
    }

    public String getSupplierName() {
        return supplierName;
    }

    public void setSupplierName(String supplierName) {
        this.supplierName = supplierName;
    }

    @Override
    public String toString() {
        return "SupplierPart{" +
                "supplierPartId=" + supplierPartId +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", quantity=" + quantity +
                ", supplierId=" + supplierId +
                ", partId=" + partId +
                '}';
    }
}
