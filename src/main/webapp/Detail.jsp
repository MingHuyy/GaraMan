<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.example.Model.SupplierPart" %>
<%@ page import="org.example.Model.Service" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết - GaraMan</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            min-height: 100vh;
            padding: 15px;
        }

        /* Header */
        header {
            background: white;
            color: #1e40af;
            padding: 0;
            box-shadow: 0 2px 10px rgba(59, 130, 246, 0.15);
            border-bottom: 3px solid #3b82f6;
            margin-bottom: 20px;
            border-radius: 15px;
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
            padding: 0.8rem 2rem;
        }

        .logo {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 28px;
            font-weight: 700;
            text-decoration: none;
            color: #1e40af;
        }

        .logo-icon {
            font-size: 36px;
        }

        .page-title {
            font-size: 20px;
            color: #1e40af;
            font-weight: 600;
        }

        .nav-links {
            display: flex;
            gap: 20px;
        }

        .nav-links a {
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
            transition: color 0.3s ease;
            padding: 8px 16px;
            border-radius: 8px;
        }

        .nav-links a:hover {
            background: #eff6ff;
            color: #1e40af;
        }

        /* Container */
        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        /* Back Button */
        .back-button {
            margin-bottom: 15px;
        }

        .back-button a {
            display: inline-flex;
            align-items: center;
            gap: 6px;
            color: #3b82f6;
            text-decoration: none;
            font-weight: 500;
            padding: 8px 16px;
            border-radius: 10px;
            transition: all 0.3s ease;
            background: white;
            border: 2px solid #bfdbfe;
            font-size: 14px;
        }

        .back-button a:hover {
            background: #eff6ff;
            border-color: #93c5fd;
            transform: translateX(-5px);
        }

        /* Detail Card */
        .detail-card {
            background: white;
            border-radius: 20px;
            padding: 30px;
            box-shadow: 0 10px 40px rgba(59, 130, 246, 0.15);
        }

        .detail-header {
            border-bottom: 3px solid #3b82f6;
            padding-bottom: 18px;
            margin-bottom: 20px;
        }

        .detail-header h1 {
            font-size: 26px;
            color: #1e40af;
            margin-bottom: 8px;
        }

        .detail-badge {
            display: inline-block;
            background: #bfdbfe;
            color: #1e3a8a;
            padding: 6px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .detail-body {
            padding: 15px 0;
        }

        .detail-row {
            display: flex;
            padding: 14px 0;
            border-bottom: 1px solid #e5e7eb;
            align-items: center;
        }

        .detail-row:last-child {
            border-bottom: none;
        }

        .detail-label {
            flex: 0 0 180px;
            font-weight: 600;
            color: #64748b;
            font-size: 14px;
        }

        .detail-value {
            flex: 1;
            font-size: 16px;
            color: #1e40af;
            font-weight: 500;
        }

        .detail-value.price {
            font-size: 24px;
            color: #3b82f6;
            font-weight: 700;
        }

        .detail-value.description {
            color: #64748b;
            line-height: 1.6;
        }

        .detail-value .stock-badge {
            display: inline-block;
            padding: 5px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .stock-available {
            background: #d1fae5;
            color: #059669;
        }

        .stock-low {
            background: #fef3c7;
            color: #d97706;
        }

        .stock-out {
            background: #fee2e2;
            color: #dc2626;
        }

        /* Action Buttons */
        .action-buttons {
            margin-top: 25px;
            display: flex;
            gap: 12px;
        }

        .btn {
            flex: 1;
            padding: 12px 24px;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-align: center;
            text-decoration: none;
            display: inline-block;
        }

        .btn-primary {
            background: #3b82f6;
            color: white;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.3);
        }

        .btn-primary:hover {
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.4);
        }

        .btn-secondary {
            background: #eff6ff;
            color: #3b82f6;
            border: 2px solid #bfdbfe;
        }

        .btn-secondary:hover {
            background: #dbeafe;
            border-color: #93c5fd;
        }

        /* No Data */
        .no-data {
            text-align: center;
            padding: 60px 20px;
        }

        .no-data-icon {
            font-size: 80px;
            margin-bottom: 20px;
        }

        .no-data h2 {
            color: #1e40af;
            margin-bottom: 10px;
        }

        .no-data p {
            color: #64748b;
        }

    </style>
</head>
<body>
    <%
        SupplierPart supplierPart = (SupplierPart) request.getAttribute("supplierPart");
        Service service = (Service) request.getAttribute("service");
        String pageTitle = "";
        if (supplierPart != null) {
            pageTitle = "Chi tiết Phụ tùng";
        } else if (service != null) {
            pageTitle = "Chi tiết Dịch vụ";
        }
    %>
    
    <!-- Header -->
    <header>
        <nav>
            <a href="HomePage.jsp" class="logo">
                <span class="logo-icon">🚗</span>
                <span>GaraMan</span>
            </a>
            <% if (!pageTitle.isEmpty()) { %>
            <div class="page-title"><%= pageTitle %></div>
            <% } %>
            <div class="nav-links">
                <a href="SearchPage.jsp">Tìm kiếm</a>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <div class="container">
        <%
            if (supplierPart != null) {
                // Hiển thị chi tiết Phụ Tùng
        %>
            <!-- Back Button -->
            <div class="back-button">
                <a href="javascript:history.back()">
                    ← Quay lại
                </a>
            </div>
            
            <div class="detail-card">
                <div class="detail-header">
                    <h1><%= supplierPart.getPartName() %></h1>
                    <span class="detail-badge">⚙️ Phụ Tùng</span>
                </div>

                <div class="detail-body">
                    <div class="detail-row">
                        <div class="detail-label">📦 Tên phụ tùng</div>
                        <div class="detail-value"><%= supplierPart.getPartName() %></div>
                    </div>

                    <div class="detail-row">
                        <div class="detail-label">🏢 Nhà cung cấp</div>
                        <div class="detail-value"><%= supplierPart.getSupplierName() %></div>
                    </div>

                    <% if (supplierPart.getDescription() != null && !supplierPart.getDescription().isEmpty()) { %>
                    <div class="detail-row">
                        <div class="detail-label">📝 Mô tả</div>
                        <div class="detail-value description"><%= supplierPart.getDescription() %></div>
                    </div>
                    <% } %>

                    <div class="detail-row">
                        <div class="detail-label">💰 Giá</div>
                        <div class="detail-value price"><%= String.format("%,.0f", supplierPart.getPrice()) %>đ</div>
                    </div>

                    <div class="detail-row">
                        <div class="detail-label">📊 Tình trạng kho</div>
                        <div class="detail-value">
                            <% if (supplierPart.getQuantity() > 10) { %>
                                <span class="stock-badge stock-available">✓ Còn hàng: <%= supplierPart.getQuantity() %></span>
                            <% } else if (supplierPart.getQuantity() > 0) { %>
                                <span class="stock-badge stock-low">⚠️ Sắp hết: <%= supplierPart.getQuantity() %></span>
                            <% } else { %>
                                <span class="stock-badge stock-out">✗ Hết hàng</span>
                            <% } %>
                        </div>
                    </div>
                </div>

                <div class="action-buttons">
                    <a href="#" class="btn btn-secondary">
                        🛒 Thêm vào giỏ hàng
                    </a>
                    <a href="#" class="btn btn-primary">
                        💳 Mua ngay
                    </a>
                </div>
            </div>

        <%
            } else if (service != null) {
                // Hiển thị chi tiết Dịch Vụ
        %>
            <!-- Back Button -->
            <div class="back-button">
                <a href="javascript:history.back()">
                    ← Quay lại
                </a>
            </div>
            
            <div class="detail-card">
                <div class="detail-header">
                    <h1><%= service.getName() %></h1>
                    <span class="detail-badge">🔧 Dịch Vụ</span>
                </div>

                <div class="detail-body">
                    <div class="detail-row">
                        <div class="detail-label">🔧 Tên dịch vụ</div>
                        <div class="detail-value"><%= service.getName() %></div>
                    </div>

                    <% if (service.getDescription() != null && !service.getDescription().isEmpty()) { %>
                    <div class="detail-row">
                        <div class="detail-label">📝 Mô tả</div>
                        <div class="detail-value description"><%= service.getDescription() %></div>
                    </div>
                    <% } %>

                    <div class="detail-row">
                        <div class="detail-label">💰 Giá dịch vụ</div>
                        <div class="detail-value price"><%= String.format("%,.0f", service.getPrice()) %>đ</div>
                    </div>

                    <% if (service.getDuration() != null && service.getDuration() > 0) { %>
                    <div class="detail-row">
                        <div class="detail-label">⏱️ Thời gian thực hiện</div>
                        <div class="detail-value"><%= service.getDuration() %> phút</div>
                    </div>
                    <% } %>
                </div>

                <div class="action-buttons">
                    <a href="#" class="btn btn-primary" style="flex: none; width: 100%;">
                        📅 Đặt ngay
                    </a>
                </div>
            </div>

        <%
            } else {
                // Không có dữ liệu
        %>
            <div class="detail-card">
                <div class="no-data">
                    <div class="no-data-icon">❌</div>
                    <h2>Không tìm thấy thông tin</h2>
                    <p>Dữ liệu không tồn tại hoặc đã bị xóa</p>
                    
                    <div class="action-buttons" style="max-width: 400px; margin: 30px auto 0;">
                        <a href="SearchPage.jsp" class="btn btn-primary">
                            🔍 Tìm kiếm
                        </a>
                    </div>
                </div>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>

