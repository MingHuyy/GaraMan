package org.example.Model;

import java.io.Serializable;

/**
 * Model Customer - Khách hàng
 */
public class Customer implements Serializable {

    private static final long serialVersionUID = 1L;

    private Integer customerId;
    private String username;
    private String password;
    private String phone;
    private String name;
    private String email;
    private String address;

    // Constructors

    public Customer() {
    }

    public Customer(String username, String password, String phone, String name, String email) {
        this.username = username;
        this.password = password;
        this.phone = phone;
        this.name = name;
        this.email = email;
    }

    // Getters and Setters

    public Integer getCustomerId() {
        return customerId;
    }

    public void setCustomerId(Integer customerId) {
        this.customerId = customerId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Override
    public String toString() {
        return "Customer{" +
                "customerId=" + customerId +
                ", username='" + username + '\'' +
                ", phone='" + phone + '\'' +
                ", name='" + name + '\'' +
                ", email='" + email + '\'' +
                '}';
    }
}
