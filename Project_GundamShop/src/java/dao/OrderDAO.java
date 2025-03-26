/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.OrderDTO;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import utils.DBUtils;

/**
 *
 * @author ADMIN
 */
public class OrderDAO {

    public boolean createOrder(OrderDTO order) {
        String sql = "INSERT INTO Orders (user_id, total_price, order_status, order_date) "
                + "VALUES (?, ?, DEFAULT, GETDATE())";
        try (Connection conn = DBUtils.getConnection();
                PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, order.getUserId());
            ps.setDouble(2, order.getTotalPrice());

            return ps.executeUpdate() > 0;
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

}
