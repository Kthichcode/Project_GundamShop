<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Minh.Đạt Gunpla Shop - Home</title>
        <style>
          
            body {
                margin: 0;
                padding: 0;
                font-family: Arial, sans-serif;
                background-color: #f5f5f5;
            }

           
            .slideshow-container {
                position: relative;
                max-width: 1200px; 
                margin: 20px auto; 
                overflow: hidden;  
                border-radius: 8px; 
            }
            .mySlides {
                display: none;
            }
            .mySlides img {
                width: 100%;
                display: block;
            }
            .prev, .next {
                cursor: pointer;
                position: absolute;
                top: 50%;
                width: auto;
                margin-top: -22px;
                padding: 16px;
                color: white;
                font-weight: bold;
                font-size: 18px;
                transition: 0.6s ease;
                border-radius: 0 3px 3px 0;
                user-select: none;
            }
            .next {
                right: 0;
                border-radius: 3px 0 0 3px;
            }
            .prev:hover, .next:hover {
                background-color: rgba(0,0,0,0.4);
            }
            .dot-container {
                text-align: center;
                margin: 10px 0;
            }
            .dot {
                cursor: pointer;
                height: 15px;
                width: 15px;
                margin: 0 5px;
                background-color: #bbb;
                border-radius: 50%;
                display: inline-block;
                transition: background-color 0.6s ease;
            }
            .active-dot {
                background-color: #717171;
            }
            .dot:hover {
                background-color: #555;
            }

          
            .filter-container {
                max-width: 1200px;
                margin: 20px auto;
                text-align: center;
            }
            .filter-container select, .filter-container button {
                padding: 8px 12px;
                margin: 5px;
                font-size: 14px;
            }

           
            .product-container {
                display: flex;
                flex-wrap: wrap;
                justify-content: space-between;
                max-width: 1200px;
                margin: 20px auto;
            }
            .product-card {
                background-color: #fff;
                border: 1px solid #ddd;
                border-radius: 5px;
                width: 23%; /* 4 cột */
                margin-bottom: 20px;
                text-align: center;
                position: relative;
                padding: 10px;
                box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
            }
            .product-card img {
                width: 100%;
                height: 200px; 
                object-fit: cover; 
                border-bottom: 1px solid #ddd;
            }
            .product-card h3 {
                font-size: 14px;
                margin: 10px 0;
                color: #333;
            }
            .product-card .price {
                font-size: 16px;
                font-weight: bold;
                color: #e74c3c;
                margin: 5px 0;
            }
            .product-card .original-price {
                font-size: 14px;
                color: #999;
                text-decoration: line-through;
                margin-left: 5px;
            }
            .product-card .discount {
                position: absolute;
                top: 10px;
                right: 10px;
                background-color: #e74c3c;
                color: #fff;
                font-size: 12px;
                padding: 2px 5px;
                border-radius: 3px;
            }
        </style>
    </head>
    <body>
        <%@ include file="header.jsp" %>

       
        <div class="slideshow-container">
            <div class="mySlides">
                <img src="img/Ahihi.jpg" alt="Banner 1">
            </div>
            <div class="mySlides">
                <img src="img/Banner1.jpg" alt="Banner 2">
            </div>
            <div class="mySlides">
                <img src="img/Banner2.jpg" alt="Banner 3">
            </div>
            <div class="mySlides">
                <img src="img/Banner3.jpg" alt="Banner 4">
            </div>
            <a class="prev" onclick="plusSlides(-1)">&#10094;</a>
            <a class="next" onclick="plusSlides(1)">&#10095;</a>
        </div>
        <div class="dot-container">
            <span class="dot" onclick="currentSlide(1)"></span>
            <span class="dot" onclick="currentSlide(2)"></span>
            <span class="dot" onclick="currentSlide(3)"></span>
            <span class="dot" onclick="currentSlide(4)"></span>
        </div>

       
        <div class="filter-container">
            <form action="ProductController" method="GET">
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

       
        <div class="product-container">
            <c:forEach var="p" items="${list}">
                <div class="product-card">
                    <img src="img/${p.image_url}" alt="${p.name}">
                    <h3>${p.name}</h3>
                    <p class="price">${p.price}</p>
                </div>
            </c:forEach>
        </div>

        <%@ include file="footer.jsp" %>

        
        <script>
            let slideIndex = 1;
            showSlides(slideIndex);

            function plusSlides(n) {
                showSlides(slideIndex += n);
            }

            function currentSlide(n) {
                showSlides(slideIndex = n);
            }

            function showSlides(n) {
                let i;
                let slides = document.getElementsByClassName("mySlides");
                let dots = document.getElementsByClassName("dot");
                if (n > slides.length) {
                    slideIndex = 1;
                }
                if (n < 1) {
                    slideIndex = slides.length;
                }
                for (i = 0; i < slides.length; i++) {
                    slides[i].style.display = "none";
                }
                for (i = 0; i < dots.length; i++) {
                    dots[i].className = dots[i].className.replace(" active-dot", "");
                }
                slides[slideIndex - 1].style.display = "block";
                dots[slideIndex - 1].className += " active-dot";
            }

            let autoIndex = 0;
            autoSlide();
            function autoSlide() {
                let i;
                let slides = document.getElementsByClassName("mySlides");
                let dots = document.getElementsByClassName("dot");
                for (i = 0; i < slides.length; i++) {
                    slides[i].style.display = "none";
                }
                autoIndex++;
                if (autoIndex > slides.length) {
                    autoIndex = 1;
                }
                slides[autoIndex - 1].style.display = "block";
                for (i = 0; i < dots.length; i++) {
                    dots[i].className = dots[i].className.replace(" active-dot", "");
                }
                dots[autoIndex - 1].className += " active-dot";
                setTimeout(autoSlide, 3000);
            }
        </script>
    </body>
</html>
