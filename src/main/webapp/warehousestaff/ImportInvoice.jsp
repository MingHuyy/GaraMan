<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="org.example.Model.ImportInvoiceItem" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Chi Tiết Hóa Đơn Nhập - GaraMan</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            height: 100vh;
            color: #333;
            padding: 10px;
            overflow: hidden;
        }

        /* Container */
        .container {
            max-width: 100%;
            height: 100%;
            margin: 0;
            overflow-y: auto;
        }

        /* Success Alert */
        .success-alert {
            background: linear-gradient(135deg, #ecfdf5 0%, #d1fae5 100%);
            border: 2px solid #6ee7b7;
            border-radius: 10px;
            padding: 15px 20px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 12px;
            animation: slideDown 0.4s ease;
            box-shadow: 0 2px 10px rgba(16, 185, 129, 0.1);
        }

        .success-icon {
            font-size: 24px;
            color: #10b981;
        }

        .success-content h2 {
            color: #065f46;
            font-size: 16px;
            font-weight: 600;
            margin-bottom: 4px;
        }

        .success-content p {
            color: #059669;
            font-size: 13px;
            line-height: 1.5;
        }

        .success-content strong {
            color: #047857;
            font-weight: 600;
        }

        @keyframes slideDown {
            from {
                opacity: 0;
                transform: translateY(-20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        /* Invoice Card */
        .invoice-card {
            background: white;
            border-radius: 15px;
            box-shadow: 0 6px 25px rgba(59, 130, 246, 0.15);
            overflow: hidden;
            margin-bottom: 20px;
        }

        /* Header */
        .invoice-header {
            background: linear-gradient(135deg, #10b981 0%, #059669 100%);
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
            background: linear-gradient(135deg, #ecfdf5 0%, #d1fae5 100%);
            padding: 20px 25px;
            border-radius: 12px;
            margin-bottom: 25px;
            border: 2px solid #6ee7b7;
            box-shadow: 0 2px 10px rgba(16, 185, 129, 0.08);
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
            border-top: 2px solid #a7f3d0;
        }

        .total-label {
            font-size: 14px;
            color: #059669;
            font-weight: 500;
        }

        .total-value {
            font-size: 16px;
            color: #047857;
            font-weight: 600;
        }

        .grand-total-label {
            font-size: 17px;
            color: #065f46;
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

        .btn-print {
            background: #3b82f6;
            color: white;
        }

        .btn-print:hover {
            background: #2563eb;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(59, 130, 246, 0.3);
        }

        .btn-home {
            background: #10b981;
            color: white;
        }

        .btn-home:hover {
            background: #059669;
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(16, 185, 129, 0.3);
        }

        /* Print Styles */
        @media print {
            body {
                background: white;
                padding: 0;
            }

            .success-alert,
            .action-buttons {
                display: none !important;
            }

            .invoice-card {
                box-shadow: none;
                border: 1px solid #e5e7eb;
            }

            .invoice-header {
                background: #10b981 !important;
                -webkit-print-color-adjust: exact;
                print-color-adjust: exact;
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
        
        // Lấy thông tin từ session
        String invoiceCode = (String) session.getAttribute("successInvoiceCode");
        List<ImportInvoiceItem> invoiceItems =
                (List<ImportInvoiceItem>) session.getAttribute("invoiceItems");
        String supplierName = (String) session.getAttribute("invoiceSupplierName");
        String supplierId = (String) session.getAttribute("invoiceSupplierId");
        Float totalAmountObj = (Float) session.getAttribute("invoiceTotalAmount");
        float totalAmount = (totalAmountObj != null) ? totalAmountObj : 0f;
        
        if (invoiceCode == null || invoiceItems == null) {
            response.sendRedirect("MainEmployee.jsp");
            return;
        }
        
        // Lấy ngày hôm nay
        LocalDate today = LocalDate.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
        String todayStr = today.format(formatter);
    %>

    <div class="container">
        <!-- Invoice Card -->
        <div class="invoice-card" id="invoiceToPrint">
            <!-- Header -->
            <div class="invoice-header">
                <h1>📋 HÓA ĐƠN NHẬP HÀNG</h1>
                <p>Mã hóa đơn: <%= invoiceCode %></p>
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
                        <div class="info-item">
                            <span class="info-label">Trạng thái:</span>
                            <span class="info-value" style="color: #10b981;">✓ Hoàn thành</span>
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
                    <h3>📦 Chi tiết phụ tùng đã nhập</h3>
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
                                    ImportInvoiceItem item = invoiceItems.get(i);
                                    String partName = item.getSupplierPart().getPart().getName();
                                    int quantity = item.getQty();
                                    float price = item.getUnitPrice();
                                    float subtotal = item.getLineAmount();
                            %>
                            <tr>
                                <td style="text-align: center;"><%= i + 1 %></td>
                                <td><%= partName %></td>
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
            </div>
        </div>

        <!-- Action Buttons -->
        <div class="action-buttons">
            <button onclick="window.print()" class="btn btn-print">
                🖨️ In hóa đơn
            </button>
            <a href="MainEmployee.jsp" class="btn btn-home">
                🏠 Quay lại trang chủ
            </a>
        </div>
    </div>
</body>
</html>

