<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.example.Model.Service" %>
<%@ page import="org.example.Model.SupplierPart" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Kết Quả Tìm Kiếm - GaraMan</title>
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
            color: #1e40af;
            padding: 0;
            box-shadow: 0 2px 10px rgba(59, 130, 246, 0.15);
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
            font-size: 24px;
            font-weight: 700;
            text-decoration: none;
            color: #1e40af;
        }

        .nav-links a {
            color: #3b82f6;
            text-decoration: none;
            margin-left: 2rem;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: #1e40af;
        }

        /* Container */
        .container {
            max-width: 1400px;
            margin: 40px auto;
            padding: 0 20px;
        }

        /* Search Box */
        .search-box {
            background: white;
            padding: 30px;
            border-radius: 15px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.1);
            margin-bottom: 20px;
        }
        
        .search-keyword {
            text-align: center;
            color: #64748b;
            font-size: 16px;
            margin-bottom: 30px;
        }
        
        .search-keyword strong {
            color: #3b82f6;
            font-weight: 600;
        }

        .search-form {
            display: flex;
            gap: 15px;
        }

        .search-input {
            flex: 1;
            padding: 15px 20px;
            border: 2px solid #bfdbfe;
            border-radius: 10px;
            font-size: 16px;
            background: #eff6ff;
            color: #1e40af;
        }

        .search-input:focus {
            outline: none;
            border-color: #60a5fa;
            background: white;
            box-shadow: 0 0 0 3px rgba(96, 165, 250, 0.1);
        }

        .btn-search {
            background: #3b82f6;
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-search:hover {
            background: #2563eb;
            transform: translateY(-2px);
        }

        /* Results Grid */
        .results-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 30px;
        }

        .results-section {
            background: white;
            border-radius: 15px;
            padding: 30px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 25px;
            padding-bottom: 15px;
            border-bottom: 2px solid #3b82f6;
        }

        .section-header h2 {
            color: #1e40af;
            font-size: 24px;
            font-weight: 700;
        }

        .section-header .count {
            background: #3b82f6;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        /* Service Card */
        .service-item {
            background: #eff6ff;
            border-left: 4px solid #3b82f6;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 8px;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .service-item:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(59, 130, 246, 0.2);
        }

        .service-item h3 {
            color: #1e40af;
            font-size: 18px;
            margin-bottom: 8px;
        }

        .service-item .description {
            color: #666;
            font-size: 14px;
            margin-bottom: 12px;
            line-height: 1.6;
        }

        .service-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 10px;
            border-top: 1px solid #bfdbfe;
        }

        .service-price {
            color: #3b82f6;
            font-size: 20px;
            font-weight: 700;
        }

        .service-duration {
            color: #666;
            font-size: 14px;
        }

        /* Part Card */
        .part-item {
            background: #eff6ff;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 2px solid #bfdbfe;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .part-item:hover {
            border-color: #3b82f6;
            box-shadow: 0 5px 15px rgba(59, 130, 246, 0.2);
            transform: scale(1.02);
        }

        .part-item h3 {
            color: #1e40af;
            font-size: 18px;
            margin-bottom: 15px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 15px;
        }
        
        .part-name {
            flex: 1;
        }
        
        .part-supplier {
            color: #64748b;
            font-size: 14px;
            font-weight: 500;
            white-space: nowrap;
        }
        
        .part-supplier strong {
            color: #1e40af;
        }

        .supplier-info {
            background: white;
            padding: 12px;
            margin-top: 10px;
            border-radius: 6px;
            border-left: 3px solid #3b82f6;
        }

        .supplier-name {
            font-weight: 600;
            color: #333;
            font-size: 14px;
            margin-bottom: 5px;
        }

        .supplier-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-top: 8px;
        }

        .supplier-price {
            color: #3b82f6;
            font-size: 18px;
            font-weight: 700;
        }

        .supplier-stock {
            color: #059669;
            font-size: 13px;
        }

        .stock-low {
            color: #f59e0b;
        }

        /* No Results */
        .no-results {
            text-align: center;
            padding: 40px;
            color: #999;
        }

        .no-results-icon {
            font-size: 64px;
            margin-bottom: 15px;
        }

        @media (max-width: 968px) {
            .results-container {
                grid-template-columns: 1fr;
            }

            .search-form {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <nav>
            <a href="HomePage.jsp" class="logo">
                <span>🚗</span>
                <span>GaraMan</span>
            </a>
            <div class="nav-links">
                <a href="HomePage.jsp">Trang chủ</a>
                <a href="SearchPage.jsp">← Quay lại tìm kiếm</a>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <div class="container">
        <!-- Search Box -->
        <div class="search-box">
            <form class="search-form" action="search" method="get">
                <input 
                    type="text" 
                    name="keyword" 
                    class="search-input" 
                    placeholder="Nhập tên dịch vụ hoặc phụ tùng cần tìm..."
                    value="<%= request.getParameter("keyword") != null ? request.getParameter("keyword") : "" %>"
                />
                <button type="submit" class="btn-search">🔍 Tìm kiếm</button>
            </form>
        </div>

        <%
            String keyword = (String) request.getAttribute("keyword");
            if (keyword == null) {
                keyword = request.getParameter("keyword");
            }
            List<SupplierPart> supplierParts = (List<SupplierPart>) request.getAttribute("supplierParts");
            List<Service> services = (List<Service>) request.getAttribute("services");
            
            if (keyword == null || keyword.trim().isEmpty()) {
        %>
            <div class="no-results">
                <div class="no-results-icon">🔍</div>
                <h3>Nhập từ khóa để tìm kiếm</h3>
                <p>Vui lòng nhập tên dịch vụ hoặc phụ tùng bạn cần tìm</p>
            </div>
        <%
            } else {
        %>
            <!-- Từ khóa tìm kiếm -->
            <div class="search-keyword">
                Kết quả tìm kiếm của: <strong>"<%= keyword %>"</strong>
            </div>
            
            <!-- Kết quả tìm kiếm - 2 cột -->
            <div class="results-container">
                <!-- Phụ Tùng - Bên Trái -->
                <div class="results-section">
                    <div class="section-header">
                        <h2>⚙️ Phụ Tùng</h2>
                        <span class="count"><%= supplierParts != null ? supplierParts.size() : 0 %></span>
                    </div>

                    <%
                        if (supplierParts != null && !supplierParts.isEmpty()) {
                            for (SupplierPart sp : supplierParts) {
                    %>
                        <a href="part?id=<%= sp.getSupplierPartId() %>" style="text-decoration: none; color: inherit; display: block;">
                            <div class="part-item">
                                <h3>
                                    <span class="part-name"><%= sp.getPartName() %></span>
                                    <span class="part-supplier"><strong>Hãng:</strong> <%= sp.getSupplierName() %></span>
                                </h3>
                                
                                <div class="supplier-info">
                                <div class="supplier-details">
                                    <span class="supplier-price">
                                        💰 <%= String.format("%,.0f", sp.getPrice()) %>đ
                                    </span>
                                        <span class="supplier-stock <%= sp.getQuantity() < 5 ? "stock-low" : "" %>">
                                            <%= sp.getQuantity() > 0 ? "✓ Còn hàng: " + sp.getQuantity() : "⚠️ Hết hàng" %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </a>
                    <%
                            }
                        } else {
                    %>
                        <div class="no-results">
                            <div class="no-results-icon">⚙️</div>
                            <p>Không tìm thấy phụ tùng nào</p>
                        </div>
                    <%
                        }
                    %>
                </div>

                <!-- Dịch Vụ - Bên Phải -->
                <div class="results-section">
                    <div class="section-header">
                        <h2>🔧 Dịch Vụ</h2>
                        <span class="count"><%= services != null ? services.size() : 0 %></span>
                    </div>

                    <%
                        if (services != null && !services.isEmpty()) {
                            for (Service service : services) {
                    %>
                        <a href="service?id=<%= service.getServiceId() %>" style="text-decoration: none; color: inherit; display: block;">
                            <div class="service-item">
                                <h3><%= service.getName() %></h3>
                                
                                <div class="service-details">
                                    <span class="service-price">
                                        💰 <%= String.format("%,.0f", service.getPrice()) %>đ
                                    </span>
                                    <% if (service.getDuration() != null && service.getDuration() > 0) { %>
                                        <span class="service-duration">
                                            ⏱️ <%= service.getDuration() %> phút
                                        </span>
                                    <% } %>
                                </div>
                            </div>
                        </a>
                    <%
                            }
                        } else {
                    %>
                        <div class="no-results">
                            <div class="no-results-icon">🔧</div>
                            <p>Không tìm thấy dịch vụ nào</p>
                        </div>
                    <%
                        }
                    %>
                </div>
            </div>
        <%
            }
        %>
    </div>
</body>
</html>

