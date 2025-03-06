/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controller;

import dao.UserDAO;
import dto.UserDTO;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author tamph
 */
@WebServlet(name = "UserController", urlPatterns = {"/UserController"})
public class UserController extends HttpServlet {
    
    private static final String LOGIN_PAGE = "login.jsp";
    private static final String SIGN_UP_PAGE = "sign_up.jsp";
    private static final String HOME_PAGE = "home.jsp";
    private UserDAO ud = new UserDAO();
    
    public String processSignUp(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = SIGN_UP_PAGE;
        
        String userName = request.getParameter("username");
        String pass = request.getParameter("password");
        String email = request.getParameter("email");
        
        UserDTO user = new UserDTO(userName, pass, email);
        ud.create(user);
        url = LOGIN_PAGE;
        request.setAttribute("mess", "Sign Up successfully");
        return url;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        
        String url = HOME_PAGE;
        try {
            String action = request.getParameter("action");
            
            if (action.equals("signup")) {
                url = processSignUp(request, response);
            }
        } catch (Exception e) {
            
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
