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
import java.sql.SQLException;
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
        String sql = "INSERT INTO Products (name, description, price, stock_quantity, category_id, image_url, created_at, status) "
                + "VALUES (?, ?, ?, ?, ?, ?, GETDATE(), 1)";
        try {
            Connection conn = DBUtils.getConnection();
            PreparedStatement ps = conn.prepareStatement(sql);

            ps.setString(1, entity.getName());
            ps.setString(2, entity.getDescription());
            ps.setDouble(3, entity.getPrice());
            ps.setInt(4, entity.getStock_quantity());
            ps.setInt(5, entity.getCategory_id());
            ps.setString(6, entity.getImage_url());

            int i = ps.executeUpdate();
            return i > 0;
        } catch (ClassNotFoundException | SQLException e) {
            e.toString();
        }
        return false;
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
                        rs.getInt("category_id"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"),
                        rs.getBoolean("status")
                );

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
                ProductsDTO product = new ProductsDTO(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"),
                        rs.getBoolean("status")
                );

                list.add(product);
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
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ProductsDTO product = new ProductsDTO(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"),
                        rs.getBoolean("status")
                );
                return product;
            }
        } catch (Exception e) {

        }
        return null;
    }

    @Override
    public boolean delete(Integer id) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public List<ProductsDTO> getProductsByPage(int page, int pageSize) {
        List<ProductsDTO> products = new ArrayList<>();
        // Tính vị trí bắt đầu: (page - 1) * pageSize
        int offset = (page - 1) * pageSize;
        // Câu lệnh SQL sử dụng cú pháp OFFSET ... FETCH NEXT
        String sql = "SELECT * FROM Products ORDER BY product_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, offset);
            ps.setInt(2, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsDTO product = new ProductsDTO(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"),
                        rs.getBoolean("status")
                );
                products.add(product);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return products;
    }

    // Phương thức đếm tổng số sản phẩm
    public int getTotalProducts() {
        String sql = "SELECT COUNT(*) FROM Products";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql);
                ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return 0;
    }

    public List<ProductsDTO> getProductsByCategoryPage(int categoryId, int page, int pageSize) {
        List<ProductsDTO> products = new ArrayList<>();
        // Tính toán vị trí bắt đầu dựa trên số trang
        int offset = (page - 1) * pageSize;
        // Câu lệnh SQL: lọc theo category, sắp xếp theo product_id,
        // và sử dụng OFFSET – FETCH để phân trang
        String sql = "SELECT * FROM Products WHERE category_id = ? ORDER BY product_id OFFSET ? ROWS FETCH NEXT ? ROWS ONLY";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, categoryId);
            ps.setInt(2, offset);
            ps.setInt(3, pageSize);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ProductsDTO product = new ProductsDTO(
                        rs.getInt("product_id"),
                        rs.getString("name"),
                        rs.getString("description"),
                        rs.getDouble("price"),
                        rs.getInt("category_id"),
                        rs.getInt("stock_quantity"),
                        rs.getString("image_url"),
                        rs.getBoolean("status")
                );
                products.add(product);
            }
        } catch (SQLException | ClassNotFoundException ex) {
            ex.printStackTrace();
        }
        return products;
    }
    
    public int getTotalProductsByCategory(int categoryId) {
    String sql = "SELECT COUNT(*) FROM Products WHERE category_id = ?";
    try (Connection conn = DBUtils.getConnection();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setInt(1, categoryId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            return rs.getInt(1);
        }
    } catch (SQLException | ClassNotFoundException ex) {
        ex.printStackTrace();
    }
    return 0;
}


}
