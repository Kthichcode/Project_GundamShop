<%-- 
    Document   : home
    Created on : Feb 28, 2025, 3:51:24 PM
    Author     : tamph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>

        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
                margin: 0;
                padding: 20px;
            }

            .product-container {
                display: flex;
                justify-content: space-between;
                flex-wrap: wrap;
                max-width: 1200px;
                margin: 0 auto;
            }

            .product-card {
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 5px;
                width: 23%; /* Chia đều 4 sản phẩm trên 1 hàng */
                margin-bottom: 20px;
                text-align: center;
                position: relative;
                padding: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }

            .product-card img {
                width: 100%;
                height: auto;
                border-bottom: 1px solid #ddd;
            }

            .product-card h3 {
                font-size: 14px;
                margin: 10px 0;
                color: #333;
            }

            .product-card .price {
                font-size: 16px;
                font-weight: bold;
                color: #e74c3c;
                margin: 5px 0;
            }

            .product-card .original-price {
                font-size: 14px;
                color: #999;
                text-decoration: line-through;
                margin-left: 5px;
            }

            .product-card .discount {
                position: absolute;
                top: 10px;
                right: 10px;
                background-color: #e74c3c;
                color: #fff;
                font-size: 12px;
                padding: 2px 5px;
                border-radius: 3px;
            }
        </style>
    </head>
    <body>
        <%@include file="header.jsp" %>
        <div class="product-container">
            <c:forEach var="p" items="${requestScope.list}">
                <div class="product-card">
                    <img src="img/${p.image_url}" alt="Sản phẩm 1">
                    <h3>${p.name}</h3>
                    <p class="price">${p.price}</p>
                </div>
            </c:forEach>            
        </div>
        <%@include file="footer.jsp" %>
    </body>
</html>
