<%-- 
    Document   : orderConfirmation
    Created on : Mar 26, 2025, 8:11:23 PM
    Author     : ADMIN
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Đơn hàng đã đặt</title>
        <link rel="stylesheet" href="assets/css/orderConfirmation.css">
        <style>
            body {
                font-family: 'Roboto', sans-serif;
                background-color: #f8f9fa;
                margin: 0;
                padding: 20px;
            }

            .confirmation-container {
                max-width: 600px;
                margin: 50px auto;
                background-color: #fff;
                padding: 30px;
                border-radius: 8px;
                box-shadow: 0 2px 8px rgba(0,0,0,0.1);
                text-align: center;
            }

            .confirmation-container h2 {
                color: #28a745;
                margin-bottom: 20px;
            }

            .confirmation-container p {
                font-size: 18px;
                margin-bottom: 30px;
            }

            .btn-home {
                display: inline-block;
                padding: 12px 24px;
                background-color: #007bff;
                color: #fff;
                text-decoration: none;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }

            .btn-home:hover {
                background-color: #0056b3;
            }

        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>
        <div class="confirmation-container">
            <h2>Đặt hàng thành công!</h2>
            <p>Cảm ơn bạn đã mua sắm tại Minh.Đạt Gunpla Shop.</p>
            <p>Tổng số tiền thanh toán của bạn: <strong><%= session.getAttribute("orderTotal")%> đ</strong></p>
            <a href="home.jsp" class="btn-home">Tiếp tục mua hàng</a>
        </div>
        <%@ include file="footer.jsp" %>
    </body>
</html>

