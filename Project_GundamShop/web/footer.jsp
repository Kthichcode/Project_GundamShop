<%-- 
    Document   : footer
    Created on : Feb 19, 2025, 5:25:00 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<style>
    .footer {
        background-color: #176cd3; 
        color: #fff;
        padding: 3rem 0;
        margin-top: 2rem;
        font-family: Arial, sans-serif;
    }

    .footer-container {
        max-width: 1200px;
        margin: 0 auto;
        padding: 0 1.5rem;
        display: grid;
        grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
        gap: 2rem;
    }

    .footer-section h3 {
        font-size: 1.4rem;
        margin-bottom: 1rem;
        color: #00AEEF; 
        text-transform: uppercase;
    }

    .footer-section p, .footer-links li {
        font-size: 1rem;
        line-height: 1.6;
    }

    .footer-links {
        list-style: none;
        padding: 0;
    }

    .footer-links li {
        margin-bottom: 0.6rem;
    }

    .footer-links a {
        color: #fff;
        text-decoration: none;
        transition: all 0.3s ease-in-out;
        font-weight: 500;
    }

    .footer-links a:hover {
        color: #00AEEF;
        text-decoration: underline;
    }

    .social-links {
        display: flex;
        gap: 1rem;
        margin-top: 1rem;
    }

    .social-links a {
        display: inline-flex;
        align-items: center;
        justify-content: center;
        width: 40px;
        height: 40px;
        background: #00AEEF;
        color: #0044AA;
        border-radius: 50%;
        font-size: 1.5rem;
        transition: transform 0.3s ease;
    }

    .social-links a:hover {
        transform: scale(1.1);
        background: #fff;
        color: #0044AA;
    }

    .newsletter {
        margin-top: 1rem;
    }

    .newsletter input {
        width: 80%;
        padding: 0.8rem;
        border: none;
        border-radius: 5px;
        margin-right: 0.5rem;
        font-size: 1rem;
    }

    .newsletter button {
        padding: 0.8rem 1.2rem;
        border: none;
        background: #00AEEF;
        color: #0044AA;
        font-weight: bold;
        border-radius: 5px;
        cursor: pointer;
        transition: 0.3s;
    }

    .newsletter button:hover {
        background: #fff;
        color: #0044AA;
    }

    .copyright {
        text-align: center;
        padding-top: 2rem;
        margin-top: 2rem;
        border-top: 1px solid #00AEEF;
        font-size: 1rem;
        color: #ddd;
    }
</style>

<footer class="footer">
    <div class="footer-container">
        <!-- Giới thiệu -->
        <div class="footer-section">
            <h3>Về chúng tôi</h3>
            <p>Minh.Đạt Gunpla Shop chuyên cung cấp mô hình Gunpla chính hãng với giá tốt nhất. Chúng tôi cam kết mang đến sản phẩm chất lượng và dịch vụ tận tâm.</p>
        </div>
        
       
        <div class="footer-section">
            <h3>Danh mục sản phẩm</h3>
            <ul class="footer-links">
                <li><a href="ProductController?action=filterCategory&categoryId=3">SD (Super Deformed)</a></li>
                <li><a href="ProductController?action=filterCategory&categoryId=1">HG (High Grade</a></li>
                <li><a href="ProductController?action=filterCategory&categoryId=2">MG (Master Grade)</a></li>
                <li><a href="ProductController?action=filterCategory&categoryId=4">PG (Perfect Grade)</a></li>
                
            </ul>
        </div>

        
        <div class="footer-section">
            <h3>Liên hệ</h3>
            <p>📍 Địa chỉ: 123 Đường ABC, Quận XYZ</p>
            <p>📧 Email: MinhDatGunplaShop@gmail.com</p>
            <p>📞 Hotline: (84) 123-456-789</p>
        </div>
        
     
        <div class="footer-section">
            <h3>Theo dõi chúng tôi</h3>
            <p>Nhận thông tin mới nhất và ưu đãi từ Minh.Đạt Gunpla Shop.</p>
            <div class="newsletter">
                <input type="email" placeholder="Nhập email của bạn">
                <button>Đăng ký</button>
            </div>
            <div class="social-links">
                <a href="https://www.facebook.com/quoc.at.278457"><i class="fa fa-facebook"> </i>  <img src="img/Facebook_Logo_(2019).png" alt="Facebook Logo" width="40" height="40">  </a>
                <a href="https://www.youtube.com/@LeMing10"><i class="fa fa-twitter"></i>   <img src="img/Youtube1.png" alt="Youtube Logo" width="40" height="40"> </a>
                <a href="https://www.instagram.com/minbebong_14/"><i class="fa fa-instagram"></i>  <img src="img/instagram_logo_icon_187313.PNG" alt="Instagram Logo" width="40" height="40"> </a>
            </div>
        </div>
    </div>
    
    <div class="copyright">
        <p>&copy; 2025 Minh.Đạt Gunpla Shop. All Rights Reserved.</p>
    </div>
</footer>


