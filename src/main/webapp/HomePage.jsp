<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GaraMan - Trang Chủ</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #93c5fd 0%, #60a5fa 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 20px;
        }

        .container {
            max-width: 1200px;
            width: 100%;
        }

        /* Header Logo */
        .header-logo {
            text-align: center;
            margin-bottom: 50px;
            animation: fadeInDown 0.8s ease;
        }

        .logo-icon {
            font-size: 80px;
            margin-bottom: 15px;
            display: inline-block;
            animation: bounce 2s infinite;
        }

        .logo-text {
            font-size: 48px;
            font-weight: 700;
            color: white;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
            margin-bottom: 10px;
        }

        .logo-subtitle {
            font-size: 18px;
            color: rgba(255, 255, 255, 0.95);
            font-weight: 300;
        }

        /* Main Card */
        .main-card {
            background: white;
            border-radius: 30px;
            padding: 60px 50px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            animation: fadeInUp 0.8s ease;
        }

        .welcome-text {
            text-align: center;
            margin-bottom: 50px;
        }

        .welcome-text h1 {
            font-size: 36px;
            color: #1e40af;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .welcome-text p {
            font-size: 18px;
            color: #64748b;
            line-height: 1.6;
        }

        /* Action Buttons Grid */
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 25px;
            margin-bottom: 40px;
        }

        .action-btn {
            background: #bfdbfe;
            color: #1e3a8a;
            padding: 35px 30px;
            border: 2px solid #93c5fd;
            border-radius: 20px;
            font-size: 18px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.2);
            text-decoration: none;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 15px;
        }

        .action-btn:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.25);
            background: #93c5fd;
            border-color: #60a5fa;
        }

        .btn-icon {
            font-size: 48px;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
        }

        .btn-text {
            font-size: 20px;
        }

        .btn-description {
            font-size: 14px;
            font-weight: 400;
            opacity: 0.9;
            text-align: center;
        }

        /* Footer */
        .footer-info {
            text-align: center;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 1px solid #eee;
            color: #999;
            font-size: 14px;
        }

        /* Animations */
        @keyframes fadeInDown {
            from {
                opacity: 0;
                transform: translateY(-30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(30px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        @keyframes bounce {
            0%, 100% {
                transform: translateY(0);
            }
            50% {
                transform: translateY(-10px);
            }
        }

        /* Responsive */
        @media (max-width: 768px) {
            .main-card {
                padding: 40px 30px;
            }

            .logo-text {
                font-size: 36px;
            }

            .welcome-text h1 {
                font-size: 28px;
            }

            .actions-grid {
                grid-template-columns: 1fr;
            }

            .action-btn {
                padding: 30px 25px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <!-- Header Logo -->
        <div class="header-logo">
            <div class="logo-icon">🚗</div>
            <div class="logo-text">GaraMan</div>
            <div class="logo-subtitle">Hệ thống quản lý gara ô tô chuyên nghiệp</div>
        </div>

        <!-- Main Card -->
        <div class="main-card">
            <div class="welcome-text">
                <h1>Chào Mừng Đến Với GaraMan</h1>
                <p>Tra cứu thông tin dịch vụ, phụ tùng và quản lý gara ô tô một cách dễ dàng, nhanh chóng</p>
            </div>

            <!-- Action Buttons -->
            <div class="actions-grid">
                <!-- Tìm kiếm Dịch vụ/Phụ tùng -->
                <a href="SearchPage.jsp" class="action-btn">
                    <span class="btn-icon">🔍</span>
                    <span class="btn-text">Tìm Kiếm</span>
                    <span class="btn-description">Tra cứu dịch vụ & phụ tùng</span>
                </a>

                <!-- Đăng nhập -->
                <a href="login.jsp" class="action-btn">
                    <span class="btn-icon">👤</span>
                    <span class="btn-text">Đăng Nhập</span>
                    <span class="btn-description">Đăng nhập vào hệ thống</span>
                </a>

                <!-- Đăng ký -->
                <a href="login.jsp" class="action-btn">
                    <span class="btn-icon">📝</span>
                    <span class="btn-text">Đăng Ký</span>
                    <span class="btn-description">Tạo tài khoản mới</span>
                </a>
            </div>

            <!-- Footer Info -->
            <div class="footer-info">
                <p>🕒 <strong>Giờ làm việc:</strong> Thứ 2 - Chủ nhật | 8:00 - 18:00</p>
                <p>📞 <strong>Hotline:</strong> 0123 456 789 | 📧 <strong>Email:</strong> contact@garaman.vn</p>
                <p style="margin-top: 15px; opacity: 0.7;">&copy; 2024 GaraMan. All rights reserved.</p>
            </div>
        </div>
    </div>
</body>
</html>

