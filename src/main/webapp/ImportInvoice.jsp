<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport"="width=device-width, initial-scale=1.0">
    <title>Xem Trước Hóa Đơn Nhập - GaraMan</title>
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

        /* Container */
        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        /* Invoice Card */
        .invoice-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 6px 25px rgba(59, 130, 246, 0.15);
            overflow: hidden;
        }

        /* Header */
        .invoice-header {
            background: linear-gradient(135deg, #3b82f6 0%, #2563eb 100%);
            color: white;
            padding: 30px;
            text-align: center;
        }

        .invoice-header h1 {
            font-size: 26px;
            font-weight: 700;
            margin-bottom: 8px;
        }

        .invoice-header p {
            font-size: 14px;
            opacity: 0.9;
        }

        /* Invoice Body */
        .invoice-body {
            padding: 30px;
        }

        /* Info Grid */
        .info-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 25px;
            margin-bottom: 30px;
            padding-bottom: 25px;
            border-bottom: 2px solid #e5e7eb;
        }

        .info-section h3 {
            color: #1e40af;
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 12px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .info-item {
            display: flex;
            justify-content: space-between;
            padding: 6px 0;
            font-size: 14px;
        }

        .info-label {
            color: #64748b;
            font-weight: 500;
        }

        .info-value {
            color: #1e40af;
            font-weight: 600;
        }

        /* Items Table */
        .items-section h3 {
            color: #1e40af;
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 15px;
            display: flex;
            align-items: center;
            gap: 8px;
        }

        .items-table {
            width: 100%;
            border-collapse: collapse;
            margin-bottom: 25px;
        }

        .items-table thead {
            background: #eff6ff;
        }

        .items-table th {
            padding: 12px;
            text-align: left;
            font-size: 13px;
            font-weight: 600;
            color: #1e40af;
            border-bottom: 2px solid #bfdbfe;
        }

        .items-table td {
            padding: 12px;
            font-size: 13px;
            color: #333;
            border-bottom: 1px solid #e5e7eb;
        }

        .items-table tbody tr:hover {
            background: #f8fafc;
        }

        .text-right {
            text-align: right;
        }

        /* Total Section */
        .total-section {
            background: #eff6ff;
            padding: 20px 25px;
            border-radius: 12px;
            margin-bottom: 25px;
        }

        .total-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 8px;
        }

        .total-row:last-child {
            margin-bottom: 0;
            padding-top: 12px;
            border-top: 2px solid #bfdbfe;
        }

        .total-label {
            font-size: 14px;
            color: #64748b;
            font-weight: 500;
        }

        .total-value {
            font-size: 16px;
            color: #1e40af;
            font-weight: 600;
        }

        .grand-total-label {
            font-size: 17px;
            color: #1e40af;
            font-weight: 700;
        }

        .grand-total-value {
            font-size: 24px;
            color: #10b981;
            font-weight: 700;
        }

        /* Action Buttons */
        .action-buttons {
            display: flex;
            gap: 12px;
            justify-content: center;
        }

        .btn {
            padding: 12px 35px;
            border: none;
            border-radius: 10px;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-block;
        }

        .btn-confirm {
            background: #10b981;
            color: white;
        }

        .btn-confirm:hover {
            background: #059669;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.3);
        }

        .btn-back {
            background: #64748b;
            color: white;
        }

        .btn-back:hover {
            background: #475569;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(100, 116, 139, 0.3);
        }

        /* Note Section */
        .note-section {
            background: #fef3c7;
            border-left: 4px solid #f59e0b;
            padding: 15px 18px;
            border-radius: 8px;
            margin-bottom: 25px;
        }

        .note-section h4 {
            color: #92400e;
            font-size: 14px;
            font-weight: 600;
            margin-bottom: 8px;
        }

        .note-section p {
            color: #78350f;
            font-size: 13px;
            line-height: 1.6;
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
        
        // Lấy thông tin hóa đơn từ session
        List<Map<String, String>> invoiceItems = 
            (List<Map<String, String>>) session.getAttribute("invoiceItems");
        String supplierName = (String) session.getAttribute("invoiceSupplierName");
        String supplierId = (String) session.getAttribute("invoiceSupplierId");
        Double totalAmount = (Double) session.getAttribute("invoiceTotalAmount");
        
        if (invoiceItems == null || invoiceItems.isEmpty()) {
            response.sendRedirect("PartReceiving.jsp?error=noitems");
            return;
        }
        
        // Lấy ngày hôm nay
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String todayStr = today.format(formatter);
        
        // Tạo mã hóa đơn tạm thời
        String invoiceCode = "PN" + today.format(DateTimeFormatter.ofPattern("yyyyMMdd")) + "-" + System.currentTimeMillis() % 10000;
    %>

    <div class="container">
        <div class="invoice-card">
            <!-- Header -->
            <div class="invoice-header">
                <h1>📋 XEM TRƯỚC HÓA ĐƠN NHẬP</h1>
                <p>Vui lòng kiểm tra kỹ thông tin trước khi xác nhận</p>
            </div>

            <!-- Body -->
            <div class="invoice-body">
                <!-- Info Grid -->
                <div class="info-grid">
                    <div class="info-section">
                        <h3>📄 Thông tin hóa đơn</h3>
                        <div class="info-item">
                            <span class="info-label">Mã hóa đơn:</span>
                            <span class="info-value"><%= invoiceCode %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Ngày nhập:</span>
                            <span class="info-value"><%= todayStr %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Nhân viên:</span>
                            <span class="info-value"><%= employeeName %></span>
                        </div>
                    </div>

                    <div class="info-section">
                        <h3>🏢 Thông tin nhà cung cấp</h3>
                        <div class="info-item">
                            <span class="info-label">Mã NCC:</span>
                            <span class="info-value"><%= supplierId %></span>
                        </div>
                        <div class="info-item">
                            <span class="info-label">Tên NCC:</span>
                            <span class="info-value"><%= supplierName %></span>
                        </div>
                    </div>
                </div>

                <!-- Items Table -->
                <div class="items-section">
                    <h3>📦 Chi tiết phụ tùng nhập</h3>
                    <table class="items-table">
                        <thead>
                            <tr>
                                <th style="width: 8%; text-align: center;">STT</th>
                                <th style="width: 40%">Tên phụ tùng</th>
                                <th style="width: 13%; text-align: right;">Số lượng</th>
                                <th style="width: 18%; text-align: right;">Đơn giá</th>
                                <th style="width: 21%; text-align: right;">Thành tiền</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% 
                                for (int i = 0; i < invoiceItems.size(); i++) {
                                    Map<String, String> item = invoiceItems.get(i);
                                    double price = Double.parseDouble(item.get("price"));
                                    int quantity = Integer.parseInt(item.get("quantity"));
                                    double subtotal = Double.parseDouble(item.get("subtotal"));
                            %>
                            <tr>
                                <td style="text-align: center;"><%= i + 1 %></td>
                                <td><%= item.get("partName") %></td>
                                <td class="text-right"><%= quantity %></td>
                                <td class="text-right"><%= String.format("%,.0f", price) %> đ</td>
                                <td class="text-right"><%= String.format("%,.0f", subtotal) %> đ</td>
                            </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>

                <!-- Total Section -->
                <div class="total-section">
                    <div class="total-row">
                        <span class="total-label">Tổng số lượng phụ tùng:</span>
                        <span class="total-value"><%= invoiceItems.size() %> loại</span>
                    </div>
                    <div class="total-row">
                        <span class="grand-total-label">TỔNG TIỀN:</span>
                        <span class="grand-total-value"><%= String.format("%,.0f", totalAmount) %> đ</span>
                    </div>
                </div>

                <!-- Note Section -->
                <div class="note-section">
                    <h4>⚠️ Lưu ý quan trọng:</h4>
                    <p>• Sau khi xác nhận, hóa đơn sẽ được lưu vào hệ thống và không thể chỉnh sửa.<br>
                       • Số lượng tồn kho của các phụ tùng sẽ được cập nhật tự động.<br>
                       • Vui lòng kiểm tra kỹ thông tin trước khi xác nhận.</p>
                </div>

                <!-- Action Buttons -->
                <div class="action-buttons">
                    <a href="PartReceiving.jsp?supplierId=<%= supplierId %>&supplierName=<%= java.net.URLEncoder.encode(supplierName, "UTF-8") %>" class="btn btn-back">
                        ← Quay lại chỉnh sửa
                    </a>
                    <form method="post" action="confirmImport" style="display: inline;">
                        <input type="hidden" name="supplierId" value="<%= supplierId %>" />
                        <input type="hidden" name="supplierName" value="<%= supplierName %>" />
                        <button type="submit" class="btn btn-confirm">
                            ✓ Xác nhận nhập hàng
                        </button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

