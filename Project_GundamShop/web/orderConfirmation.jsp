<%-- 
    Document   : orderConfirmation
    Created on : Mar 26, 2025, 8:11:23 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đơn hàng đã đặt</title>
        <link rel="stylesheet" href="assets/css/orderConfirmation.css">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
            }

            .confirmation-container {
                max-width: 600px;
                margin: 50px auto;
                padding: 20px;
                background-color: #fff;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                text-align: center;
            }

            .confirmation-container h2 {
                color: #28a745;
                font-size: 28px;
                margin-bottom: 10px;
            }

            .confirmation-container p {
                font-size: 16px;
                color: #333;
                margin: 10px 0;
            }

            .confirmation-container strong {
                color: #d9534f;
                font-size: 18px;
            }

            .btn-home {
                display: inline-block;
                margin-top: 20px;
                padding: 10px 20px;
                background-color: #007bff;
                color: #fff;
                text-decoration: none;
                border-radius: 5px;
                font-size: 16px;
                transition: background-color 0.3s ease;
            }

            .btn-home:hover {
                background-color: #0056b3;
            }
        </style>
    </head>
    <body>
        <c:set var="p" value="${requestScope.product}"></c:set>
        <c:set var="userName" value="${requestScope.username}"></c:set>
        <%@ include file="header.jsp" %>
        <div class="confirmation-container">
            <h2>Đặt hàng thành công!</h2>
            <p>Cảm ơn bạn đã mua sắm tại Minh.Đạt Gunpla Shop.</p>
            <p>Thông tin đơn hàng</p>


            <c:set var="totalPrice" value="0" scope="page"/>

            <c:forEach var="p" items="${list}">
                Tên sản phẩm: <c:out value="${p.name}"/> <br/>
                Giá: <fmt:formatNumber value="${p.price}" type="number" pattern="#,##0.00"/> <br/>
                <c:set var="totalPrice" value="${totalPrice + p.price}" scope="page"/>
            </c:forEach>

            <p><strong>Tổng giá tiền: <fmt:formatNumber value="${totalPrice}" type="number" pattern="#,##0.00"/></strong></p>
            <a href="ProductController?action=search" class="btn-home">Tiếp tục mua hàng</a>
        </div>
        <%@ include file="footer.jsp" %>
    </body>
</html>

