<%-- 
    Document   : login
    Created on : Feb 13, 2025, 10:58:14 AM
    Author     : tamph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <div class="login-container">
            <h2>ĐĂNG NHẬP</h2>
            <form id="login_form">
                <input type="text" placeholder="Tên đăng nhập" required>
                <input type="password" placeholder="Mật khẩu" required>
                <button type="submit">Đăng nhập</button>
                <hr>
                <div>Bạn chưa có tài khoản ?</div>
                <a href="signup.jsp" class="sign_up">Đăng ký</a>
                <button class="home-button" onclick="window.location.href='index.html'">Quay về trang chủ</button>
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
        .login-container {
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

        .sign_up {
            text-decoration: none;
            margin: 20px;
        }
        
        .home-button {
            background: #007bff;
        }
        .home-button:hover {
            background: #0056b3;
        }
    </style>
</html>
