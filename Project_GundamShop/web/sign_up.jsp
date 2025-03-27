<%-- 
    Document   : signup
    Created on : Feb 28, 2025, 11:30:00 AM
    Author     : tamph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Đăng ký</title>
    </head>   
    <body>
        <div class="signup-container">
            <h2>ĐĂNG KÝ</h2>

            <form id="signup_form" action="UserController">
                <input type="hidden" name="action" value="signup"/>
                <input type="text" name="username" placeholder="Tên đăng ký" autocomplete="off" required>
                <c:if test="${not empty mess1}">
                    <p style="color: red;"><c:out value="${mess1}"/></p>
                </c:if>
                <input type="email" name="email" placeholder="Email" autocomplete="off" required>
                <c:if test="${not empty mess2}">
                    <p style="color: red;"><c:out value="${mess2}"/></p>
                </c:if>
                <input type="password" name="password" placeholder="Mật khẩu" autocomplete="new-password" required>
                <button type="submit">Đăng ký</button>
                <hr>
                <div>Bạn đã có tài khoản ?</div>
                <a href="login.jsp" class="login-link">Đăng nhập</a>
                <a href="home.jsp" class="home-button">Quay về trang chủ</a>
            </form>
        </div>
    </body>

    <style>
        body {
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #3d7fe3;
        }
        .signup-container {
            background: white;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            text-align: center;
            width: 300px;
        }
        input, button {
            width: 100%;
            padding: 10px;
            margin: 10px 0;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        button {
            background: #3d7fe3;
            color: white;
            border: none;
            cursor: pointer;
        }
        button:hover {
            background: #0358b3;
        }
        .login-link {
            text-decoration: none;
            margin: 20px;
        }
        .home-button {
            display: block;
            width: 100%;
            padding: 10px;
            background: #007bff;
            color: white;
            text-align: center;
            text-decoration: none;
            border-radius: 4px;
            margin-top: 10px;
            font-size: 16px;
            box-sizing: border-box;
        }
        .home-button:hover {
            background: #0056b3;
        }
    </style>
</html>
