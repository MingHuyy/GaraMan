package org.example.Model;

import java.io.Serializable;

/**
 * Model Part - Phụ tùng ô tô (chỉ chứa tên, không chứa giá/số lượng)
 * Giá và số lượng được lưu trong SupplierPart theo từng nhà cung cấp
 */
public class Part implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer partId;
    private String name;

    // Constructors

    public Part() {
    }

    public Part(String name) {
        this.name = name;
    }

    // Getters and Setters

    public Integer getPartId() {
        return partId;
    }

    public void setPartId(Integer partId) {
        this.partId = partId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Override
    public String toString() {
        return "Part{" +
                "partId=" + partId +
                ", name='" + name + '\'' +
                '}';
    }
}
