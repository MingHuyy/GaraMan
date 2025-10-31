<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Nhập Phụ Tùng - GaraMan</title>
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
            color: #333;
        }

        /* Header */
        header {
            background: white;
            box-shadow: 0 2px 10px rgba(59, 130, 246, 0.15);
            border-bottom: 3px solid #3b82f6;
            position: sticky;
            top: 0;
            z-index: 1000;
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
            font-size: 24px;
            font-weight: 700;
            text-decoration: none;
            color: #1e40af;
        }

        .page-title {
            font-size: 20px;
            color: #1e40af;
            font-weight: 600;
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

        /* Container */
        .container {
            max-width: 1400px;
            margin: 20px auto;
            padding: 0 30px;
        }

        /* Info Section */
        .info-section {
            background: white;
            border-radius: 15px;
            padding: 20px 30px;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.1);
            margin-bottom: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 30px;
        }

        .info-group {
            display: flex;
            gap: 30px;
            align-items: center;
        }

        .info-item {
            display: flex;
            flex-direction: column;
            gap: 5px;
        }

        .info-label {
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
        }

        .info-value {
            font-size: 16px;
            color: #1e40af;
            font-weight: 600;
        }

        /* Supplier Selection */
        .supplier-selection {
            display: flex;
            align-items: center;
            gap: 15px;
        }

        .supplier-name {
            font-size: 16px;
            color: #1e40af;
            font-weight: 600;
        }

        .btn-select {
            background: #3b82f6;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 10px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-select:hover {
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        /* Products Section */
        .products-section {
            background: white;
            border-radius: 15px;
            padding: 20px 30px;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.1);
            min-height: 400px;
        }

        .section-header {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding-bottom: 15px;
            margin-bottom: 20px;
            border-bottom: 2px solid #3b82f6;
        }

        .section-header h2 {
            color: #1e40af;
            font-size: 22px;
            font-weight: 700;
        }

        /* No Supplier Message */
        .no-supplier {
            text-align: center;
            padding: 80px 20px;
            color: #64748b;
        }

        .no-supplier-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .no-supplier h3 {
            font-size: 20px;
            color: #1e40af;
            margin-bottom: 10px;
        }

        .no-supplier p {
            font-size: 15px;
        }

        /* Product Table */
        .product-table {
            width: 100%;
            border-collapse: collapse;
        }

        .product-table thead {
            background: #eff6ff;
        }

        .product-table th {
            padding: 12px;
            text-align: left;
            font-size: 14px;
            font-weight: 600;
            color: #1e40af;
            border-bottom: 2px solid #bfdbfe;
        }

        .product-table td {
            padding: 12px;
            font-size: 14px;
            color: #333;
            border-bottom: 1px solid #e5e7eb;
        }

        .product-table tbody tr:hover {
            background: #f8fafc;
        }

        /* Add Part Button */
        .add-part-section {
            margin-top: 20px;
            text-align: center;
        }

        .btn-add-part {
            background: #3b82f6;
            color: white;
            padding: 12px 30px;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-add-part:hover {
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }
    </style>
</head>
<body>
    <%
        String employeeName = (String) session.getAttribute("employeeName");
        
        if (employeeName == null) {
            response.sendRedirect("login.jsp?error=session");
            return;
        }
        
        // Lấy ngày hôm nay
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String todayStr = today.format(formatter);
        
        // Lấy supplier từ request (nếu có)
        String supplierId = request.getParameter("supplierId");
        String supplierName = request.getParameter("supplierName");
    %>

    <!-- Header -->
    <header>
        <nav>
            <a href="MainEmployee.jsp" class="logo">
                <span>🚗</span>
                <span>GaraMan</span>
            </a>
            <div class="page-title">Nhập Phụ Tùng</div>
            <div class="nav-links">
                <a href="MainEmployee.jsp">← Quay lại</a>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <div class="container">
        <!-- Info Section -->
        <div class="info-section">
            <div class="info-group">
                <div class="info-item">
                    <span class="info-label">📅 Ngày nhập</span>
                    <span class="info-value"><%= todayStr %></span>
                </div>
                <div class="info-item">
                    <span class="info-label">👤 Nhân viên</span>
                    <span class="info-value"><%= employeeName %></span>
                </div>
            </div>
            
            <div class="supplier-selection">
                <div class="info-item">
                    <span class="info-label">🏢 Nhà cung cấp</span>
                    <% if (supplierName != null && !supplierName.isEmpty()) { %>
                        <span class="supplier-name"><%= supplierName %></span>
                    <% } %>
                </div>
                <a href="searchSupplier" class="btn-select" style="text-decoration: none; display: inline-block;">
                    <%= supplierName != null && !supplierName.isEmpty() ? "Đổi" : "Chọn" %>
                </a>
            </div>
        </div>

        <!-- Products Section - Chỉ hiển thị khi đã chọn nhà cung cấp -->
        <% if (supplierId != null && !supplierId.isEmpty()) { %>
        <div class="products-section">
            <div class="section-header">
                <h2>📦 Danh sách phụ tùng</h2>
            </div>

            <!-- Product Table -->
            <table class="product-table">
                <thead>
                    <tr>
                        <th>STT</th>
                        <th>Mã phụ tùng</th>
                        <th>Tên phụ tùng</th>
                        <th>Đơn giá</th>
                        <th>Số lượng hiện tại</th>
                        <th>Số lượng nhập</th>
                    </tr>
                </thead>
            </table>

            <!-- Add Part Section -->
            <div class="add-part-section">
                <a href="searchPart?supplierId=<%= supplierId %>" class="btn-add-part">
                    ➕ Chọn phụ tùng
                </a>
            </div>
        </div>
        <% } %>
    </div>

</body>
</html>

