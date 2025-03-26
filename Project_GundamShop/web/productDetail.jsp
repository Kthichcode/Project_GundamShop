<%-- 
    Document   : productDetail
    Created on : Mar 11, 2025, 8:09:05 AM
    Author     : tamph
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Mô Hình Lắp Ráp - Chi tiết sản phẩm</title>
        <link rel="stylesheet" href="assets/css/detail.css">
        
    </head>
    <body>
        <%@ include file="header.jsp" %>

        <!-- Breadcrumb: hiển thị đường dẫn -->
        <c:if test="${not empty breadcrumb}">
            <div class="breadcrumb">
                <c:forEach var="item" items="${breadcrumb}" varStatus="status">
                    <c:choose>
                        <c:when test="${not empty item.url}">
                            <!-- Nếu có URL, hiển thị dưới dạng link -->
                            <a href="${item.url}">${item.label}</a>
                        </c:when>
                        <c:otherwise>
                            <!-- Nếu không có URL, đây là trang hiện tại -->
                            <span>${item.label}</span>
                        </c:otherwise>
                    </c:choose>
                    <!-- Hiển thị dấu phân cách nếu không phải phần tử cuối cùng -->
                    <c:if test="${!status.last}">
                        <span class="separator">&gt;</span>
                    </c:if>
                </c:forEach>
            </div>
        </c:if>

        <!-- Phần chi tiết sản phẩm -->
        <c:set var="p" value="${requestScope.product}" />
        <!-- Kiểm tra đăng nhập -->
        <c:set var="userLoggedIn" value="${not empty sessionScope.user}" />

        <div class="container">
            <div class="left">
                <div class="main-image">
                    <img id="mainImg" src="${p.image_url}" alt="Mô hình lắp ráp">
                </div>
            </div>
            <div class="right">
                <div class="title">MÔ HÌNH LẮP RÁP ${p.name}</div>
                <div class="status">Tình trạng: Còn hàng</div>
                <div class="price-container">
                    <p class="price">
                        <fmt:formatNumber value="${p.price}" pattern="#,##0" />đ
                    </p>
                </div>
                <!-- Mô tả sản phẩm -->
                <div class="description">
                    <h3>Mô tả sản phẩm</h3>
                    <p>${p.description}</p>
                </div>
                <!-- Form thêm vào giỏ -->
                <form action="CartController" method="get">
                    <input type="hidden" name="action" value="add"/>
                    <input type="hidden" name="productId" value="${p.product_id}"/>

                    <div class="quantity">
                        <label for="quantity">Số lượng:</label>
                        <button type="button" onclick="decreaseQuantity()">-</button>
                        <input type="text" id="quantity" name="quantity" value="1">
                        <button type="button" onclick="increaseQuantity()">+</button>
                    </div>

                    <div class="buttons">
                        <c:choose>
                            <c:when test="${userLoggedIn}">
                                <!-- Nếu đã đăng nhập, cho phép submit form và mua ngay -->
                                <button type="submit" class="btn btn-cart">🛒 THÊM VÀO GIỎ</button>
                                <a href="CartController?action=view" class="btn btn-buy">MUA NGAY</a>
                            </c:when>
                            <c:otherwise>
                                <!-- Nếu chưa đăng nhập, chuyển hướng sang trang login -->
                                <a href="login.jsp" class="btn btn-cart">🛒 THÊM VÀO GIỎ</a>
                                <a href="login.jsp" class="btn btn-buy">MUA NGAY</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </form>
            </div>
        </div>

        <script>
            function increaseQuantity() {
                var qty = document.getElementById("quantity");
                qty.value = parseInt(qty.value) + 1;
            }
            function decreaseQuantity() {
                var qty = document.getElementById("quantity");
                if (parseInt(qty.value) > 1) {
                    qty.value = parseInt(qty.value) - 1;
                }
            }
        </script>

        <%@ include file="footer.jsp" %>
    </body>
</html>