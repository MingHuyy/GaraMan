<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GaraMan - Hệ thống quản lý gara ô tô chuyên nghiệp</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: #ffffff;
            color: #333;
            line-height: 1.6;
        }

        /* Header & Navigation */
        header {
            background: linear-gradient(135deg, #dc2626 0%, #991b1b 100%);
            color: white;
            padding: 0;
            box-shadow: 0 2px 10px rgba(220, 38, 38, 0.3);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        nav {
            max-width: 1200px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 1rem 2rem;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 28px;
            font-weight: 700;
        }

        .logo-icon {
            font-size: 36px;
        }

        .nav-links {
            display: flex;
            list-style: none;
            gap: 2rem;
            align-items: center;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 0.5rem 1rem;
            border-radius: 5px;
        }

        .nav-links a:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .btn-login {
            background: #dc2626;
            color: #dc2626;
            padding: 0.6rem 1.5rem;
            border-radius: 25px;
            font-weight: 600;
            transition: all 0.3s ease;
            border: 2px solid white;
        }

        .btn-login:hover {
            background: transparent;
            color: white;
            transform: translateY(-2px);
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, rgba(220, 38, 38, 0.95) 0%, rgba(153, 27, 27, 0.95) 100%),
                        url('https://images.unsplash.com/photo-1486262715619-67b85e0b08d3?w=1600') center/cover;
            color: white;
            text-align: center;
            padding: 100px 20px;
            position: relative;
        }

        .hero h1 {
            font-size: 48px;
            margin-bottom: 20px;
            font-weight: 700;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.3);
        }

        .hero p {
            font-size: 20px;
            margin-bottom: 40px;
            max-width: 700px;
            margin-left: auto;
            margin-right: auto;
            opacity: 0.95;
        }

        /* Search Section */
        .search-section {
            max-width: 1200px;
            margin: -50px auto 0;
            padding: 0 20px;
            position: relative;
            z-index: 10;
        }

        .search-container {
            background: white;
            padding: 50px 40px;
            border-radius: 20px;
            box-shadow: 0 10px 40px rgba(0, 0, 0, 0.1);
        }

        .search-form-main {
            display: flex;
            gap: 15px;
            max-width: 800px;
            margin: 0 auto;
        }

        .search-input-main {
            flex: 1;
            padding: 18px 25px;
            border: 2px solid #fecaca;
            border-radius: 12px;
            font-size: 16px;
            transition: all 0.3s ease;
            background: #fef2f2;
        }

        .search-input-main:focus {
            outline: none;
            border-color: #dc2626;
            background: white;
            box-shadow: 0 0 0 3px rgba(220, 38, 38, 0.1);
        }

        .btn-search-main {
            background: linear-gradient(135deg, #dc2626 0%, #991b1b 100%);
            color: white;
            padding: 18px 40px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            box-shadow: 0 4px 15px rgba(220, 38, 38, 0.3);
            white-space: nowrap;
        }

        /* Features Section */
        .features {
            max-width: 1200px;
            margin: 80px auto;
            padding: 0 20px;
        }

        .section-title {
            text-align: center;
            margin-bottom: 60px;
        }

        .section-title h2 {
            font-size: 36px;
            color: #dc2626;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .section-title p {
            color: #666;
            font-size: 18px;
        }

        .features-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 30px;
        }

        .feature-card {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
            transition: all 0.3s ease;
            border: 2px solid transparent;
        }

        .feature-card:hover {
            border-color: #dc2626;
            transform: translateY(-5px);
            box-shadow: 0 10px 30px rgba(220, 38, 38, 0.15);
        }

        .feature-icon {
            font-size: 48px;
            margin-bottom: 20px;
            display: block;
        }

        .feature-card h3 {
            color: #dc2626;
            font-size: 20px;
            margin-bottom: 15px;
            font-weight: 600;
        }

        .feature-card p {
            color: #666;
            font-size: 15px;
            line-height: 1.8;
        }

        /* Services Overview */
        .services-overview {
            background: linear-gradient(135deg, #fef2f2 0%, #ffffff 100%);
            padding: 80px 20px;
            margin-top: 80px;
        }

        .services-content {
            max-width: 1200px;
            margin: 0 auto;
        }

        .services-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 25px;
            margin-top: 40px;
        }

        .service-item {
            background: white;
            padding: 25px;
            border-radius: 12px;
            border-left: 4px solid #dc2626;
            box-shadow: 0 3px 15px rgba(0, 0, 0, 0.05);
            transition: all 0.3s ease;
        }

        .service-item:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 20px rgba(220, 38, 38, 0.15);
        }

        .service-item h4 {
            color: #dc2626;
            margin-bottom: 10px;
            font-size: 18px;
            font-weight: 600;
        }

        .service-item p {
            color: #666;
            font-size: 14px;
        }

        /* CTA Section */
        .cta-section {
            background: linear-gradient(135deg, #dc2626 0%, #991b1b 100%);
            color: white;
            text-align: center;
            padding: 80px 20px;
            margin-top: 80px;
        }

        .cta-section h2 {
            font-size: 36px;
            margin-bottom: 20px;
            font-weight: 700;
        }

        .cta-section p {
            font-size: 18px;
            margin-bottom: 30px;
            opacity: 0.95;
        }

        .btn-cta {
            background: white;
            color: #dc2626;
            padding: 15px 40px;
            border: none;
            border-radius: 30px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.2);
        }

        .btn-cta:hover {
            transform: translateY(-3px);
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3);
        }

        /* Footer */
        footer {
            background: #1f2937;
            color: white;
            padding: 60px 20px 20px;
            margin-top: 80px;
        }

        .footer-content {
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
            gap: 40px;
            margin-bottom: 30px;
        }

        .footer-section h3 {
            color: #dc2626;
            margin-bottom: 20px;
            font-size: 20px;
            font-weight: 600;
        }

        .footer-section p,
        .footer-section a {
            color: #d1d5db;
            text-decoration: none;
            display: block;
            margin-bottom: 10px;
            font-size: 14px;
            transition: color 0.3s ease;
        }

        .footer-section a:hover {
            color: #dc2626;
        }

        .footer-bottom {
            text-align: center;
            padding-top: 30px;
            border-top: 1px solid #374151;
            color: #9ca3af;
            font-size: 14px;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .hero h1 {
                font-size: 32px;
            }

            .hero p {
                font-size: 16px;
            }

            .search-container {
                padding: 30px 20px;
            }

            .search-form-main {
                flex-direction: column;
            }

            .nav-links {
                gap: 1rem;
                font-size: 14px;
            }

            .logo {
                font-size: 22px;
            }

            .section-title h2 {
                font-size: 28px;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <nav>
            <div class="logo">
                <span class="logo-icon">🚗</span>
                <span>GaraMan</span>
            </div>
            <ul class="nav-links">
                <li><a href="MainCustomer.jsp">Trang chủ</a></li>
                <li><a href="#services">Dịch vụ</a></li>
                <li><a href="#about">Giới thiệu</a></li>
                <li><a href="#contact">Liên hệ</a></li>
                <li><a href="login.jsp" class="btn-login">Đăng nhập/Đăng ký</a></li>
            </ul>
        </nav>
    </header>

    <!-- Hero Section -->
    <section class="hero">
        <h1>Chào mừng đến với GaraMan</h1>
        <p>Hệ thống quản lý gara ô tô chuyên nghiệp - Tra cứu dịch vụ và phụ tùng nhanh chóng, dễ dàng</p>
    </section>

    <!-- Search Section -->
    <section class="search-section" id="search">
        <div class="search-container">
            <h2 style="text-align: center; color: #dc2626; margin-bottom: 30px; font-size: 28px;">
                🔍 Tìm Kiếm Dịch Vụ & Phụ Tùng
            </h2>
            <form action="search" method="get" class="search-form-main">
                <input 
                    type="text" 
                    name="keyword" 
                    class="search-input-main" 
                    placeholder="Nhập tên dịch vụ hoặc phụ tùng cần tìm (vd: thay dầu, lốp xe, má phanh...)"
                    required
                />
                <button type="submit" class="btn-search-main">
                    🔍 Tìm Kiếm
                </button>
            </form>
            <p style="text-align: center; color: #666; margin-top: 20px; font-size: 14px;">
                💡 Tìm kiếm nhanh chóng các dịch vụ sửa chữa và phụ tùng chính hãng
            </p>
        </div>
    </section>

    <!-- Features Section -->
    <section class="features">
        <div class="section-title">
            <h2>Tại Sao Chọn GaraMan?</h2>
            <p>Chúng tôi mang đến giải pháp quản lý gara hiện đại và chuyên nghiệp</p>
        </div>
        <div class="features-grid">
            <div class="feature-card">
                <span class="feature-icon">⚡</span>
                <h3>Tra Cứu Nhanh Chóng</h3>
                <p>Hệ thống tìm kiếm thông minh giúp bạn tra cứu dịch vụ và phụ tùng chỉ trong vài giây</p>
            </div>
            <div class="feature-card">
                <span class="feature-icon">💰</span>
                <h3>Giá Cả Minh Bạch</h3>
                <p>Thông tin giá cả rõ ràng, cạnh tranh cho tất cả dịch vụ và phụ tùng</p>
            </div>
            <div class="feature-card">
                <span class="feature-icon">✅</span>
                <h3>Chất Lượng Đảm Bảo</h3>
                <p>Phụ tùng chính hãng, dịch vụ chất lượng cao với đội ngũ kỹ thuật viên chuyên nghiệp</p>
            </div>
            <div class="feature-card">
                <span class="feature-icon">📱</span>
                <h3>Dễ Dàng Sử Dụng</h3>
                <p>Giao diện thân thiện, dễ sử dụng trên mọi thiết bị</p>
            </div>
        </div>
    </section>

    <!-- Services Overview -->
    <section class="services-overview" id="services">
        <div class="services-content">
            <div class="section-title">
                <h2>Dịch Vụ Của Chúng Tôi</h2>
                <p>Đa dạng dịch vụ sửa chữa và bảo dưỡng ô tô chuyên nghiệp</p>
            </div>
            <div class="services-grid">
                <div class="service-item">
                    <h4>🔧 Bảo Dưỡng Định Kỳ</h4>
                    <p>Kiểm tra và bảo dưỡng xe theo chu kỳ khuyến nghị</p>
                </div>
                <div class="service-item">
                    <h4>🛠️ Sửa Chữa Chung</h4>
                    <p>Sửa chữa các hư hỏng thường gặp của ô tô</p>
                </div>
                <div class="service-item">
                    <h4>⚙️ Thay Thế Phụ Tùng</h4>
                    <p>Thay thế phụ tùng chính hãng, chất lượng cao</p>
                </div>
                <div class="service-item">
                    <h4>🎨 Sơn Xe</h4>
                    <p>Dịch vụ sơn xe chuyên nghiệp, màu sắc bền đẹp</p>
                </div>
                <div class="service-item">
                    <h4>🔍 Kiểm Tra Toàn Diện</h4>
                    <p>Kiểm tra và chẩn đoán tình trạng xe</p>
                </div>
                <div class="service-item">
                    <h4>🚗 Chăm Sóc Ngoại Thất</h4>
                    <p>Rửa xe, đánh bóng, phủ ceramic</p>
                </div>
            </div>
        </div>
    </section>

    <!-- CTA Section -->
    <section class="cta-section">
        <h2>Sẵn Sàng Tìm Kiếm Thông Tin?</h2>
        <p>Bắt đầu tra cứu dịch vụ và phụ tùng cho xe của bạn ngay hôm nay</p>
        <button class="btn-cta" onclick="window.location.href='#search'">Bắt Đầu Ngay</button>
    </section>

    <!-- Footer -->
    <footer id="contact">
        <div class="footer-content">
            <div class="footer-section">
                <h3>Về GaraMan</h3>
                <p>Hệ thống quản lý gara ô tô chuyên nghiệp, mang đến trải nghiệm tốt nhất cho khách hàng.</p>
            </div>
            <div class="footer-section">
                <h3>Liên Kết</h3>
                <a href="MainCustomer.jsp">Trang chủ</a>
                <a href="MainCustomer.jsp#search">Tìm kiếm</a>
                <a href="#services">Dịch vụ</a>
                <a href="login.jsp">Đăng nhập nhân viên</a>
            </div>
            <div class="footer-section">
                <h3>Liên Hệ</h3>
                <p>📞 Điện thoại: 0123 456 789</p>
                <p>📧 Email: contact@garaman.vn</p>
                <p>📍 Địa chỉ: 123 Đường ABC, TP.HCM</p>
            </div>
            <div class="footer-section">
                <h3>Giờ Làm Việc</h3>
                <p>Thứ 2 - Thứ 6: 8:00 - 18:00</p>
                <p>Thứ 7: 8:00 - 17:00</p>
                <p>Chủ nhật: 9:00 - 15:00</p>
            </div>
        </div>
        <div class="footer-bottom">
            <p>&copy; 2024 GaraMan. All rights reserved.</p>
        </div>
    </footer>
</body>
</html>

