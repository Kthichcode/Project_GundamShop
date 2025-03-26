/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.CategoryDAO;
import dao.ProductDAO;
import dto.CategoryDTO;
import dto.ProductsDTO;
import java.awt.print.Book;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AuthUtils;

/**
 *
 * @author tamph
 */
@WebServlet(name = "AdminController", urlPatterns = {"/AdminController"})
public class AdminController extends HttpServlet {

    private static final String MANAGE_PAGE = "manager.jsp";
    private ProductDAO pd = new ProductDAO();
    private CategoryDAO cd = new CategoryDAO();

    public String processPrintAll(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = MANAGE_PAGE;
        String categoryIdStr = request.getParameter("categoryId");
        List<ProductsDTO> list;

        if (categoryIdStr == null || categoryIdStr.trim().isEmpty()) {
            list = pd.readAll();
        } else {
            int categoryId = Integer.parseInt(categoryIdStr);
            list = pd.readByCategoryForAD(categoryId);
        }

        request.setAttribute("list", list);
        return url;
    }

    public String processSearch(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();

        if (!AuthUtils.isLoggedIn(session)) {
            return MANAGE_PAGE;
        }

        String searchTerm = request.getParameter("searchTerm");
        if (searchTerm == null) {
            searchTerm = "";
        }

        List<ProductsDTO> products = pd.searchByTitleForAD(searchTerm);

        request.setAttribute("list", products);

        request.setAttribute("searchTerm", searchTerm);

        return MANAGE_PAGE;
    }

    private String processEdit(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = MANAGE_PAGE;
        HttpSession session = request.getSession();
        if (AuthUtils.isAdmin(session)) {
            int id = Integer.parseInt(request.getParameter("id"));
            ProductsDTO product = pd.readById(id);

            if (product != null) {
                request.setAttribute("product", product);
                request.setAttribute("action", "update");
                url = "productForm.jsp";
            } else {
                url = processSearch(request, response);
            }
        }
        return url;
    }

    private String processCreate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = MANAGE_PAGE;
        HttpSession session = request.getSession();
        if (AuthUtils.isAdmin(session)) {
            try {
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int stock_quantity = Integer.parseInt(request.getParameter("stock_quantity"));
                int category_id = Integer.parseInt(request.getParameter("category_id"));
                String image_url = request.getParameter("image_url");

                boolean checkError = false;

                if (price < 0) {
                    request.setAttribute("price_Error", "Price must be > 0");
                    checkError = true;
                }

                if (stock_quantity < 0) {
                    request.setAttribute("quantity_Error", "Quantity must be > 0");
                    checkError = true;
                }

                if (checkError == false) {
                    ProductsDTO product = new ProductsDTO(name, description, price, category_id, stock_quantity, image_url);
                    pd.create(product);
                    url = "productForm.jsp";
                    request.setAttribute("product", product);
                    request.setAttribute("mess", "Create successful");
                } else {
                    url = "productForm.jsp";
                }

            } catch (Exception e) {
            }

        }
        return url;
    }

    private String processDelete(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = MANAGE_PAGE;
        HttpSession session = request.getSession();
        if (AuthUtils.isAdmin(session)) {
            int id = Integer.parseInt(request.getParameter("id"));
            pd.setStatusToZero(id);

            url = processSearch(request, response);
            processSearch(request, response);

        }
        return url;
    }

    private String processUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = MANAGE_PAGE;
        HttpSession session = request.getSession();
        if (AuthUtils.isAdmin(session)) {
            try {
                int product_id = Integer.parseInt(request.getParameter("product_id"));
                String name = request.getParameter("name");
                String description = request.getParameter("description");
                double price = Double.parseDouble(request.getParameter("price"));
                int stock_quantity = Integer.parseInt(request.getParameter("stock_quantity"));
                int category_id = Integer.parseInt(request.getParameter("category_id"));
                String image_url = request.getParameter("image_url");
                boolean status = Boolean.parseBoolean(request.getParameter("status"));
                boolean checkError = false;

                if (price < 0) {
                    request.setAttribute("price_Error", "Price must be > 0");
                    checkError = true;
                }

                if (stock_quantity < 0) {
                    request.setAttribute("quantity_Error", "Quantity must be > 0");
                    checkError = true;
                }

                if (checkError == false) {
                    ProductsDTO product = new ProductsDTO(product_id, name, description, price, category_id, stock_quantity, image_url, status);
                    pd.update(product);
                    request.setAttribute("action", "update");
                    request.setAttribute("product", product);
                    request.setAttribute("mess", "Update successful");
                    url = "productForm.jsp";
                }else{
                    request.setAttribute("action", "update");
                    //request.setAttribute("product", product);
                    url = "productForm.jsp";
                }
               
            } catch (Exception e) {
            }

        }
        return url;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String url = MANAGE_PAGE;

        try {
            if (action == null || action.trim().isEmpty()) {
                url = processPrintAll(request, response);
            } else {
                if (action.equals("search")) {
                    url = processSearch(request, response);
                } else if (action.equals("create")) {
                    url = processCreate(request, response);
                } else if (action.equals("edit")) {
                    url = processEdit(request, response);
                } else if (action.equals("update")) {
                    url = processUpdate(request, response);
                } else if (action.equals("delete")) {
                    url = processDelete(request, response);
                }
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
