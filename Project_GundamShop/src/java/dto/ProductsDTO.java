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
public class ProductsDTO {

    private int product_id;
    private String name;
    private String description;
    private double price;
    private int category_id;
    private int stock_quantity;
    private String image_url;

    public ProductsDTO() {
    }

    public ProductsDTO(int product_id, String name, String description, double price, int stock_quantity, String image_url) {
        this.product_id = product_id;
        this.name = name;
        this.description = description;
        this.price = price;
        this.stock_quantity = stock_quantity;
        this.image_url = image_url;
    }

    public ProductsDTO(String name, String description, double price, int category_id, int stock_quantity, String image_url) {
        this.name = name;
        this.description = description;
        this.price = price;
        this.category_id = category_id;
        this.stock_quantity = stock_quantity;
        this.image_url = image_url;
    }
    
    public int getProduct_id() {
        return product_id;
    }

    public void setProduct_id(int product_id) {
        this.product_id = product_id;
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

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getStock_quantity() {
        return stock_quantity;
    }

    public void setStock_quantity(int stock_quantity) {
        this.stock_quantity = stock_quantity;
    }

    public String getImage_url() {
        return image_url;
    }

    public void setImage_url(String image_url) {
        this.image_url = image_url;
    }

    public int getCategory_id() {
        return category_id;
    }

    public void setCategory_id(int category_id) {
        this.category_id = category_id;
    }
     

    @Override
    public String toString() {
        return "ProductsDTO{" + "product_id=" + product_id + ", name=" + name + ", description=" + description + ", price=" + price + ", stock_quantity=" + stock_quantity + ", image_url=" + image_url + '}';
    }
    
    
    
}
