/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.ProductDAO;
import dto.ProductsDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AuthUtils;

@WebServlet(name = "ProductController", urlPatterns = {"/ProductController"})
public class ProductController extends HttpServlet {

    private static final String LOGIN_PAGE = "login.jsp";
    private static final String SIGN_UP_PAGE = "sign_up.jsp";
    private static final String HOME_PAGE = "home.jsp";

    private ProductDAO pd = new ProductDAO();

    public String processPrintAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = HOME_PAGE;
        String categoryIdStr = request.getParameter("categoryId");
        List<ProductsDTO> list;

        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {

            list = pd.readAll();
        } else {

            int categoryId = Integer.parseInt(categoryIdStr);
            list = pd.readByCategory(categoryId);
        }

        request.setAttribute("list", list);
        return url;
    }

    public String processSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (!AuthUtils.isLoggedIn(session)) {
            return LOGIN_PAGE;
        }

        String searchTerm = request.getParameter("searchTerm");
        if (searchTerm == null) {
            searchTerm = "";
        }

        List<ProductsDTO> products = pd.searchByTitle(searchTerm);

        request.setAttribute("list", products);

        request.setAttribute("searchTerm", searchTerm);

        return HOME_PAGE;
    }

    public String processDetail(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String url = HOME_PAGE;

        int id = Integer.parseInt(request.getParameter("id"));
        ProductsDTO product = pd.readById(id);
        request.setAttribute("product", product);
        url = "productDetail.jsp";

        return url;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        String url = HOME_PAGE;

        try {
            if (action == null || action.trim().isEmpty()) {
                url = processPrintAll(request, response);
            } else if ("search".equals(action)) {
                url = processSearch(request, response);
            } else if (action.equals("detail")) {
                url = processDetail(request, response);
            } else {
                url = processPrintAll(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {

            request.getRequestDispatcher(url).forward(request, response);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
