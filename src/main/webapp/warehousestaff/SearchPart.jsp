<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.example.Model.SupplierPart" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chọn Phụ Tùng - GaraMan</title>
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
            max-width: 1200px;
            margin: 20px auto;
            padding: 0 30px;
        }

        /* Supplier Info Section */
        .supplier-info {
            background: white;
            border-radius: 15px;
            padding: 20px 30px;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.1);
            margin-bottom: 20px;
        }

        .supplier-info-label {
            font-size: 13px;
            color: #64748b;
            font-weight: 500;
            margin-bottom: 5px;
        }

        .supplier-info-value {
            font-size: 18px;
            color: #1e40af;
            font-weight: 600;
        }

        /* Search Section */
        .search-section {
            background: white;
            border-radius: 15px;
            padding: 25px 30px;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.1);
            margin-bottom: 20px;
        }

        .search-form {
            display: flex;
            gap: 15px;
        }

        .search-input {
            flex: 1;
            padding: 15px 20px;
            border: 2px solid #bfdbfe;
            border-radius: 12px;
            font-size: 16px;
            color: #1e40af;
            background: #eff6ff;
        }

        .search-input:focus {
            outline: none;
            border-color: #3b82f6;
            background: white;
        }

        .btn-search {
            background: #3b82f6;
            color: white;
            padding: 15px 35px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-search:hover {
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(59, 130, 246, 0.3);
        }

        /* Results Section */
        .results-section {
            background: white;
            border-radius: 15px;
            padding: 25px 30px;
            box-shadow: 0 4px 15px rgba(59, 130, 246, 0.1);
        }

        .section-header {
            padding-bottom: 15px;
            margin-bottom: 20px;
            border-bottom: 2px solid #3b82f6;
        }

        .section-header h2 {
            color: #1e40af;
            font-size: 22px;
            font-weight: 700;
        }

        /* Part Table */
        .part-table {
            width: 100%;
            border-collapse: collapse;
        }

        .part-table thead {
            background: #eff6ff;
        }

        .part-table th {
            padding: 12px;
            text-align: left;
            font-size: 14px;
            font-weight: 600;
            color: #1e40af;
            border-bottom: 2px solid #bfdbfe;
        }

        .part-table td {
            padding: 12px;
            font-size: 14px;
            color: #333;
            border-bottom: 1px solid #e5e7eb;
        }

        .part-table tbody tr:hover {
            background: #f8fafc;
        }

        .btn-choose {
            background: #10b981;
            color: white;
            padding: 8px 20px;
            border: none;
            border-radius: 8px;
            font-size: 14px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-choose:hover {
            background: #059669;
            transform: scale(1.05);
        }

        /* No Results */
        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: #64748b;
        }

        .no-results-icon {
            font-size: 64px;
            margin-bottom: 20px;
        }

        .no-results h3 {
            font-size: 20px;
            color: #1e40af;
            margin-bottom: 10px;
        }
    </style>
</head>
<body>
    <%
        String employeeName = (String) session.getAttribute("employeeName");
        
        if (employeeName == null) {
            response.sendRedirect("../user/login.jsp?error=session");
            return;
        }
        
        String supplierId = request.getParameter("supplierId");
        String supplierName = request.getParameter("supplierName");
        String keyword = (String) request.getAttribute("keyword");
        List<SupplierPart> supplierParts = (List<SupplierPart>) request.getAttribute("supplierParts");
    %>

    <!-- Header -->
    <header>
        <nav>
            <a href="<%= request.getContextPath() %>/warehousestaff/MainEmployee.jsp" class="logo">
                <span class="logo-icon">🚗</span>
                <span>GaraMan</span>
            </a>
            <div class="page-title">Chọn Phụ Tùng</div>
            <div class="nav-links">
                <a href="<%= request.getContextPath() %>/partReceiving?supplierId=<%= supplierId %>&supplierName=<%= java.net.URLEncoder.encode(supplierName != null ? supplierName : "", "UTF-8") %>">← Quay lại</a>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <div class="container">
        <!-- Supplier Info Section -->
        <div class="supplier-info">
            <div class="supplier-info-label">🏢 Nhà cung cấp đã chọn</div>
            <div class="supplier-info-value"><%= supplierName != null ? supplierName : "" %></div>
        </div>

        <!-- Search Section -->
        <div class="search-section">
            <form action="<%= request.getContextPath() %>/searchPart" method="get" class="search-form">
                <input type="hidden" name="supplierId" value="<%= supplierId %>" />
                <input type="hidden" name="supplierName" value="<%= supplierName != null ? supplierName : "" %>" />
                <input 
                    type="text" 
                    name="keyword" 
                    class="search-input" 
                    placeholder="Nhập tên phụ tùng..."
                    value="<%= keyword != null ? keyword : "" %>"
                    required
                    autofocus
                />
                <button type="submit" class="btn-search">🔍 Tìm kiếm</button>
            </form>
        </div>

        <!-- Results Section -->
        <% if (keyword != null) { %>
        <div class="results-section">
            <div class="section-header">
                <h2>🔧 Kết quả tìm kiếm: "<%= keyword %>"</h2>
            </div>

            <% if (supplierParts != null && !supplierParts.isEmpty()) { %>
                <table class="part-table">
                    <thead>
                        <tr>
                            <th style="width: 8%">STT</th>
                            <th style="width: 10%">Mã PT</th>
                            <th style="width: 35%">Tên phụ tùng</th>
                            <th style="width: 15%">Đơn giá</th>
                            <th style="width: 12%">Tồn kho</th>
                            <th style="width: 20%">Hành động</th>
                        </tr>
                    </thead>
                    <tbody>
                        <% for (int i = 0; i < supplierParts.size(); i++) { 
                            SupplierPart sp = supplierParts.get(i);
                        %>
                        <tr>
                            <td><%= i + 1 %></td>
                            <td><%= sp.getPart().getPartId() %></td>
                            <td><%= sp.getPart().getName() %></td>
                            <td><%= String.format("%,.0f", sp.getPrice()) %> đ</td>
                            <td><%= sp.getQuantity() %></td>
                            <td>
                                <form action="<%= request.getContextPath() %>/partReceiving" method="post" style="display: inline;">
                                    <input type="hidden" name="action" value="add" />
                                    <input type="hidden" name="supplierId" value="<%= supplierId %>" />
                                    <input type="hidden" name="supplierName" value="<%= supplierName != null ? supplierName : "" %>" />
                                    <input type="hidden" name="supplierPartId" value="<%= sp.getSupplierPartId() %>" />
                                    <input type="hidden" name="partName" value="<%= sp.getPart().getName() %>" />
                                    <input type="hidden" name="price" value="<%= sp.getPrice() %>" />
                                    <input type="hidden" name="currentQuantity" value="<%= sp.getQuantity() %>" />
                                    <button type="submit" class="btn-choose">Chọn</button>
                                </form>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } else { %>
                <div class="no-results">
                    <div class="no-results-icon">🔍</div>
                    <h3>Không tìm thấy phụ tùng nào</h3>
                    <p>Vui lòng thử lại với từ khóa khác</p>
                </div>
            <% } %>
        </div>
        <% } %>
    </div>
</body>
</html>

