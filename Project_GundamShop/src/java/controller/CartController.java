package controller;

import dao.CartDAO;
import dao.ProductDAO;
import dto.CartDTO;
import dto.ProductsDTO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {

    private CartDAO cartDAO = new CartDAO();
    private ProductDAO productDAO = new ProductDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        // Kiểm tra xem người dùng đã đăng nhập hay chưa
        Integer userId = (Integer) session.getAttribute("user_id");
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }
        
        // Nếu chưa đăng nhập: dùng session để lưu giỏ hàng (guest mode)
        if (userId == null) {
            @SuppressWarnings("unchecked")
            List<CartDTO> sessionCart = (List<CartDTO>) session.getAttribute("SESSION_CART");
            if (sessionCart == null) {
                sessionCart = new ArrayList<>();
                session.setAttribute("SESSION_CART", sessionCart);
            }
            
            if ("add".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                // Lấy thông tin sản phẩm
                ProductsDTO product = productDAO.readById(productId);
                
                if (product != null) {
                    boolean found = false;
                    for (CartDTO item : sessionCart) {
                        if (item.getProductId() == productId) {
                            item.setQuantity(item.getQuantity() + quantity);
                            found = true;
                            break;
                        }
                    }
                    if (!found) {
                        CartDTO newItem = new CartDTO(productId, product.getName(), product.getPrice(), quantity, product.getImage_url());
                        sessionCart.add(newItem);
                    }
                }
                request.setAttribute("product", product);
                response.sendRedirect("CartController?action=view");
            } else if ("view".equals(action)) {
                request.setAttribute("CART_ITEMS", sessionCart);
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            } else if ("update".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int newQuantity = Integer.parseInt(request.getParameter("newQuantity"));
                for (CartDTO item : sessionCart) {
                    if (item.getProductId() == productId) {
                        item.setQuantity(newQuantity);
                        break;
                    }
                }
                response.sendRedirect("CartController?action=view");
            } else if ("remove".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                sessionCart.removeIf(item -> item.getProductId() == productId);
                response.sendRedirect("CartController?action=view");
            } else if ("clear".equals(action)) {
                session.removeAttribute("SESSION_CART");
                response.sendRedirect("CartController?action=view");
            } else {
                response.sendRedirect("CartController?action=view");
            }           
        }
        // Nếu đã đăng nhập: lưu giỏ hàng vào DB (logged-in mode)
        else {
            if ("add".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));
                ProductsDTO product = productDAO.readById(productId);
                if (product != null) {
                    cartDAO.addOrUpdateCart(userId, productId, quantity);
                }
                request.setAttribute("product", product);
                response.sendRedirect("CartController?action=view");
            } else if ("view".equals(action)) {
                List<CartDTO> cartItems = cartDAO.getCartByUser(userId);
                request.setAttribute("CART_ITEMS", cartItems);
                request.getRequestDispatcher("cart.jsp").forward(request, response);
            } else if ("update".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                int newQuantity = Integer.parseInt(request.getParameter("newQuantity"));
                cartDAO.updateQuantityByProduct(userId, productId, newQuantity);
                response.sendRedirect("CartController?action=view");
            } else if ("remove".equals(action)) {
                int productId = Integer.parseInt(request.getParameter("productId"));
                cartDAO.removeCartItem(userId, productId);
                response.sendRedirect("CartController?action=view");
            } else if ("clear".equals(action)) {
                cartDAO.clearCart(userId);
                response.sendRedirect("CartController?action=view");
            } else {
                response.sendRedirect("CartController?action=view");
            }
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
}
