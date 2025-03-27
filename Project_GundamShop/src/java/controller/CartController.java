package controller;

import dao.CartDAO;
import dao.ProductDAO;
import dto.CartDTO;
import dto.ProductsDTO;
import dto.UserDTO;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet(name = "CartController", urlPatterns = {"/CartController"})
public class CartController extends HttpServlet {
    private static final String LOGIN_PAGE = "login.jsp";
    private CartDAO cartDAO = new CartDAO();
    private ProductDAO productDAO = new ProductDAO();

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        Integer userId = (Integer) session.getAttribute("user_id");
        String action = request.getParameter("action");
        if (action == null) {
            action = "view";
        }

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
                response.sendRedirect("ProductController?action=productDetail&product_id=" + productId);
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
            } else if ("buy".equals(action)) {
                
                String url = LOGIN_PAGE;
                String[] productIds = request.getParameterValues("productId");
                String[] quantities = request.getParameterValues("quantity");
                //int quantity = Integer.parseInt(request.getParameter("quantity"));
                List<ProductsDTO> products = new ArrayList<>();
                List<Integer> productQuantities = new ArrayList<>();
                for (int i = 0; i < productIds.length; i++) {
                    int id = Integer.parseInt(productIds[i]);
                    int quantity = Integer.parseInt(quantities[i]);

                    ProductsDTO p = productDAO.readById(id);
                    products.add(p);
                    productQuantities.add(quantity);
                }
                UserDTO user = (UserDTO) session.getAttribute("user");
                request.setAttribute("username", user.getUserName());
                request.setAttribute("list", products);
                request.setAttribute("quantities", productQuantities);
                request.getRequestDispatcher("orderConfirmation.jsp").forward(request, response);
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
