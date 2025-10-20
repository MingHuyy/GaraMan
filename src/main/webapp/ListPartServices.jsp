<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.example.Model.Service" %>
<%@ page import="org.example.Model.Part" %>
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
            background: #f9fafb;
            color: #333;
        }

        /* Header */
        header {
            background: linear-gradient(135deg, #dc2626 0%, #991b1b 100%);
            color: white;
            padding: 0;
            box-shadow: 0 2px 10px rgba(220, 38, 38, 0.3);
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
            color: white;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            margin-left: 2rem;
            font-weight: 500;
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
            margin-bottom: 40px;
        }

        .search-form {
            display: flex;
            gap: 15px;
        }

        .search-input {
            flex: 1;
            padding: 15px 20px;
            border: 2px solid #fecaca;
            border-radius: 10px;
            font-size: 16px;
            background: #fef2f2;
        }

        .search-input:focus {
            outline: none;
            border-color: #dc2626;
            background: white;
        }

        .btn-search {
            background: linear-gradient(135deg, #dc2626 0%, #991b1b 100%);
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 10px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
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
            border-bottom: 2px solid #dc2626;
        }

        .section-header h2 {
            color: #dc2626;
            font-size: 24px;
            font-weight: 700;
        }

        .section-header .count {
            background: #dc2626;
            color: white;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 14px;
            font-weight: 600;
        }

        /* Service Card */
        .service-item {
            background: #fef2f2;
            border-left: 4px solid #dc2626;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 8px;
            transition: all 0.3s ease;
        }

        .service-item:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(220, 38, 38, 0.15);
        }

        .service-item h3 {
            color: #dc2626;
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
            border-top: 1px solid #fecaca;
        }

        .service-price {
            color: #dc2626;
            font-size: 20px;
            font-weight: 700;
        }

        .service-duration {
            color: #666;
            font-size: 14px;
        }

        /* Part Card */
        .part-item {
            background: #fef2f2;
            padding: 20px;
            margin-bottom: 15px;
            border-radius: 8px;
            border: 2px solid #fecaca;
            transition: all 0.3s ease;
        }

        .part-item:hover {
            border-color: #dc2626;
            box-shadow: 0 5px 15px rgba(220, 38, 38, 0.15);
        }

        .part-item h3 {
            color: #dc2626;
            font-size: 18px;
            margin-bottom: 15px;
        }

        .supplier-info {
            background: white;
            padding: 12px;
            margin-top: 10px;
            border-radius: 6px;
            border-left: 3px solid #dc2626;
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
            color: #dc2626;
            font-size: 18px;
            font-weight: 700;
        }

        .supplier-stock {
            color: #059669;
            font-size: 13px;
        }

        .stock-low {
            color: #dc2626;
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
            <a href="MainCustomer.jsp" class="logo">
                <span>🚗</span>
                <span>GaraMan</span>
            </a>
            <div class="nav-links">
                <a href="MainCustomer.jsp">Trang chủ</a>
                <a href="login.jsp">Đăng nhập</a>
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
            String keyword = request.getParameter("keyword");
            List<Service> services = (List<Service>) request.getAttribute("services");
            List<Part> parts = (List<Part>) request.getAttribute("parts");
            
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
            <div class="results-container">
                <!-- Dịch Vụ -->
                <div class="results-section">
                    <div class="section-header">
                        <h2>🔧 Dịch Vụ</h2>
                        <span class="count"><%= services != null ? services.size() : 0 %></span>
                    </div>

                    <%
                        if (services != null && !services.isEmpty()) {
                            for (Service service : services) {
                    %>
                        <div class="service-item">
                            <h3><%= service.getName() %></h3>
                            <% if (service.getDescription() != null && !service.getDescription().isEmpty()) { %>
                                <p class="description"><%= service.getDescription() %></p>
                            <% } %>
                            <div class="service-details">
                                <span class="service-price">
                                    <%= String.format("%,.0f", service.getPrice()) %>đ
                                </span>
                                <% if (service.getDuration() != null) { %>
                                    <span class="service-duration">
                                        ⏱️ <%= service.getDuration() %> phút
                                    </span>
                                <% } %>
                            </div>
                        </div>
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

                <!-- Phụ Tùng -->
                <div class="results-section">
                    <div class="section-header">
                        <h2>⚙️ Phụ Tùng</h2>
                        <span class="count"><%= parts != null ? parts.size() : 0 %></span>
                    </div>

                    <%
                        if (parts != null && !parts.isEmpty()) {
                            for (Part part : parts) {
                                // Lấy danh sách nhà cung cấp cho phụ tùng này
                                List<SupplierPart> supplierParts = (List<SupplierPart>) request.getAttribute("supplierParts_" + part.getPartId());
                    %>
                        <div class="part-item">
                            <h3><%= part.getName() %></h3>
                            
                            <%
                                if (supplierParts != null && !supplierParts.isEmpty()) {
                                    for (SupplierPart sp : supplierParts) {
                            %>
                                <div class="supplier-info">
                                    <% if (sp.getDescription() != null && !sp.getDescription().isEmpty()) { %>
                                        <div class="supplier-name"><%= sp.getDescription() %></div>
                                    <% } %>
                                    <div class="supplier-details">
                                        <span class="supplier-price">
                                            <%= String.format("%,.0f", sp.getUnitPrice()) %>đ
                                        </span>
                                        <span class="supplier-stock <%= sp.getStockQty() != null && sp.getStockQty() < 5 ? "stock-low" : "" %>">
                                            <%= sp.getStockQty() != null && sp.getStockQty() > 0 ? "✓ Còn hàng: " + sp.getStockQty() : "⚠️ Hết hàng" %>
                                        </span>
                                    </div>
                                </div>
                            <%
                                    }
                                } else {
                            %>
                                <p style="color: #999; font-size: 14px;">Chưa có thông tin nhà cung cấp</p>
                            <%
                                }
                            %>
                        </div>
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
            </div>
        <%
            }
        %>
    </div>
</body>
</html>

