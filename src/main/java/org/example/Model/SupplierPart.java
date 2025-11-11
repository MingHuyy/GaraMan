package org.example.Model;

import java.io.Serializable;


public class SupplierPart implements Serializable {

    private static final long serialVersionUID = 1L;

    private int supplierPartId;
    private String description;
    private float price;
    private int quantity;

    private Supplier supplier;
    private Part part;

    public SupplierPart() {
    }

    public SupplierPart(String description, Float price, Integer quantity, Supplier supplier, Part part) {
        this.description = description;
        this.price = price;
        this.quantity = quantity;
        this.supplier = supplier;
        this.part = part;
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

    public void setSupplierPartId(int supplierPartId) {
        this.supplierPartId = supplierPartId;
    }

    public Supplier getSupplier() {
        return supplier;
    }

    public void setSupplier(Supplier supplier) {
        this.supplier = supplier;
    }

    public Part getPart() {
        return part;
    }

    public void setPart(Part part) {
        this.part = part;
    }
}
