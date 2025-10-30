<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Tìm Kiếm - GaraMan</title>
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
            padding: 10px;
        }

        /* Header */
        .header {
            max-width: 1200px;
            margin: 0 auto 40px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 10px;
            background: white;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.15);
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 28px;
            font-weight: 700;
            color: #1e40af;
            text-decoration: none;
        }

        .logo-icon {
            font-size: 36px;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .nav-links a:hover {
            background: #eff6ff;
            color: #1e40af;
        }

        /* Main Container */
        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        /* Search Card */
        .search-card {
            background: white;
            border-radius: 25px;
            padding: 35px 30px;
            box-shadow: 0 10px 40px rgba(59, 130, 246, 0.2);
            text-align: center;
        }

        .search-title {
            font-size: 36px;
            color: #1e40af;
            margin-bottom: 15px;
            font-weight: 700;
        }

        .search-subtitle {
            font-size: 18px;
            color: #64748b;
            margin-bottom: 40px;
            line-height: 1.6;
        }

        /* Search Form */
        .search-form {
            display: flex;
            gap: 15px;
            margin-bottom: 30px;
        }

        .search-input {
            flex: 1;
            padding: 20px 25px;
            border: 2px solid #bfdbfe;
            border-radius: 15px;
            font-size: 16px;
            background: #eff6ff;
            transition: all 0.3s ease;
            color: #1e40af;
        }

        .search-input::placeholder {
            color: #93c5fd;
        }

        .search-input:focus {
            outline: none;
            border-color: #60a5fa;
            background: white;
            box-shadow: 0 0 0 4px rgba(96, 165, 250, 0.1);
        }

        .btn-search {
            background: #3b82f6;
            color: white;
            padding: 20px 40px;
            border: none;
            border-radius: 15px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
            white-space: nowrap;
        }

        .btn-search:hover {
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.4);
        }

        .btn-search:active {
            transform: translateY(0);
        }

        /* Search Tips */
        .search-tips {
            background: #eff6ff;
            padding: 25px;
            border-radius: 15px;
            border-left: 4px solid #3b82f6;
            text-align: left;
        }

        .search-tips h3 {
            color: #1e40af;
            font-size: 18px;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .search-tips ul {
            list-style: none;
            color: #64748b;
        }

        .search-tips li {
            padding: 8px 0;
            padding-left: 25px;
            position: relative;
        }

        .search-tips li:before {
            content: "💡";
            position: absolute;
            left: 0;
        }

        /* Responsive */
        @media (max-width: 768px) {
            .search-card {
                padding: 40px 30px;
            }

            .search-title {
                font-size: 28px;
            }

            .search-form {
                flex-direction: column;
            }

            .header {
                flex-direction: column;
                gap: 15px;
            }

            .nav-links {
                flex-wrap: wrap;
                justify-content: center;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <div class="header">
        <a href="HomePage.jsp" class="logo">
            <span class="logo-icon">🚗</span>
            <span>GaraMan</span>
        </a>
        <div class="nav-links">
            <a href="login.jsp">Đăng nhập</a>
        </div>
    </div>

    <!-- Main Content -->
    <div class="container">
        <div class="search-card">
            <h1 class="search-title">🔍 Tìm Kiếm Dịch Vụ & Phụ Tùng</h1>
            <p class="search-subtitle">
                Nhập từ khóa để tìm kiếm các dịch vụ sửa chữa và phụ tùng chính hãng
            </p>

            <!-- Search Form -->
            <form action="search" method="get" class="search-form">
                <input 
                    type="text" 
                    name="keyword" 
                    class="search-input" 
                    placeholder="Nhập tên dịch vụ hoặc phụ tùng (vd: thay dầu, lốp xe, má phanh...)"
                    required
                    autofocus
                />
                <button type="submit" class="btn-search">
                    🔍 Tìm Kiếm
                </button>
            </form>

            <!-- Search Tips -->
            <div class="search-tips">
                <h3>💡 Gợi ý tìm kiếm</h3>
                <ul>
                    <li>Dịch vụ: thay dầu, sửa phanh, bảo dưỡng định kỳ, sơn xe...</li>
                    <li>Phụ tùng: lốp xe, má phanh, dầu nhớt, bộ lọc...</li>
                    <li>Bạn có thể tìm kiếm theo tên gọi thông dụng</li>
                </ul>
            </div>
        </div>
    </div>
</body>
</html>

