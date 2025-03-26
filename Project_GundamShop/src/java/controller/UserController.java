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
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import utils.AuthUtils;
import utils.PasswordUtils;

/**
 *
 * @author ADMIN
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
        String passHash = PasswordUtils.hashPassword(pass);
        UserDTO user = new UserDTO(userName, passHash, email);
        ud.create(user);
        url = LOGIN_PAGE;
        request.setAttribute("mess", "Sign Up successfully");
        return url;
    }

    private String processLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        String userName = request.getParameter("txtUserName");
        String password = request.getParameter("txtPassword");

        if (AuthUtils.isValidLogin(userName, password)) {
            UserDTO user = AuthUtils.getUser(userName);
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("mess",userName);
            url = "ProductController?action=showAll";
        } else {
            request.setAttribute("mess", "Invalid username or password");
            url = "login.jsp";
        }

        return url;
    }

    private String processLogout(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String url = LOGIN_PAGE;
        //
        HttpSession session = request.getSession();
        if (AuthUtils.isLoggedIn(session)) {
            request.getSession().invalidate(); // Hủy bỏ session
            url = "ProductController?action=showAll";
        }

        return url;
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String url = HOME_PAGE;
        try {
            String action = request.getParameter("action");
            if (action == null) {
                url = HOME_PAGE;
            }

            if (action.equals("signup")) {
                url = processSignUp(request, response);
            } else if (action.equals("login")) {
                url = processLogin(request, response);
            } else if ("logout".equals(action)) {
                url = processLogout(request, response);
            }

        } catch (Exception e) {
            log("Error at MainController: " + e.toString());

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
