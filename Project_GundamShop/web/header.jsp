<%-- 
    Document   : header
    Created on : Feb 19, 2025, 5:26:29 PM
    Author     : ADMIN
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="stylesheet" href="assets/css/header.css">
<div class="header_logo">
    <img src="img/gundam.PNG" alt="Gundam Logo"> 
</div>

<header class="header">

    <c:set var="isLoggedIn" value="<%=AuthUtils.isLoggedIn(session)%>"/>
    <c:set var="isAdmin" value="<%=AuthUtils.isAdmin(session)%>"/>

    <div class="header-container">
        <nav class="nav">
            <a href="ProductController" class="logo">Minh.Đạt Gunpla Shop</a>

            <ul class="menu">
                <li class="menu-item"><a href="ProductController">Trang chủ</a></li>
                <li class="menu-item dropdown">
                    <a href="#">Sản phẩm</a>
                    <div class="dropdown-content">
                        <a href="ProductController?action=filterCategory&categoryId=3">SD (Super Deformed)</a>
                        <a href="ProductController?action=filterCategory&categoryId=1">HG (High Grade</a>
                        <a href="ProductController?action=filterCategory&categoryId=2">MG (Master Grade)</a>
                        <a href="ProductController?action=filterCategory&categoryId=4">PG (Perfect Grade)</a>
                    </div>
                </li>
                <li class="menu-item"><a href="CartController?action=view">Giỏ hàng</a></li>
                <li class="menu-item"><a href="#">Liên hệ</a></li>
            </ul>

            <div class="search-bar">
                <form action="ProductController" method="GET">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="searchTerm" class="search-input" placeholder="Tìm kiếm...">
                    <button class="search-button">🔍</button>
                </form>
            </div>

            <!-- Đảm bảo user-menu nằm trong nav -->
            <div class="user-menu">
                <button class="user-icon">
                    <img src="icon/user3.png" alt="User Icon">
                </button>
                <div class="dropdown-menu">
                    <a href="login.jsp">Đăng nhập</a>
                    <a href="sign_up.jsp">Đăng ký</a>
                    <a href="account.jsp">Tài khoản</a>
                    <a href="UserController?action=logout">Đăng xuất</a>
                    <c:if test="${isAdmin}">
                        <a href="AdminController?action=search">Quản lí</a>
                    </c:if>
                </div>
            </div>

            <c:if test="${not empty mess}">
                <span class="greeting">${mess}</span>
            </c:if>
        </nav>  

    </div>
</header>
