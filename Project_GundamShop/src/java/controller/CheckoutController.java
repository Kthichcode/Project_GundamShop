/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.OrderDAO;
import dto.CartDTO;
import dto.OrderDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "CheckoutController", urlPatterns = {"/CheckoutController"})
public class CheckoutController extends HttpServlet {

    private OrderDAO orderDAO = new OrderDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Thiết lập content type
        response.setContentType("text/html;charset=UTF-8");
        HttpSession session = request.getSession();

        // Giả sử giỏ hàng được lưu trong session với attribute "SESSION_CART"
        @SuppressWarnings("unchecked")
        List<CartDTO> sessionCart = (List<CartDTO>) session.getAttribute("SESSION_CART");
        if (sessionCart == null || sessionCart.isEmpty()) {
            session.setAttribute("message", "Giỏ hàng trống, không thể thanh toán!");
            response.sendRedirect("home.jsp");
            return;
        }

        // Lấy user_id từ session (nếu người dùng đã đăng nhập)
        Integer userId = (Integer) session.getAttribute("user_id");
        if (userId == null) {
            // Nếu chưa đăng nhập, chuyển hướng đến trang đăng nhập
            response.sendRedirect("login.jsp");
            return;
        }

        // Tính tổng tiền từ giỏ hàng
        double total = 0;
        for (CartDTO item : sessionCart) {
            total += item.getPrice() * item.getQuantity();
        }

        // Tạo đối tượng OrderDTO
        OrderDTO order = new OrderDTO();
        order.setUserId(userId);
        order.setOrderDate(new Date());
        order.setTotalPrice(total);

        // Lưu đơn hàng vào database
        boolean orderCreated = orderDAO.createOrder(order);
        if (orderCreated) {
            // Sau khi đặt hàng thành công, xóa giỏ hàng khỏi session
            session.removeAttribute("SESSION_CART");
            // Lưu thông tin đơn hàng để hiển thị (ví dụ tổng tiền)
            session.setAttribute("orderTotal", total);
            // Chuyển hướng sang trang xác nhận đơn hàng
            response.sendRedirect("orderConfirmation.jsp");
        } else {
            session.setAttribute("message", "Thanh toán không thành công. Vui lòng thử lại!");
            response.sendRedirect("cart.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "CheckoutController";
    }
}
