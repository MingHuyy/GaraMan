<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>GaraMan - Trang Quản Lý</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #93c5fd 0%, #60a5fa 100%);
            height: 100vh;
            overflow: hidden;
            display: flex;
            flex-direction: column;
        }

        /* Header */
        header {
            background: white;
            box-shadow: 0 2px 10px rgba(59, 130, 246, 0.15);
            border-bottom: 3px solid #3b82f6;
        }

        nav {
            max-width: 1400px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 15px 30px;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 28px;
            font-weight: 700;
            color: #1e40af;
        }

        .logo-icon {
            font-size: 36px;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 20px;
        }

        .employee-details {
            text-align: right;
        }

        .employee-name {
            font-size: 16px;
            font-weight: 600;
            color: #1e40af;
        }

        .employee-meta {
            font-size: 13px;
            color: #64748b;
            margin-top: 2px;
        }

        .role-badge {
            display: inline-block;
            background: #3b82f6;
            color: white;
            padding: 3px 10px;
            border-radius: 12px;
            font-size: 11px;
            font-weight: 600;
            margin-left: 8px;
        }

        .btn-logout {
            background: #ef4444;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-logout:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.4);
        }

        /* Main Content */
        .container {
            max-width: 1400px;
            margin: 0 auto;
            padding: 25px 30px;
            flex: 1;
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .welcome-section {
            text-align: center;
            margin-bottom: 30px;
        }

        .welcome-section h1 {
            font-size: 32px;
            color: white;
            margin-bottom: 8px;
            text-shadow: 2px 2px 4px rgba(0,0,0,0.2);
        }

        .welcome-section p {
            font-size: 16px;
            color: rgba(255, 255, 255, 0.95);
        }

        /* Action Grid */
        .actions-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .action-card {
            background: white;
            border-radius: 15px;
            padding: 25px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s ease;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.2);
            text-decoration: none;
            color: inherit;
            display: flex;
            flex-direction: column;
            align-items: center;
            gap: 12px;
        }

        .action-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 25px rgba(59, 130, 246, 0.3);
            background: #eff6ff;
        }

        .card-icon {
            font-size: 48px;
            filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
        }

        .card-title {
            font-size: 18px;
            font-weight: 600;
            color: #1e40af;
        }

        .card-description {
            font-size: 13px;
            color: #64748b;
            line-height: 1.4;
        }
    </style>
</head>
<body>
    <%
        String employeeName = (String) session.getAttribute("employeeName");
        String phone = (String) session.getAttribute("phone");
        String role = (String) session.getAttribute("role");
        
        // Chuyển đổi role thành tiếng Việt
        String roleVi = "";
        if ("MANAGER".equals(role)) {
            roleVi = "Quản lý";
        } else if ("SALES".equals(role)) {
            roleVi = "Nhân viên bán hàng";
        } else if ("WAREHOUSE".equals(role)) {
            roleVi = "Thủ kho";
        } else if ("TECHNICAL_STAFF".equals(role)) {
            roleVi = "Nhân viên kỹ thuật";
        }
        
        if (employeeName == null) {
            response.sendRedirect("../user/login.jsp?error=session");
            return;
        }
    %>

    <!-- Header -->
    <header>
        <nav>
            <div class="logo">
                <span class="logo-icon">🚗</span>
                <span>GaraMan</span>
            </div>
            <div class="user-info">
                <div class="employee-details">
                    <div class="employee-name">
                        <%= employeeName %>
                        <span class="role-badge"><%= roleVi %></span>
                    </div>
                    <div class="employee-meta">
                        📞 <%= phone %>
                    </div>
                </div>
                <a href="../user/login.jsp" class="btn-logout">Đăng xuất</a>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <div class="container">
        <div class="welcome-section">
            <h1>Chào mừng, <%= employeeName %>!</h1>
            <p>Hệ thống quản lý GaraMan</p>
        </div>

        <!-- Action Cards -->
        <div class="actions-grid">
            <!-- Thêm phụ tùng -->
            <a href="PartReceiving.jsp" class="action-card">
                <span class="card-icon">📦</span>
                <span class="card-title">Nhập Phụ Tùng</span>
                <span class="card-description">Nhập phụ tùng từ nhà cung cấp</span>
            </a>

            <!-- Xem thống kê -->
            <a href="#" class="action-card">
                <span class="card-icon">📊</span>
                <span class="card-title">Xem Thống Kê</span>
                <span class="card-description">Báo cáo và phân tích dữ liệu</span>
            </a>

            <!-- Quản lý khách hàng -->
            <a href="#" class="action-card">
                <span class="card-icon">👥</span>
                <span class="card-title">Quản Lý Khách Hàng</span>
                <span class="card-description">Danh sách và thông tin khách hàng</span>
            </a>

            <!-- Quản lý đơn hàng -->
            <a href="#" class="action-card">
                <span class="card-icon">📋</span>
                <span class="card-title">Quản Lý Đơn Hàng</span>
                <span class="card-description">Theo dõi và xử lý đơn hàng</span>
            </a>

            <!-- Quản lý phụ tùng & dịch vụ -->
            <a href="#" class="action-card">
                <span class="card-icon">🔧</span>
                <span class="card-title">Quản Lý Phụ Tùng & Dịch Vụ</span>
                <span class="card-description">Danh sách phụ tùng và dịch vụ</span>
            </a>

            <!-- Tìm kiếm -->
            <a href="../customer/SearchPage.jsp" class="action-card">
                <span class="card-icon">🔍</span>
                <span class="card-title">Tìm Kiếm</span>
                <span class="card-description">Tra cứu phụ tùng và dịch vụ</span>
            </a>
        </div>
    </div>
</body>
</html>

