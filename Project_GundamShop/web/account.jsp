<%-- 
    Document   : account
    Created on : Mar 11, 2025, 1:24:10 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thông tin tài khoản</title>
    <!-- Link đến file CSS -->
    <link rel="stylesheet" href="assets/css/account.css">
</head>
<body>
    <div class="container">
        <c:if test="${sessionScope.user != null}">
            <h1>THÔNG TIN TÀI KHOẢN</h1>
            <p><strong>Tên đăng nhập:</strong> ${sessionScope.user.userName}</p>
            <p><strong>Email:</strong> ${sessionScope.user.email}</p>
            <!-- Nút Quay lại trang chủ -->
            <a href="home.jsp" class="btn-home">Quay lại trang chủ</a>
        </c:if>

        <c:if test="${sessionScope.user == null}">
            <h1>Bạn chưa đăng nhập!</h1>
            <p>
                <a href="login.jsp">Đăng nhập</a> hoặc 
                <a href="sign_up.jsp">Đăng ký</a>
            </p>
            <!-- Nút Quay lại trang chủ -->
            <a href="home.jsp" class="btn-home">Quay lại trang chủ</a>
        </c:if>
    </div>
</body>
</html>
