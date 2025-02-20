<%-- 
    Document   : header
    Created on : Feb 19, 2025, 5:26:29 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    * {
        margin: 0;
        padding: 0;
        box-sizing: border-box;
    }

    .header {
        background-color: #3d7fe3;
        padding: 1rem 0;
        width: 100%;
        top: 0;
    }

    .container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 1rem;
    }

    .nav {
        display: flex;
        justify-content: space-between;
        align-items: center;
    }

    .logo {
        color: #fff;
        font-size: 2rem;
        font-weight: bold;
        text-decoration: none;
    }

    .menu {
        display: flex;
        list-style: none;
        gap: 2rem;
    }

    .menu-item a {
        color: #fff;
        text-decoration: none;
        font-size: 24px;
        transition: color 0.3s ease;
    }

    .menu-item a:hover {
        color: #3498db;
    }

    .search-bar {
        display: flex;
        align-items: center;
        background: #fff;
        border-radius: 20px;
        padding: 0.5rem 1rem;
    }

    .search-input {
        border: none;
        outline: none;
        padding: 0.2rem;
        width: 200px;
    }

    .search-button {
        background: none;
        border: none;
        cursor: pointer;
        color: #2c3e50;
    }

    .header_logo {
        display: flex;
        justify-content: center;
    }

    .header_logo img{
        display: flex;
        align-items: center;
        width: 220px       
    }

    .user-menu {
        position: relative;
        display: inline-block;
    }

    .user-icon {
        background: none;
        border: none;
        font-size: 20px;
        cursor: pointer;
    }

    .dropdown-menu {
        display: none;
        position: absolute;
        right: 0;
        background: white;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        border-radius: 5px;
        width: 120px;
        text-align: center;
    }

    .dropdown-menu a {
        display: block;
        padding: 10px;
        text-decoration: none;
        color: black;
    }

    .dropdown-menu a:hover {
        background: #ddd;
    }

    /* Hiển thị dropdown khi hover */
    .user-menu:hover .dropdown-menu {
        display: block;
    }

    .user-icon img {
        width: 30px;
        height: 30px;
    }
</style>

<div class="header_logo">
    <img src="img/gundam.jpg" alt=""> 
</div>

<header class="header">

    <div class="container">
        <nav class="nav">
            <a href="#" class="logo">Minh.Đạt Gunpla Shop</a>
            <ul class="menu">
                <li class="menu-item"><a href="#">Trang chủ</a></li>
                <li class="menu-item"><a href="#">Sản phẩm</a></li>
                <li class="menu-item"><a href="#">Giỏ hàng</a></li>
                <li class="menu-item"><a href="#">Liên hệ</a></li>
            </ul>
            <div class="search-bar">
                <input type="text" class="search-input" placeholder="Tìm kiếm...">
                <button class="search-button">🔍</button>
            </div>

            <div class="user-menu">
                <button class="user-icon">
                    <img src="icon/user.png" alt="">
                </button>
                <div class="dropdown-menu">
                    <a href="login.jsp">Đăng nhập</a>
                    <a href="#">Đăng ký</a>
                </div>
            </div>
        </nav>
    </div>
</header>
