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
        font-family: Arial, sans-serif;
    }

    .header {
        background-color: #176cd3;
        padding: 1rem 0;
        width: 100%;
        top: 0;
        position: sticky;
        z-index: 1000;
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
        gap: 1.5rem;
    }

    .menu-item a {
        color: #fff;
        text-decoration: none;
        font-size: 18px;
        transition: color 0.3s ease;
    }

    .menu-item a:hover {
        color: #f1c40f;
    }

    .dropdown {
        position: relative;
        display: inline-block;
    }

    .dropdown-content {
        display: none;
        position: absolute;
        background: white;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        border-radius: 5px;
        width: 150px;
        text-align: left;
        padding: 10px 0;
    }

    .dropdown:hover .dropdown-content {
        display: block;
    }

    .dropdown-content a {
        display: block;
        padding: 10px;
        text-decoration: none;
        color: black;
    }

    .dropdown-content a:hover {
        background: #ddd;
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
        width: 180px;
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
        padding: 0.5rem 0;
    }

    .header_logo img {
        width: 180px;
        height: auto;
    }

    .user-menu {
        position: relative;
    }

    .user-icon {
        background: none;
        border: none;
        cursor: pointer;
    }

    .dropdown-menu {
        display: none;
        position: absolute;
        right: 0;
        background: white;
        box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
        border-radius: 5px;
        width: 130px;
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

    .user-menu:hover .dropdown-menu {
        display: block;
    }

    .user-icon img {
        width: 30px;
        height: 30px;
    }

    .greeting {
        color: #fff;           
        font-size: 18px;       
        margin-left: 1rem;    
        font-weight: normal;   
        white-space: nowrap;   
        text-decoration: none; 
    }

    @media (max-width: 768px) {
        .nav {
            flex-direction: column;
        }
        .menu {
            flex-direction: column;
            align-items: center;
            padding: 1rem 0;
        }
        .search-bar {
            width: 100%;
            justify-content: center;



        }








    }
</style>

<div class="header_logo">
    <img src="img/gundam.PNG" alt="Gundam Logo"> 
</div>

<header class="header">
    <div class="container">
        <nav class="nav">

            <a href="ProductController" class="logo">Minh.Đạt Gunpla Shop</a>


            <ul class="menu">
                <li class="menu-item"><a href="ProductController">Trang chủ</a></li>


                <li class="menu-item dropdown">
                    <a href="#">Sản phẩm</a>
                    <div class="dropdown-content">

                        <a href="ProductController?action=filterCategory&categoryId=3">SD (Super Deformed)  </a>
                        <a href="ProductController?action=filterCategory&categoryId=1">HG (High Grade)  </a>
                        <a href="ProductController?action=filterCategory&categoryId=2">MG (Master Grade)  </a>
                        <a href="ProductController?action=filterCategory&categoryId=4">PG (Perfect Grade)  </a>

                    </div>
                </li>

                <li class="menu-item"><a href="#">Giỏ hàng</a></li>
                <li class="menu-item"><a href="#">Liên hệ</a></li>
            </ul>


            <div class="search-bar">
                <form action="ProductController" method="GET">

                    <input type="hidden" name="action" value="search" />
                    <input type="text" name="searchTerm" class="search-input" placeholder="Tìm kiếm..." />
                    <button class="search-button">🔍</button>
                </form>
            </div>

            <!-- User menu -->
            <div class="user-menu">
                <button class="user-icon">
                    <img src="icon/user.png" alt="User Icon">
                </button>
                <div class="dropdown-menu">
                    <a href="login.jsp">Đăng nhập</a>
                    <a href="sign_up.jsp">Đăng ký</a>
                    <a href="#">Tài khoản</a>
                    <a href="UserController?action=logout">Đăng xuất</a>
                </div>
            </div>

            <c:if test="${not empty mess}">
                <span class="greeting">${mess}</span>
            </c:if>

        </nav>
    </div>
</header>
