/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dto;

/**
 *
 * @author ADMIN
 */
public class CartDTO {

    private int productId;
    private String productName;
    private double price;
    private int quantity;

    // Constructor không đối số
    public CartDTO() {
    }

    // Constructor đầy đủ
    public CartDTO(int productId, String productName, double price, int quantity) {
        this.productId = productId;
        this.productName = productName;
        this.price = price;
        this.quantity = quantity;
    }

    // Getters & Setters
    public int getProductId() {
        return productId;
    }

    public void setProductId(int productId) {
        this.productId = productId;
    }

    public String getProductName() {
        return productName;
    }

    public void setProductName(String productName) {
        this.productName = productName;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    // Tính tổng tiền của mặt hàng
    public double getSubtotal() {
        return price * quantity;
    }

    @Override
    public String toString() {
        return "CartDTO{" + "productId=" + productId + ", productName=" + productName
                + ", price=" + price + ", quantity=" + quantity + '}';
    }
}
