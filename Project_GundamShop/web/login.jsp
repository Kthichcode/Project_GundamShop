
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>   
    <body>
        <div class="login-container">
            <h3 style="color: red"><c:out value="${requestScope.mess}"></c:out></h3>
            <h2>ĐĂNG NHẬP</h2>
            <form id="login_form" action="UserController" method="POST">
                <input type="hidden" name="action" value="login">
                <input type="text" id="userName" name="txtUserName" placeholder="Tên đăng nhập" required>
                <input type="password" id="passWord" name="txtPassword" placeholder="Mật khẩu" required>
                <button type="submit">Đăng nhập</button>
                <hr>
                <div>Bạn chưa có tài khoản ?</div>
                <a href="sign_up.jsp" class="sign_up">Đăng ký</a>
                <a href="home.jsp" class="home-button">Quay về trang chủ </a>
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
