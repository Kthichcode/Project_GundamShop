/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.ProductsDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author ADMIN
 */
public class ProductDAO implements IDAO<ProductsDTO, Integer> {

    @Override
    public boolean create(ProductsDTO entity) {
        throw new UnsupportedOperationException("Not supported yet.");
    }

    @Override
    public List<ProductsDTO> readAll() {
        String sql = "SELECT * FROM Products";
        List<ProductsDTO> list = new ArrayList<ProductsDTO>();
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductsDTO product = new ProductsDTO(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"));

                list.add(product);
            }
        } catch (Exception e) {
            e.toString();
        }
        return list;
    }

    @Override
    public boolean update(ProductsDTO entity) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public List<ProductsDTO> search(String searchTerm) {
        return null;
    }

    public List<ProductsDTO> searchByTitle(String searchTerm) {

        String sql = "SELECT * FROM Products WHERE name LIKE ? AND stock_quantity > 0";
        List<ProductsDTO> list = new ArrayList<ProductsDTO>();

        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setString(1, "%" + searchTerm + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsDTO b = new ProductsDTO(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"));

                list.add(b);
            }
        } catch (Exception e) {
            System.out.println(e.toString());
        }
        return list;
    }

    public List<ProductsDTO> readByCategory(int catID) {
        List<ProductsDTO> list = new ArrayList<>();
        String sql = "SELECT product_id, name, description, price, stock_quantity, image_url "
                + "FROM Products WHERE category_id = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, catID);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    ProductsDTO p = new ProductsDTO();
                    p.setProduct_id(rs.getInt("product_id"));
                    p.setName(rs.getString("name"));
                    p.setDescription(rs.getString("description"));
                    p.setPrice(rs.getDouble("price"));
                    p.setStock_quantity(rs.getInt("stock_quantity"));
                    p.setImage_url(rs.getString("image_url"));
                    list.add(p);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public ProductsDTO readById(Integer id) {
        String sql = "SELECT * FROM Products WHERE product_id = ?";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);
            ps.setInt(1, id);
            ResultSet rs= ps.executeQuery();
            
            while(rs.next()){
                ProductsDTO p = new ProductsDTO(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"));
                return p;
            }                   
        } catch (Exception e) {
            
        }
        return null;
    }

    @Override
    public boolean delete(Integer id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

}
