/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.CartDTO;
import utils.DBUtils;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class CartDAO {

    // Thêm hoặc cập nhật sản phẩm vào giỏ (nếu đã có thì tăng số lượng)
    public boolean addOrUpdateCart(int userId, int productId, int quantity) {
        String checkSql = "SELECT * FROM Cart WHERE user_id = ? AND product_id = ?";
        String insertSql = "INSERT INTO Cart (user_id, product_id, quantity) VALUES (?, ?, ?)";
        String updateSql = "UPDATE Cart SET quantity = quantity + ? WHERE user_id = ? AND product_id = ?";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement psCheck = conn.prepareStatement(checkSql)) {

            psCheck.setInt(1, userId);
            psCheck.setInt(2, productId);

            try (ResultSet rs = psCheck.executeQuery()) {
                if (rs.next()) {
                    // Nếu sản phẩm đã có trong giỏ, cập nhật số lượng
                    try (PreparedStatement psUpdate = conn.prepareStatement(updateSql)) {
                        psUpdate.setInt(1, quantity);
                        psUpdate.setInt(2, userId);
                        psUpdate.setInt(3, productId);
                        int rows = psUpdate.executeUpdate();
                        return rows > 0;
                    }
                } else {
                    // Nếu chưa có, chèn mới
                    try (PreparedStatement psInsert = conn.prepareStatement(insertSql)) {
                        psInsert.setInt(1, userId);
                        psInsert.setInt(2, productId);
                        psInsert.setInt(3, quantity);
                        int rows = psInsert.executeUpdate();
                        return rows > 0;
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Lấy danh sách mặt hàng trong giỏ của một người dùng, kèm thông tin sản phẩm (name, price)
    public List<CartDTO> getCartByUser(int userId) {
        List<CartDTO> list = new ArrayList<>();
        String sql = "SELECT c.cart_id, c.product_id, c.quantity, p.name, p.price "
                + "FROM Cart c JOIN Products p ON c.product_id = p.product_id "
                + "WHERE c.user_id = ?";

        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    CartDTO item = new CartDTO();
                    // Nếu cần bạn có thể lấy cột cart_id để hiển thị nhưng hiện tại ta chỉ dùng productId, quantity,...
                    item.setProductId(rs.getInt("product_id"));
                    item.setQuantity(rs.getInt("quantity"));
                    item.setProductName(rs.getString("name"));
                    item.setPrice(rs.getDouble("price"));
                    list.add(item);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    // Cập nhật số lượng của mặt hàng dựa trên cart_id (nếu bạn lưu cart_id vào DB)
    // Nếu bạn không lấy cart_id trong DTO thì bạn có thể cập nhật theo userId và productId
    public boolean updateQuantityByProduct(int userId, int productId, int newQuantity) {
        String sql = "UPDATE Cart SET quantity = ? WHERE user_id = ? AND product_id = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, newQuantity);
            ps.setInt(2, userId);
            ps.setInt(3, productId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xoá một mặt hàng khỏi giỏ dựa trên user_id và product_id
    public boolean removeCartItem(int userId, int productId) {
        String sql = "DELETE FROM Cart WHERE user_id = ? AND product_id = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ps.setInt(2, productId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

    // Xoá toàn bộ giỏ hàng của một người dùng dựa trên user_id
    public boolean clearCart(int userId) {
        String sql = "DELETE FROM Cart WHERE user_id = ?";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            int rows = ps.executeUpdate();
            return rows > 0;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }
}


