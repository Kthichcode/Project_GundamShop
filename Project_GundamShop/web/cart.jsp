<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Giỏ hàng của bạn</title>
        <link rel="stylesheet" type="text/css" href="assets/css/cart.css" />
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
                        <th>Hình ảnh</th>
                        <th>Sản phẩm</th>
                        <th>Giá</th>
                        <th>Số lượng</th>
                        <th>Thành tiền</th>
                        <th>Hành động</th>
                    </tr>
                    <c:set var="total" value="0" scope="page" />
                    <c:forEach var="item" items="${CART_ITEMS}">
                        <c:set var="subTotal" value="${item.price * item.quantity}" />
                        <c:set var="total" value="${total + subTotal}" scope="page" />
                        <tr>
                            <td><img src="${item.img}" alt="${item.productName}" class="cart-img"></td>
                            <td>${item.productName}</td>
                            <td><fmt:formatNumber value="${item.price}" pattern="#,##0.00" /></td>
                            <td>
                                <form action="CartController" method="get">
                                    <input type="hidden" name="action" value="update"/>
                                    <input type="hidden" name="productId" value="${item.productId}"/>
                                    <input type="number" name="newQuantity" value="${item.quantity}" min="1" class="quantity-input"/>
                                    <button type="submit" class="btn-update">Cập nhật</button>
                                </form>
                            </td>
                            <td><fmt:formatNumber value="${subTotal}" pattern="#,##0.00" /></td>
                            <td class="actions">
                                <a href="CartController?action=remove&productId=${item.productId}" class="btn-remove">Xoá</a>
                            </td>
                        </tr>
                    </c:forEach>
                    <tr>
                        <td colspan="4" align="right"><strong>Tổng cộng:</strong></td>
                        <td colspan="2"><strong><fmt:formatNumber value="${total}" pattern="#,##0.00" /></strong></td>
                    </tr>
                </table>
                <div class="cart-actions">
                    <a href="CartController?action=clear" class="btn-clear">Xoá toàn bộ giỏ</a>
                    <form action="ProductController" method="post">
                        <input type="hidden" name="action" value="buy"/>
                        <c:forEach var="item" items="${CART_ITEMS}">
                            <input type="hidden" name="product_id" value="${item.productId}"/>
                            <input type="hidden" name="quantity_${item.productId}" value="${item.quantity}"/>
                        </c:forEach>
                        <button type="submit" class="btn-checkout">Thanh toán</button>
                    </form>
                </div>


            </c:otherwise>
        </c:choose>
        <p class="center"><a href="ProductController?action=showAll" class="btn-continue">Tiếp tục mua hàng</a></p>
    </body>
</html>
