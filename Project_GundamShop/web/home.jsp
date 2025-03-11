<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Minh.Đạt Gunpla Shop - Home</title>
        <link rel="stylesheet" href="assets/css/home.css">
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
                <a href="ProductController?id=${p.product_id}" class="product-link">
                    <div class="product-card">
                        <img src="img/${p.image_url}" alt="${p.name}">
                        <h3>${p.name}</h3>
                        <p class="price">
                            <fmt:formatNumber value="${p.price}" pattern="#,##0" /> đ
                        </p>
                    </div>
                </a>
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
