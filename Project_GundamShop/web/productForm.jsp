<%-- 
    Document   : productForm
    Created on : Mar 24, 2025, 3:55:29 PM
    Author     : tamph
--%>

<%@page import="dto.ProductsDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style>
            * {
                box-sizing: border-box;
                font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            }

            body {
                background-color: #f5f5f5;
                margin: 0;
                padding: 0;
                min-height: 100vh;
            }

            .page-content {
                padding: 40px 20px;
                display: flex;
                justify-content: center;
                align-items: center;
                min-height: calc(100vh - 150px); /* Account for header and footer */
            }

            .form-container {
                background-color: white;
                border-radius: 8px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
                padding: 30px;
                width: 100%;
                max-width: 600px;
                margin: 0 auto;
            }

            h1 {
                color: #2c3e50;
                margin-top: 0;
                margin-bottom: 20px;
                text-align: center;
            }

            .form-group {
                margin-bottom: 15px;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: 600;
                color: #333;
            }

            input[type="text"],
            input[type="number"],
            textarea {
                width: 100%;
                padding: 10px;
                border: 1px solid #ddd;
                border-radius: 4px;
                font-size: 16px;
                transition: border-color 0.3s;
            }

            input[type="text"]:focus,
            input[type="number"]:focus,
            textarea:focus {
                border-color: #3498db;
                outline: none;
                box-shadow: 0 0 5px rgba(52, 152, 219, 0.3);
            }

            .error-message {
                color: #e74c3c;
                font-size: 14px;
                margin-top: 5px;
            }

            .button-group {
                display: flex;
                justify-content: space-between;
                margin-top: 20px;
            }

            button, input[type="submit"], input[type="reset"] {
                padding: 10px 20px;
                border: none;
                border-radius: 4px;
                font-size: 16px;
                font-weight: 600;
                cursor: pointer;
                transition: background-color 0.3s;
            }

            input[type="submit"] {
                background-color: #2ecc71;
                color: white;
                flex: 1;
                margin-right: 10px;
            }

            input[type="submit"]:hover {
                background-color: #27ae60;
            }

            input[type="reset"] {
                background-color: #e74c3c;
                color: white;
                flex: 1;
                margin-left: 10px;
            }

            input[type="reset"]:hover {
                background-color: #c0392b;
            }

            .error-container {
                background-color: #fff0f0;
                border-left: 4px solid #e74c3c;
                padding: 20px;
                border-radius: 4px;
                margin-bottom: 20px;
            }

            .error-container h1 {
                color: #e74c3c;
                margin-top: 0;
            }

            .back-link {
                display: block;
                text-align: center;
                margin-top: 20px;
                color: #3498db;
                text-decoration: none;
            }

            .back-link:hover {
                text-decoration: underline;
            }

            @media (max-width: 768px) {
                .form-container {
                    padding: 20px;
                }

                .button-group {
                    flex-direction: column;
                }

                input[type="submit"], input[type="reset"] {
                    margin: 5px 0;
                }
            }

            .image-preview {
                margin-top: 10px;
                max-width: 100%;
            }

            .image-preview img {
                max-width: 100%;
                max-height: 200px;
                border: 1px solid #ddd;
                border-radius: 4px;
                padding: 5px;
            }

            .success-message {
                background-color: #d4edda;
                color: #155724;
                padding: 10px;
                border-radius: 4px;
                margin-bottom: 15px;
                border-left: 4px solid #28a745;
            }

            .upload-container {
                display: flex;
                flex-direction: column;
                align-items: center;
                width: 100%;
                margin-top: 10px;
            }

            .file-upload-wrapper {
                position: relative;
                width: 100%;
                height: 40px;
                overflow: hidden;
                margin-bottom: 10px;
            }

            .file-upload-input {
                position: absolute;
                top: 0;
                right: 0;
                margin: 0;
                padding: 0;
                font-size: 20px;
                cursor: pointer;
                opacity: 0;
                height: 100%;
                width: 100%;
            }

            .file-upload-button {
                width: 100%;
                height: 40px;
                background-color: #3498db;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
                display: flex;
                align-items: center;
                justify-content: center;
                font-weight: 600;
            }

            .file-upload-button:hover {
                background-color: #2980b9;
            }

            .file-info {
                margin-top: 5px;
                font-size: 14px;
                color: #666;
            }

            .progress-bar-container {
                width: 100%;
                height: 10px;
                background-color: #f1f1f1;
                border-radius: 5px;
                margin-top: 10px;
                display: none;
            }

            .progress-bar {
                height: 100%;
                background-color: #4CAF50;
                border-radius: 5px;
                width: 0%;
                transition: width 0.3s;
            }
        </style>
    </head>
    <body>

        <%
            ProductsDTO product = new ProductsDTO();
            if (request.getAttribute("book") == null) {
                request.setAttribute("book", new ProductsDTO());
                product = new ProductsDTO();
            } else {
                product = (ProductsDTO) request.getAttribute("product");
            }

            String action = (String) request.getAttribute("action");
            if (action == null || action.isEmpty()) {
                action = "create";
            }
        %>

        <form action="AdminController" method="post">
            <input type="text" name="action" value="${not empty action ? action : 'create'}"/>

            <c:if test="${action == 'update'}">
                ProductID: <input type="text" name="product_id" value="${product.product_id}" ${not empty product.product_id ? 'readonly' : ''}/> <br/>
            </c:if>
            Product Name: <input type="text" name="name" value="${product.name}"> <br/>
            Description: <input type="text" name="description" value="${product.description}"> <br/>
            Price: <input type="text" name="price" value="${product.price}"> <br/>
            Quantity: <input type="number" name="stock_quantity" value="${product.stock_quantity}"> <br/>           
            Category: <input type="text" name="category_id" value="${product.category_id}"> <br/>
            <c:if test="${action == 'update'}">
                Status: <input type="text" name="status" value="${product.status}"/> <br/>
            </c:if>

            <div class="form-group">
                <label for="txtImage">Product Cover Image:</label>
                <input type="hidden" id="txtImage" name="image_url" value="${product.image_url}"/>
                <div class="upload-container">
                    <div class="file-upload-wrapper">
                        <button type="button" class="file-upload-button">Choose an Image</button>
                        <input type="file" id="imageUpload" class="file-upload-input" accept="image/*"/>
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
                        <img src="${product.image_url}"/>
                    </c:if>
                </div>
            </div>

            <input type="submit" value="Save"/> <br/>
            <input type="reset" value="Reset"/>
            ${requestScope.mess==null?"":requestScope.mess}
        </form>

        <a href="AdminController?action=search" class="back-link">Back to Product List</a>

        <script>
            // JavaScript để cải thiện trải nghiệm người dùng
            document.addEventListener('DOMContentLoaded', function () {
                // Preview image when URL is entered
                document.getElementById('txtImage').addEventListener('input', function () {
                    const imageUrl = this.value.trim();
                    let previewContainer = document.querySelector('.image-preview');

                    if (!previewContainer) {
                        previewContainer = document.createElement('div');
                        previewContainer.className = 'image-preview';
                        this.parentNode.appendChild(previewContainer);
                    }

                    if (imageUrl) {
                        // Check if it's a URL or base64 data
                        if (imageUrl.startsWith('data:image') || imageUrl.startsWith('http')) {
                            previewContainer.innerHTML = `<img src="${imageUrl}" alt="Preview" onerror="this.src='assets/images/placeholder.png'; this.alt='Image not available';">`;
                        } else {
                            previewContainer.innerHTML = '<p>Enter a valid image URL or base64 data</p>';
                        }
                    } else {
                        previewContainer.innerHTML = '';
                    }
                });
            });
        </script>

        <!-- Thêm jQuery từ CDN -->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

        <script>
            $(document).ready(function () {
                // Hiển thị tên file khi chọn file
                $('#imageUpload').change(function () {
                    const file = this.files[0];
                    if (file) {
                        // Kiểm tra xem file có phải là hình ảnh không
                        if (!file.type.match('image.*')) {
                            alert('Please select an image file (JPEG, PNG, GIF, etc.)');
                            this.value = '';
                            $('#fileInfo').text('No file selected');
                            return;
                        }

                        // Hiển thị tên file và kích thước
                        const fileSize = (file.size / 1024).toFixed(2) + ' KB';
                        $('#fileInfo').text(file.name + ' (' + fileSize + ')');

                        // Hiển thị thanh tiến trình và bắt đầu chuyển đổi sang Base64
                        $('#progressContainer').show();

                        // Thiết lập FileReader để đọc file và chuyển đổi sang Base64
                        const reader = new FileReader();

                        reader.onprogress = function (event) {
                            if (event.lengthComputable) {
                                const percentLoaded = Math.round((event.loaded / event.total) * 100);
                                $('#progressBar').css('width', percentLoaded + '%');
                            }
                        };

                        reader.onload = function (e) {
                            // Hoàn thành tiến trình
                            $('#progressBar').css('width', '100%');

                            // Lưu trữ dữ liệu Base64 vào input ẩn
                            const base64String = e.target.result;
                            $('#txtImage').val(base64String);

                            // Hiển thị hình ảnh xem trước
                            $('#imagePreview').html('<img src="' + base64String + '" alt="Preview">');

                            // Ẩn thanh tiến trình sau 1 giây
                            setTimeout(function () {
                                $('#progressContainer').hide();
                                $('#progressBar').css('width', '0%');
                            }, 1000);
                        };

                        reader.onerror = function () {
                            alert('Error reading the file. Please try again.');
                            $('#progressContainer').hide();
                            $('#progressBar').css('width', '0%');
                            $('#fileInfo').text('No file selected');
                        };

                        // Bắt đầu đọc file và chuyển đổi sang Base64
                        reader.readAsDataURL(file);
                    } else {
                        $('#fileInfo').text('No file selected');
                    }
                });

                // Xử lý nút Reset
                $('#resetBtn').click(function () {
                    $('#imagePreview').empty();
                    $('#fileInfo').text('No file selected');
                    $('#txtImage').val('');
                    $('#progressContainer').hide();
                    $('#progressBar').css('width', '0%');
                });

                // Để chọn lại file đã tải lên trước đó (nếu có)
                const existingImageSrc = $('#imagePreview img').attr('src');
                if (existingImageSrc) {
                    $('#txtImage').val(existingImageSrc);
                }
            });
        </script>
    </body>
</html>
