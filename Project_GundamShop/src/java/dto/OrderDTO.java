/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class OrderDTO {

    private int orderId;
    private int userId;
    private Date orderDate;
    private double totalPrice;
    private String status; // Ví dụ: "pending", "shipped", "delivered", "cancelled"

    public OrderDTO() {
    }

    public OrderDTO(int orderId, int userId, Date orderDate, double totalPrice, String status) {
        this.orderId = orderId;
        this.userId = userId;
        this.orderDate = orderDate;
        this.totalPrice = totalPrice;
        this.status = status;
    }

    public int getOrderId() {
        return orderId;
    }

    public void setOrderId(int orderId) {
        this.orderId = orderId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public Date getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(Date orderDate) {
        this.orderDate = orderDate;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Override
    public String toString() {
        return "OrderDTO{" + "orderId=" + orderId + ", userId=" + userId + ", orderDate=" + orderDate + ", totalPrice=" + totalPrice + ", status=" + status + '}';
    }

   

}
