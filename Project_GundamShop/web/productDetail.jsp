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
        <!-- Nếu muốn dùng Google Fonts -->
        <link rel="stylesheet" href="https://fonts.googleapis.com/css?family=Roboto:400,500,700&display=swap">


    </head>
    <body>
        <%@ include file="header.jsp" %>

        <!-- Breadcrumb -->
        <c:if test="${not empty breadcrumb}">
            <div class="breadcrumb-container">
                <c:forEach var="item" items="${breadcrumb}" varStatus="status">
                    <c:choose>
                        <c:when test="${not empty item.url}">
                            <a href="${item.url}">${item.label}</a>
                        </c:when>
                        <c:otherwise>
                            <span>${item.label}</span>
                        </c:otherwise>
                    </c:choose>
                    <c:if test="${!status.last}">
                        <span class="separator">&gt;</span>
                    </c:if>
                </c:forEach>
            </div>
        </c:if>

        <!-- Phần Chi tiết sản phẩm -->
        <c:set var="p" value="${requestScope.product}" />
        <c:set var="userLoggedIn" value="${not empty sessionScope.user}" />

        <div class="product-detail-wrapper">
            <!-- Cột trái: Hình ảnh sản phẩm -->
            <div class="left-column">
                <img class="main-image" src="${p.image_url}" alt="${p.name}">
                <!-- Có thể thêm dải thumbnail nếu cần -->
            </div>

            <!-- Cột phải: Thông tin sản phẩm -->
            <div class="right-column">
                <h1 class="product-title">${p.name}</h1>
                <div class="product-status">Tình trạng: <span class="highlight">Còn hàng</span></div>
                <div class="product-price">
                    <fmt:formatNumber value="${p.price}" pattern="#,##0" /> đ
                </div>

                <!-- Phần mô tả ngắn -->
                <div class="short-description">
                    <p>${p.description}</p>
                </div>

                <!-- Form thêm sản phẩm vào giỏ -->
                <form action="CartController" method="get" class="add-cart-form">
                    <input type="hidden" name="action" value="add"/>
                    <input type="hidden" name="productId" value="${p.product_id}"/>
                    <div class="quantity-box">
                        <label for="quantity">Số lượng:</label>
                        <div class="quantity-controls">
                            <button type="button" onclick="decreaseQuantity()">-</button>
                            <input type="text" id="quantity" name="quantity" value="1">
                            <button type="button" onclick="increaseQuantity()">+</button>
                        </div>
                    </div>
                    <div class="action-buttons">
                        <c:choose>
                            <c:when test="${userLoggedIn}">
                                <button type="submit" class="btn btn-cart">🛒 Thêm vào giỏ</button>
                                <a href="CartController?action=view" class="btn btn-buy">Mua ngay</a>
                            </c:when>
                            <c:otherwise>
                                <a href="login.jsp" class="btn btn-cart">🛒 Thêm vào giỏ</a>
                                <a href="login.jsp" class="btn btn-buy">Mua ngay</a>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </form>

                <!-- Chính sách vận chuyển & hỗ trợ -->
                <div class="policy-section">
                    <h4>Chính sách & Dịch vụ</h4>
                    <ul>
                        <li>Giao hàng toàn quốc</li>
                        <li>Thanh toán khi nhận hàng</li>
                        <li>Đổi trả trong 7 ngày nếu sản phẩm lỗi</li>
                        <li>Hỗ trợ kỹ thuật 24/7</li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- Phần Thông số kỹ thuật & Mô tả chi tiết -->
        <div class="additional-info">
            <h2>Thông số kỹ thuật</h2>
            <table class="spec-table">


                <tr>
                    <th>Nhà sản xuất </th>
                    <td> BANDAI</td>
                </tr>
                
                
                 <tr>
                    <th>Xuất sứ </th>
                    <td>Japan </td>
                </tr>

                <tr>
                    <th>Kích thước</th>
                    <td>15 x 10 x 8 cm</td>
                </tr>
                <tr>
                    <th>Chất liệu</th>
                    <td>Nhựa cao cấp, đặc biệt thích hợp cho các anh em nghiện hít nhựa
                        giai đoạn cuối </td>
                </tr>
                <tr>
                    <th>Số lượng chi tiết</th>
                    <td>90000 chi tiết</td>
                </tr>


                <!-- Bạn có thể bổ sung thêm các thông số khác -->
            </table>

            <h2>Mô tả chi tiết</h2>
            <p>
                Đây là mô hình Gundam được sản xuất theo tiêu chuẩn cao, có chi tiết tinh xảo, chất lượng đảm bảo và phù hợp cho cả người mới bắt đầu lẫn người sưu tập. Sản phẩm có thiết kế hiện đại, màu sắc sống động, mang đến trải nghiệm lắp ráp độc đáo.
            </p>
        </div>

        <%@ include file="footer.jsp" %>

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
    </body>
</html>