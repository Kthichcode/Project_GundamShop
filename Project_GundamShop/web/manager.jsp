<%-- 
    Document   : manager
    Created on : Mar 24, 2025, 7:22:03 AM
    Author     : tamph
--%>

<%@page import="utils.AuthUtils"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" type="text/css" href="assets/css/manager.css">
    </head>
    <body>
        <c:set var="isLoggedIn" value="<%=AuthUtils.isLoggedIn(session)%>"/>
        <c:set var="isAdmin" value="<%=AuthUtils.isAdmin(session)%>"/>

        <c:if test="${isAdmin}">
            <c:set var="searchTerm" value="${requestScope.searchTerm==null?'':requestScope.searchTerm}" />
            <form action="AdminController" method="GET">
                <input type="hidden" name="action" value="search">
                <input type="text" name="searchTerm" class="search-input" placeholder="Tìm kiếm...">
                <button class="search-button">🔍</button>
            </form>

            <a href="productForm.jsp">Create New Product</a>

            <div class="filter-container">
                <form action="AdminController" method="GET">
                    <label for="category">Chọn danh mục:</label>
                    <select name="categoryId" id="category">
                        <option value="">Tất cả</option>
                        <option value="3">SD (Super Deformed)</option>
                        <option value="1">HG (High Grade)</option>
                        <option value="2">MG (Master Grade)</option>
                        <option value="4">PG (Perfect Grade)</option>

                    </select>
                    <button type="submit">Lọc</button>
                </form>
            </div>

            <table border="1">
                <thead>
                    <tr>
                        <th>ProductID</th>
                        <th>Image</th>
                        <th>Name</th>
                        <th>Price</th>
                        <th>Description</th>
                        <th>Category_ID</th>
                        <th>Quantity</th>
                        <th>Status</th>
                        <th>Action</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="p" items="${list}">
                        <tr>
                            <td>${p.product_id}</td>
                            <td>
                                <img src="${p.image_url}" alt="${p.name}" width="100">
                            </td>
                            <td>${p.name}</td>
                            <td>
                                <p class="price">
                                    <fmt:formatNumber value="${p.price}" pattern="#,##0" />đ
                                </p>
                            </td>
                            <td>${p.description}</td>
                            <td>${p.category_id}</td>
                            <td>${p.stock_quantity}</td>
                            <td>${p.status}</td>
                            <td>
                                <a href="AdminController?action=edit&id=${p.product_id}">Edit</a>
                            </td>
                            <td>
                                <a href="AdminController?action=delete&id=${p.product_id}">Delete</a>
                            </td>                       
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:if>

        <c:if test="${!isAdmin}">
            You do not have permission to access this content.
            <a href="login.jsp">Go back to login</a>
        </c:if>
    </body>
</html>
