<%-- 
    Document   : productForm
    Created on : Mar 24, 2025
    Author     : tamph
--%>

<%@page import="utils.AuthUtils"%>
<%@page import="dto.ProductsDTO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Product Management Form</title>
        <link rel="stylesheet" href="assets/css/productFormV2.css">
    </head>
    <body>
        <%
            ProductsDTO product = (ProductsDTO) request.getAttribute("product");
            if (product == null) {
                product = new ProductsDTO();
                request.setAttribute("product", product);
            }

            String action = (String) request.getAttribute("action");
            if (action == null || action.isEmpty()) {
                action = "create";
            }
        %>
        <c:set var="isLoggedIn" value="<%=AuthUtils.isLoggedIn(session)%>"/>
        <c:set var="isAdmin" value="<%=AuthUtils.isAdmin(session)%>"/>

        <c:if test="${isAdmin}">
            <div class="form-container">
                <form action="AdminController" method="post" id="productForm" enctype="multipart/form-data" accept-charset="UTF-8">
                    <input type="hidden" name="action" value="<%=action%>"/>
                    
                    <c:if test="${action == 'update'}">
                        <div class="form-field">
                            <label for="productId">Product ID</label>
                            <input type="text" id="productId" name="product_id" value="${product.product_id}" readonly>
                        </div>
                    </c:if>

                    <div class="form-field">
                        <label for="productName">Product Name</label>
                        <input type="text" id="productName" name="name" value="${product.name}" required>
                    </div>

                    <div class="form-field">
                        <label for="description">Description</label>
                        <input type="text" id="description" name="description" value="${product.description}" required>
                    </div>

                    <div class="form-field">
                        <label for="price">Price</label>
                        <input type="text" id="price" name="price" value="${product.price}" required>
                        <c:if test="${not empty requestScope.price_Error}">
                            <div class="error-message">${requestScope.price_Error}</div>
                        </c:if>
                    </div>

                    <div class="form-field">
                        <label for="quantity">Quantity</label>
                        <input type="number" id="quantity" name="stock_quantity" value="${product.stock_quantity}" required>
                        <c:if test="${not empty requestScope.quantity_Error}">
                            <div class="error-message">${requestScope.quantity_Error}</div>
                        </c:if>
                    </div>

                    <div class="form-field">
                        <label for="category">Category</label>
                        <select name="category_id" id="category">
                            <option value="3" <c:if test="${product.category_id == 3}">selected</c:if>>SD (Super Deformed)</option>
                            <option value="1" <c:if test="${product.category_id == 1}">selected</c:if>>HG (High Grade)</option>
                            <option value="2" <c:if test="${product.category_id == 2}">selected</c:if>>MG (Master Grade)</option>
                            <option value="4" <c:if test="${product.category_id == 4}">selected</c:if>>PG (Perfect Grade)</option>
                            </select>
                        </div>

                    <c:if test="${action == 'update'}">
                        <div class="form-field">
                            <label for="status">Status</label>
                            <select name="status" id="status">
                                <option value="false" <c:if test="${product.status == 'false'}">selected</c:if>>Block</option>
                                <option value="true" <c:if test="${product.status == 'true'}">selected</c:if>>Active</option>
                            </select>
                        </div>
                    </c:if>

                    <div class="form-field image-upload-section">
                        <label for="txtImage">Product Image</label>
                        <input type="hidden" id="txtImage" name="image_url" value="${product.image_url}">
                        <div class="upload-container">
                            <div class="file-upload-wrapper">
                                <button type="button" class="file-upload-button">Choose Image</button>
                                <input type="file" id="imageUpload" class="file-upload-input" accept="image/*">
                            </div>
                            <div class="file-info" id="fileInfo">No file selected</div>
                            <div class="progress-bar-container" id="progressContainer">
                                <div class="progress-bar" id="progressBar"></div>
                            </div>
                        </div>
                        <c:if test="${not empty requestScope.txtImage_error}">
                            <div class="error-message">${requestScope.txtImage_error}</div>
                        </c:if>
                        <div class="image-preview" id="imagePreview">
                            <c:if test="${not empty product.image_url}">
                                <img src="${product.image_url}" alt="Product Preview">
                            </c:if>
                        </div>
                    </div>

                    <div class="form-actions">
                        <input type="submit" value="Save" class="submit-btn">
                        <input type="reset" value="Reset" class="reset-btn" id="resetBtn">
                    </div>

                    <c:if test="${not empty requestScope.mess}">
                        <div class="form-message">${requestScope.mess}</div>
                    </c:if>
                </form>

                <a href="AdminController?action=search" class="back-link">Back to Product List</a>
            </div>
        </c:if>

        <c:if test="${!isAdmin}">
            You do not have permission to access this content.
            <a href="login.jsp">Go back to login</a>
        </c:if>

        <!-- jQuery CDN -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const txtImage = document.getElementById('txtImage');
                const imagePreview = document.getElementById('imagePreview');

                txtImage.addEventListener('input', function () {
                    const imageUrl = this.value.trim();
                    if (imageUrl) {
                        if (imageUrl.startsWith('data:image') || imageUrl.startsWith('http')) {
                            imagePreview.innerHTML = `<img src="${imageUrl}" alt="Preview" onerror="this.src='assets/images/placeholder.png'; this.alt='Image not available';">`;
                        } else {
                            imagePreview.innerHTML = '<p>Invalid image URL</p>';
                        }
                    } else {
                        imagePreview.innerHTML = '';
                    }
                });
            });

            $(document).ready(function () {
                $('#imageUpload').change(function () {
                    const file = this.files[0];
                    if (file) {
                        if (!file.type.match('image.*')) {
                            alert('Please select an image file');
                            this.value = '';
                            $('#fileInfo').text('No file selected');
                            return;
                        }

                        if (file.size > 1024 * 1024) { // Giới hạn 1MB
                            alert('File size must be under 1MB');
                            this.value = '';
                            $('#fileInfo').text('No file selected');
                            return;
                        }

                        const fileSize = (file.size / 1024).toFixed(2) + ' KB';
                        $('#fileInfo').text(file.name + ' (' + fileSize + ')');
                        $('#progressContainer').show();

                        const reader = new FileReader();
                        reader.onprogress = function (event) {
                            if (event.lengthComputable) {
                                const percent = Math.round((event.loaded / event.total) * 100);
                                $('#progressBar').css('width', percent + '%');
                            }
                        };

                        reader.onload = function (e) {
                            $('#progressBar').css('width', '100%');
                            const base64String = e.target.result;
                            $('#txtImage').val(base64String);
                            $('#imagePreview').html('<img src="' + base64String + '" alt="Preview">');
                            setTimeout(() => {
                                $('#progressContainer').hide();
                                $('#progressBar').css('width', '0%');
                            }, 1000);
                        };

                        reader.onerror = function () {
                            alert('Error reading file');
                            $('#progressContainer').hide();
                            $('#progressBar').css('width', '0%');
                            $('#fileInfo').text('No file selected');
                        };

                        reader.readAsDataURL(file);
                    }
                });

                $('#resetBtn').click(function () {
                    $('#imagePreview').empty();
                    $('#fileInfo').text('No file selected');
                    $('#txtImage').val('');
                    $('#progressContainer').hide();
                    $('#progressBar').css('width', '0%');
                });
            });
        </script>

    </body>
</html>