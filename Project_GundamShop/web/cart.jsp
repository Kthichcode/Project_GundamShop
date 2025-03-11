<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Giỏ hàng của bạn</title>
    <!-- Bạn có thể thêm file CSS riêng nếu muốn -->
    <link rel="stylesheet" type="text/css" href="assets/css/cart.css" />
    <style>
        /* Một số style cơ bản nếu bạn chưa có file CSS riêng */
        table {
            width: 80%;
            margin: auto;
            border-collapse: collapse;
        }
        th, td {
            padding: 8px;
            border: 1px solid #ccc;
            text-align: center;
        }
        .actions a {
            text-decoration: none;
            color: #1976D2;
        }
        .actions a:hover {
            text-decoration: underline;
        }
        .center {
            text-align: center;
        }
    </style>
</head>
<body>
    <h1 class="center">Giỏ hàng của bạn</h1>
    <c:choose>
        <c:when test="${empty CART_ITEMS}">
            <p class="center">Giỏ hàng trống!</p>
        </c:when>
        <c:otherwise>
            <table>
                <tr>
                    <th>Sản phẩm</th>
                    <th>Giá</th>
                    <th>Số lượng</th>
                    <th>Thành tiền</th>
                    <th>Hành động</th>
                </tr>
                <c:set var="total" value="0" scope="page" />
                <c:forEach var="item" items="${CART_ITEMS}">
                    <!-- Tính thành tiền: nếu CartDTO không có getSubtotal(), tính bằng cách nhân price * quantity -->
                    <c:set var="subTotal" value="${item.price * item.quantity}" />
                    <c:set var="total" value="${total + subTotal}" scope="page" />
                    <tr>
                        <td>${item.productName}</td>
                        <td><fmt:formatNumber value="${item.price}" pattern="#,##0.00" /></td>
                        <td>
                            <form action="CartController" method="get">
                                <input type="hidden" name="action" value="update"/>
                                <input type="hidden" name="productId" value="${item.productId}"/>
                                <input type="number" name="newQuantity" value="${item.quantity}" min="1" style="width:50px;"/>
                                <button type="submit">Cập nhật</button>
                            </form>
                        </td>
                        <td><fmt:formatNumber value="${subTotal}" pattern="#,##0.00" /></td>
                        <td class="actions">
                            <a href="CartController?action=remove&productId=${item.productId}">Xoá</a>
                        </td>
                    </tr>
                </c:forEach>
                <tr>
                    <td colspan="3" align="right"><strong>Tổng cộng:</strong></td>
                    <td colspan="2"><strong><fmt:formatNumber value="${total}" pattern="#,##0.00" /></strong></td>
                </tr>
            </table>
            <p class="center"><a href="CartController?action=clear">Xoá toàn bộ giỏ</a></p>
        </c:otherwise>
    </c:choose>
    <p class="center"><a href="ProductController?action=showAll">Tiếp tục mua hàng</a></p>
</body>
</html>
