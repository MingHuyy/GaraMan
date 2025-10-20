package org.example.Model;

import java.io.Serializable;

/**
 * Model Service - Dịch vụ sửa chữa/bảo dưỡng
 */
public class Service implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer serviceId;
    private String name;
    private String description;
    private Float price;
    private Integer duration; // Thời gian thực hiện (phút)

    // Constructors

    public Service() {
    }

    public Service(String name, String description, Float price, Integer duration) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.duration = duration;
    }

    // Getters and Setters

    public Integer getServiceId() {
        return serviceId;
    }

    public void setServiceId(Integer serviceId) {
        this.serviceId = serviceId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Float getPrice() {
        return price;
    }

    public void setPrice(Float price) {
        this.price = price;
    }

    public Integer getDuration() {
        return duration;
    }

    public void setDuration(Integer duration) {
        this.duration = duration;
    }

    @Override
    public String toString() {
        return "Service{" +
                "serviceId=" + serviceId +
                ", name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", price=" + price +
                ", duration=" + duration +
                '}';
    }
}
