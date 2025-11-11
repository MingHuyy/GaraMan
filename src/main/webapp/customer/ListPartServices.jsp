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
            padding: 20px;
        }

        /* Header */
        header {
            background: white;
            color: #1e40af;
            padding: 0;
            box-shadow: 0 2px 10px rgba(59, 130, 246, 0.15);
            border-bottom: 3px solid #3b82f6;
            border-radius: 15px;
            margin-bottom: 20px;
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
            margin: 0 auto;
            padding: 0;
        }
        
        .search-keyword {
            text-align: center;
            color: #64748b;
            font-size: 16px;
            margin-bottom: 15px;
        }
        
        .search-keyword strong {
            color: #3b82f6;
            font-weight: 600;
        }

        /* Results Grid */
        .results-container {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
        }

        .results-section {
            background: white;
            border-radius: 15px;
            padding: 18px;
            box-shadow: 0 5px 20px rgba(0, 0, 0, 0.08);
        }

        .section-header {
            display: flex;
            align-items: center;
            gap: 10px;
            margin-bottom: 15px;
            padding-bottom: 10px;
            border-bottom: 2px solid #3b82f6;
        }

        .section-header h2 {
            color: #1e40af;
            font-size: 20px;
            font-weight: 700;
        }

        .section-header .count {
            background: #3b82f6;
            color: white;
            padding: 3px 10px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        /* Service Card */
        .service-item {
            background: #eff6ff;
            border-left: 4px solid #3b82f6;
            padding: 14px;
            margin-bottom: 10px;
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
            font-size: 16px;
            margin-bottom: 12px;
            min-height: 40px;
            display: flex;
            align-items: center;
        }

        .service-item .description {
            color: #666;
            font-size: 13px;
            margin-bottom: 12px;
            line-height: 1.5;
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
            font-size: 18px;
            font-weight: 700;
        }

        .service-duration {
            color: #666;
            font-size: 13px;
        }

        /* Part Card */
        .part-item {
            background: #eff6ff;
            border-left: 4px solid #10b981;
            padding: 14px;
            margin-bottom: 10px;
            border-radius: 8px;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .part-item:hover {
            transform: translateX(5px);
            box-shadow: 0 5px 15px rgba(16, 185, 129, 0.2);
        }

        .part-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 12px;
            gap: 10px;
            min-height: 40px;
        }

        .part-item h3 {
            color: #1e40af;
            font-size: 16px;
            flex: 1;
            margin: 0;
        }

        .part-supplier {
            color: #64748b;
            font-size: 13px;
            font-weight: 500;
            white-space: nowrap;
        }

        .part-supplier strong {
            color: #1e40af;
        }

        .part-details {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding-top: 10px;
            border-top: 1px solid #bfdbfe;
        }

        .part-price {
            color: #10b981;
            font-size: 18px;
            font-weight: 700;
        }

        .part-stock {
            color: #059669;
            font-size: 13px;
        }

        .stock-low {
            color: #f59e0b;
        }

        /* No Results */
        .no-results {
            text-align: center;
            padding: 60px 20px;
            color: #999;
        }

        .no-results-icon {
            font-size: 48px;
            margin-bottom: 10px;
        }

        /* Pagination */
        .pagination {
            display: flex;
            justify-content: center;
            align-items: center;
            gap: 8px;
            margin-top: 15px;
        }

        .pagination button {
            padding: 8px 14px;
            border: 2px solid #bfdbfe;
            background: white;
            color: #3b82f6;
            border-radius: 8px;
            cursor: pointer;
            font-weight: 600;
            transition: all 0.3s ease;
        }

        .pagination button:hover:not(:disabled) {
            background: #3b82f6;
            color: white;
        }

        .pagination button:disabled {
            opacity: 0.5;
            cursor: not-allowed;
        }

        .pagination button.active {
            background: #3b82f6;
            color: white;
        }

        .page-info {
            color: #64748b;
            font-size: 14px;
            font-weight: 500;
        }

        .item-list {
            min-height: 340px;
        }

        .hidden {
            display: none;
        }

    </style>
</head>
<body>
    <!-- Header -->
    <header>
        <nav>
            <a href="/" class="logo">
                <span class="logo-icon">🚗</span>
                <span>GaraMan</span>
            </a>
            <div class="page-title">Danh sách Dịch vụ & Phụ tùng</div>
            <div class="nav-links">
                <a href="customer/SearchPage.jsp">Quay lại tìm kiếm</a>
            </div>
        </nav>
    </header>

    <!-- Main Content -->
    <div class="container">

        <%
            String keyword = (String) request.getAttribute("keyword");
            if (keyword == null) {
                keyword = request.getParameter("keyword");
            }
            List<SupplierPart> supplierParts = (List<SupplierPart>) request.getAttribute("supplierParts");
            List<Service> services = (List<Service>) request.getAttribute("services");
            
            if (keyword != null && !keyword.trim().isEmpty()) {
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

                    <div class="item-list" id="partList">
                    <%
                        if (supplierParts != null && !supplierParts.isEmpty()) {
                            for (SupplierPart sp : supplierParts) {
                    %>
                        <a href="part?id=<%= sp.getSupplierPartId() %>" style="text-decoration: none; color: inherit; display: block;" class="part-card">
                            <div class="part-item">
                                <div class="part-header">
                                    <h3><%= sp.getPart().getName() %></h3>
                                    <span class="part-supplier"><strong>Hãng:</strong> <%= sp.getSupplier().getName() %></span>
                                </div>
                                
                                <div class="part-details">
                                    <span class="part-price">
                                        💰 <%= String.format("%,.0f", sp.getPrice()) %>đ
                                    </span>
                                    <span class="part-stock <%= sp.getQuantity() < 5 ? "stock-low" : "" %>">
                                        <%= sp.getQuantity() > 0 ? "✓ Còn: " + sp.getQuantity() : "⚠️ Hết hàng" %>
                                    </span>
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

                    <% if (supplierParts != null && supplierParts.size() > 4) { %>
                    <div class="pagination" id="partPagination">
                        <button onclick="changePage('part', -1)">‹ Trước</button>
                        <span class="page-info" id="partPageInfo">Trang 1</span>
                        <button onclick="changePage('part', 1)">Sau ›</button>
                    </div>
                    <% } %>
                </div>

                <!-- Dịch Vụ - Bên Phải -->
                <div class="results-section">
                    <div class="section-header">
                        <h2>🔧 Dịch Vụ</h2>
                        <span class="count"><%= services != null ? services.size() : 0 %></span>
                    </div>

                    <div class="item-list" id="serviceList">
                    <%
                        if (services != null && !services.isEmpty()) {
                            for (Service service : services) {
                    %>
                        <a href="service?id=<%= service.getServiceId() %>" style="text-decoration: none; color: inherit; display: block;" class="service-card">
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

                    <% if (services != null && services.size() > 4) { %>
                    <div class="pagination" id="servicePagination">
                        <button onclick="changePage('service', -1)">‹ Trước</button>
                        <span class="page-info" id="servicePageInfo">Trang 1</span>
                        <button onclick="changePage('service', 1)">Sau ›</button>
                    </div>
                    <% } %>
                </div>
            </div>
        <%
            } else {
        %>
            <div class="no-results">
                <div class="no-results-icon">🔍</div>
                <h3>Không có từ khóa tìm kiếm</h3>
                <p>Vui lòng quay lại trang tìm kiếm để nhập từ khóa</p>
            </div>
        <%
            }
        %>
    </div>

    <script>
        // Phân trang state
        const pagination = {
            part: {
                currentPage: 1,
                itemsPerPage: 4,
                totalItems: 0
            },
            service: {
                currentPage: 1,
                itemsPerPage: 4,
                totalItems: 0
            }
        };

        // Khởi tạo phân trang
        function initPagination() {
            // Phân trang Part
            const partCards = document.querySelectorAll('.part-card');
            pagination.part.totalItems = partCards.length;
            if (partCards.length > 0) {
                showPage('part', 1);
            }

            // Phân trang Service
            const serviceCards = document.querySelectorAll('.service-card');
            pagination.service.totalItems = serviceCards.length;
            if (serviceCards.length > 0) {
                showPage('service', 1);
            }
        }

        // Hiển thị trang
        function showPage(type, pageNumber) {
            const cards = document.querySelectorAll('.' + type + '-card');
            const itemsPerPage = pagination[type].itemsPerPage;
            const totalPages = Math.ceil(pagination[type].totalItems / itemsPerPage);
            
            // Validate page number
            if (pageNumber < 1) pageNumber = 1;
            if (pageNumber > totalPages) pageNumber = totalPages;
            
            pagination[type].currentPage = pageNumber;
            
            // Ẩn tất cả
            cards.forEach(card => {
                card.style.display = 'none';
            });
            
            // Hiển thị items của trang hiện tại
            const startIndex = (pageNumber - 1) * itemsPerPage;
            const endIndex = startIndex + itemsPerPage;
            
            for (let i = startIndex; i < endIndex && i < cards.length; i++) {
                cards[i].style.display = 'block';
            }
            
            // Cập nhật page info
            const pageInfo = document.getElementById(type + 'PageInfo');
            if (pageInfo) {
                pageInfo.textContent = 'Trang ' + pageNumber + '/' + totalPages;
            }
            
            // Cập nhật trạng thái nút
            updateButtons(type, pageNumber, totalPages);
        }

        // Cập nhật trạng thái nút
        function updateButtons(type, currentPage, totalPages) {
            const pagination = document.getElementById(type + 'Pagination');
            if (!pagination) return;
            
            const buttons = pagination.querySelectorAll('button');
            if (buttons.length >= 2) {
                buttons[0].disabled = currentPage <= 1;
                buttons[1].disabled = currentPage >= totalPages;
            }
        }

        // Chuyển trang
        function changePage(type, direction) {
            const newPage = pagination[type].currentPage + direction;
            showPage(type, newPage);
        }

        // Khởi tạo khi trang load
        window.addEventListener('DOMContentLoaded', function() {
            initPagination();
        });
    </script>
</body>
</html>

