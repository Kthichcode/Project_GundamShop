/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package dao;

import dto.CategoryDTO;
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

 public class CategoryDAO {
    public List<CategoryDTO> readAll() {
        List<CategoryDTO> list = new ArrayList<>();
        String sql = "SELECT category_id, name, description FROM Categories";
        try (Connection conn = DBUtils.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                int id = rs.getInt("category_id");
                String name = rs.getString("name");
                String desc = rs.getString("description");
                list.add(new CategoryDTO(id, name, desc));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
}
   

