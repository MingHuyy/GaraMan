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

        .quantity-input {
            width: 80px;
            padding: 8px;
            border: 2px solid #bfdbfe;
            border-radius: 8px;
            font-size: 14px;
            text-align: center;
            color: #1e40af;
        }

        .quantity-input:focus {
            outline: none;
            border-color: #3b82f6;
        }

        .price-input {
            width: 120px;
            padding: 8px;
            border: 2px solid #bfdbfe;
            border-radius: 8px;
            font-size: 14px;
            text-align: right;
            color: #1e40af;
        }

        .price-input:focus {
            outline: none;
            border-color: #3b82f6;
        }

        .db-price {
            color: #64748b;
            font-size: 13px;
        }

        .btn-remove {
            background: #ef4444;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 6px;
            font-size: 13px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-remove:hover {
            background: #dc2626;
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

        /* Total Section */
        .total-section {
            margin-top: 30px;
            padding-top: 20px;
            border-top: 3px solid #3b82f6;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .total-amount {
            font-size: 24px;
            font-weight: 700;
            color: #1e40af;
        }

        .total-label {
            font-size: 18px;
            color: #64748b;
            margin-right: 15px;
        }

        .btn-confirm {
            background: #10b981;
            color: white;
            padding: 15px 40px;
            border: none;
            border-radius: 12px;
            font-size: 16px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
        }

        .btn-confirm:hover {
            background: #059669;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(16, 185, 129, 0.3);
        }

        .btn-confirm:disabled {
            background: #94a3b8;
            cursor: not-allowed;
            transform: none;
        }

        /* Alert Message */
        .alert-message {
            background: #fef2f2;
            border: 2px solid #fca5a5;
            border-radius: 12px;
            padding: 15px 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            color: #dc2626;
            font-weight: 500;
            animation: slideDown 0.3s ease;
        }

        .alert-icon {
            font-size: 24px;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-10px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
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
        
        // Lấy ngày hôm nay
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String todayStr = today.format(formatter);
        
        // Chỉ lấy dữ liệu từ request và session - KHÔNG xử lý logic
        String supplierId = request.getParameter("supplierId");
        String supplierName = request.getParameter("supplierName");
        
        // Lấy danh sách phụ tùng từ session (nếu có)
        java.util.List<java.util.Map<String, String>> selectedParts = 
            (java.util.List<java.util.Map<String, String>>) session.getAttribute("selectedParts");
        
        // Kiểm tra nếu đổi nhà cung cấp thì xóa toàn bộ parts đã chọn
        String currentSupplierId = (String) session.getAttribute("currentSupplierId");
        if (supplierId != null && !supplierId.isEmpty()) {
            if (currentSupplierId != null && !currentSupplierId.equals(supplierId)) {
                // Đổi nhà cung cấp -> xóa toàn bộ parts cũ
                session.removeAttribute("selectedParts");
                selectedParts = new java.util.ArrayList<>();
                session.setAttribute("supplierChanged", "true");
            }
            // Cập nhật supplierId hiện tại
            session.setAttribute("currentSupplierId", supplierId);
        }
        
        if (selectedParts == null) {
            selectedParts = new java.util.ArrayList<>();
        }
    %>

    <!-- Header -->
    <header>
        <nav>
            <a href="MainEmployee.jsp" class="logo">
                <span class="logo-icon">🚗</span>
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
        <%
            String addSuccess = (String) session.getAttribute("addSuccess");
            String addError = (String) session.getAttribute("addError");
            String supplierChanged = (String) session.getAttribute("supplierChanged");
            
            if (supplierChanged != null) {
                session.removeAttribute("supplierChanged");
        %>
        <div class="alert-message" style="background: #fef3c7; border-color: #fcd34d; color: #d97706;">
            <span class="alert-icon">ℹ️</span>
            <span>Đã đổi nhà cung cấp. Danh sách phụ tùng đã được xóa!</span>
        </div>
        <% 
            } else if (addSuccess != null) {
                session.removeAttribute("addSuccess");
        %>
        <div class="alert-message" style="background: #ecfdf5; border-color: #6ee7b7; color: #059669;">
            <span class="alert-icon">✓</span>
            <span>Đã thêm phụ tùng thành công!</span>
        </div>
        <% 
            } else if (addError != null && "exists".equals(addError)) {
                session.removeAttribute("addError");
        %>
        <div class="alert-message">
            <span class="alert-icon">⚠️</span>
            <span>Phụ tùng này đã có trong danh sách!</span>
        </div>
        <% } %>
        
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
                <a href="../searchSupplier" class="btn-select" style="text-decoration: none; display: inline-block;">
                    <%= supplierName != null && !supplierName.isEmpty() ? "Đổi" : "Chọn" %>
                </a>
            </div>
        </div>

        <!-- Products Section - Luôn hiển thị -->
        <div class="products-section">
            <div class="section-header">
                <h2>📦 Danh sách phụ tùng</h2>
            </div>

            <% if (supplierId == null || supplierId.isEmpty()) { %>
                <!-- Thông báo khi chưa chọn nhà cung cấp -->
                <div class="no-supplier">
                    <div class="no-supplier-icon">📋</div>
                    <h3>Vui lòng chọn nhà cung cấp trước</h3>
                    <p>Bạn cần chọn nhà cung cấp để có thể thêm phụ tùng vào danh sách</p>
                </div>
            <% } else { %>
                <!-- Product Table -->
                <table class="product-table">
                        <thead>
                            <tr>
                                <th style="width: 5%">STT</th>
                                <th style="width: 25%">Tên phụ tùng</th>
                                <th style="width: 10%">Số lượng</th>
                                <th style="width: 13%">Giá bán</th>
                                <th style="width: 15%">Đơn giá nhập</th>
                                <th style="width: 15%">Thành tiền</th>
                                <th style="width: 8%">Thao tác</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                float totalAmount = 0f;

                                if (selectedParts != null && !selectedParts.isEmpty()) {
                                    for (int i = 0; i < selectedParts.size(); i++) {
                                        java.util.Map<String, String> part = selectedParts.get(i);

                                        // Chuyển đổi giá và số lượng (có kiểm tra null)
                                        float dbPrice = 0f;
                                        try {
                                            dbPrice = Float.parseFloat(part.get("price"));
                                        } catch (Exception e) { dbPrice = 0f; }

                                        int quantity = 0;
                                        try {
                                            quantity = Integer.parseInt(part.get("quantity"));
                                        } catch (Exception e) { quantity = 0; }

                                        // Lấy giá nhập (nếu đã nhập trước đó, nếu không thì dùng giá DB)
                                        String inputPriceStr = part.get("inputPrice");
                                        float inputPrice = 0f;
                                        if (inputPriceStr != null && !inputPriceStr.isEmpty()) {
                                            try {
                                                inputPrice = Float.parseFloat(inputPriceStr);
                                            } catch (Exception e) {
                                                inputPrice = dbPrice;
                                            }
                                        } else {
                                            inputPrice = dbPrice;
                                        }

                                        float subtotal = inputPrice * quantity;
                                        totalAmount += subtotal;
                            %>
                            <tr>
                                <td><%= i + 1 %></td>
                                <td><%= part.get("partName") %></td>
                                <td>
                                    <input type="number" 
                                           name="quantity_<%= i %>" 
                                           class="quantity-input" 
                                           value="<%= quantity %>" 
                                           min="1" 
                                           onchange="updateTotal()"
                                           required />
                                    <input type="hidden" name="supplierPartId_<%= i %>" value="<%= part.get("supplierPartId") %>" />
                                </td>
                                <td class="db-price"><%= String.format("%,.0f", dbPrice) %> đ</td>
                                <td>
                                    <input type="number" 
                                           name="price_<%= i %>" 
                                           class="price-input" 
                                           value="<%= String.format("%.0f", inputPrice) %>" 
                                           min="0" 
                                           step="1000"
                                           onchange="updateTotal()"
                                           required />
                                </td>
                                <td class="subtotal"><%= String.format("%,.0f", subtotal) %> đ</td>
                                <td>
                                    <form action="../partReceiving" method="post" style="display: inline;">
                                        <input type="hidden" name="action" value="remove" />
                                        <input type="hidden" name="supplierId" value="<%= supplierId %>" />
                                        <input type="hidden" name="supplierName" value="<%= supplierName %>" />
                                        <input type="hidden" name="removeIndex" value="<%= i %>" />
                                        <button type="submit" class="btn-remove">Xóa</button>
                                    </form>
                                </td>
                            </tr>
                            <% 
                                    }
                                }
                            %>
                        </tbody>
                    </table>

                <% if (selectedParts != null && !selectedParts.isEmpty()) { %>
                <!-- Total Section -->
                <form id="receiveForm" method="post" action="../confirmImport" onsubmit="return confirmSubmit()">
                    <input type="hidden" name="supplierId" value="<%= supplierId %>" />
                    <input type="hidden" name="supplierName" value="<%= supplierName %>" />
                    <%
                        for (int i = 0; i < selectedParts.size(); i++) {
                            java.util.Map<String, String> part = selectedParts.get(i);
                            float dbPrice = 0f;
                            try {
                                dbPrice = Float.parseFloat(part.get("price"));
                            } catch (Exception e) { dbPrice = 0f; }
                            
                            int quantity = 0;
                            try {
                                quantity = Integer.parseInt(part.get("quantity"));
                            } catch (Exception e) { quantity = 0; }
                            
                            String inputPriceStr = part.get("inputPrice");
                            float inputPrice = 0f;
                            if (inputPriceStr != null && !inputPriceStr.isEmpty()) {
                                try {
                                    inputPrice = Float.parseFloat(inputPriceStr);
                                } catch (Exception e) {
                                    inputPrice = dbPrice;
                                }
                            } else {
                                inputPrice = dbPrice;
                            }
                    %>
                    <input type="hidden" name="quantity_<%= i %>" id="hidden_quantity_<%= i %>" value="<%= quantity %>" />
                    <input type="hidden" name="price_<%= i %>" id="hidden_price_<%= i %>" value="<%= String.format("%.0f", inputPrice) %>" />
                    <input type="hidden" name="supplierPartId_<%= i %>" value="<%= part.get("supplierPartId") %>" />
                    <% } %>
                    
                    <div class="total-section">
                        <div>
                            <span class="total-label">Tổng tiền:</span>
                            <span class="total-amount" id="totalAmount"><%= String.format("%,.0f", totalAmount) %> đ</span>
                        </div>
                        <button type="submit" class="btn-confirm">✓ Xác nhận nhập hàng</button>
                    </div>
                </form>
                <% } %>

                <!-- Add Part Section -->
                <div class="add-part-section">
                    <a href="../searchPart?supplierId=<%= supplierId %>&supplierName=<%= java.net.URLEncoder.encode(supplierName != null ? supplierName : "", "UTF-8") %>" class="btn-add-part">
                        ➕ Chọn phụ tùng
                    </a>
                </div>
            <% } %>
        </div>
    </div>

    <script>
        function updateTotal() {
            let total = 0;
            const rows = document.querySelectorAll('.product-table tbody tr');
            
            rows.forEach((row, index) => {
                const quantityInput = row.querySelector('input[name="quantity_' + index + '"]');
                const priceInput = row.querySelector('input[name="price_' + index + '"]');
                
                if (quantityInput && priceInput) {
                    const quantity = parseInt(quantityInput.value) || 0;
                    const price = parseFloat(priceInput.value) || 0;
                    const subtotal = quantity * price;
                    
                    // Cập nhật thành tiền cho dòng này
                    const subtotalCell = row.querySelector('.subtotal');
                    if (subtotalCell) {
                        subtotalCell.textContent = subtotal.toLocaleString('vi-VN') + ' đ';
                    }
                    
                    // Cập nhật hidden inputs trong form xác nhận
                    const hiddenQuantity = document.getElementById('hidden_quantity_' + index);
                    const hiddenPrice = document.getElementById('hidden_price_' + index);
                    if (hiddenQuantity) hiddenQuantity.value = quantity;
                    if (hiddenPrice) hiddenPrice.value = price;
                    
                    total += subtotal;
                }
            });
            
            // Cập nhật tổng tiền
            const totalAmountElement = document.getElementById('totalAmount');
            if (totalAmountElement) {
                totalAmountElement.textContent = total.toLocaleString('vi-VN') + ' đ';
            }
        }

        function confirmSubmit() {
            const totalAmountText = document.getElementById('totalAmount').textContent;
            const supplierName = '<%= supplierName != null ? supplierName : "" %>';
            
            const message = 'Bạn có chắc chắn muốn xác nhận nhập hàng?\n\n' +
                          '🏢 Nhà cung cấp: ' + supplierName + '\n' +
                          '💰 Tổng tiền: ' + totalAmountText + '\n\n' +
                          'Sau khi xác nhận, hóa đơn sẽ được lưu vào hệ thống và không thể chỉnh sửa.';
            
            return confirm(message);
        }
    </script>
</body>
</html>

