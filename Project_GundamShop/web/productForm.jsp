<%-- 
    Document   : productForm
    Created on : Mar 24, 2025, 3:55:29 PM
    Author     : tamph
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <form action="AdminController">
            <input type="hidden" name="action" value="create"/>
            Product Name: <input type="text" name="name"> <br/>
            Description: <input type="text" name="description"> <br/>
            Price: <input type="text" name="price"> <br/>
            Quantity: <input type="number" name="stock_quantity"> <br/>           
            Category: <input type="text" name="category_id"> <br/>
            Image: <input type="text" name="image_url">  <br/>           
            <input type="submit" value="Save"/> <br/>
        </form>
    </body>
</html>
