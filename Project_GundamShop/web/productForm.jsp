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

            String action = request.getAttribute("action") + "";
            if (!action.equals("update")) {
                action = "create";
            }
        %>

        <form action="AdminController" method="post" enctype="multipart/form-data">
            <input type="hidden" name="action" value="create"/>
            
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
            Image: 
            <input type="file" id="imageUpload" accept="image/*"> <br/>
            <input type="hidden" id="txtImage" name="image_url" value="img/${product.image_url}">  
            <div id="imagePreview"></div>  

            <input type="submit" value="Save"/> <br/>
        </form>

        <script>
            document.getElementById('imageUpload').addEventListener('change', function (event) {
                const file = event.target.files[0];
                if (file) {
                    if (!file.type.startsWith('image/')) {
                        alert('Please select a valid image file.');
                        return;
                    }

                    const reader = new FileReader();
                    reader.onload = function (e) {
                        document.getElementById('txtImage').value = e.target.result;
                        document.getElementById('imagePreview').innerHTML = '<img src="' + e.target.result + '" width="150">';
                    };
                    reader.readAsDataURL(file);
                }
            });
        </script>
    </body>
</html>
