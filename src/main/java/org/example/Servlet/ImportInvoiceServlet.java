package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.DAO.ImportInvoiceDAO;
import org.example.DAO.ImportInvoiceItemDAO;
import org.example.DAO.SupplierPartDAO;
import org.example.Model.ImportInvoice;
import org.example.Model.ImportInvoiceItem;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.net.URLEncoder;

@WebServlet("/confirmImport")
public class ImportInvoiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ImportInvoiceDAO importInvoiceDAO;
    private SupplierPartDAO supplierPartDAO;
    private ImportInvoiceItemDAO importInvoiceItemDAO;

    @Override
    public void init() throws ServletException {
        importInvoiceDAO = new ImportInvoiceDAO();
        supplierPartDAO = new SupplierPartDAO();
        importInvoiceItemDAO = new ImportInvoiceItemDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        try {
            // Lấy thông tin từ request và session
            String supplierIdStr = request.getParameter("supplierId");
            String supplierName = request.getParameter("supplierName");
            Integer employeeId = (Integer) session.getAttribute("employeeId");

            @SuppressWarnings("unchecked")
            List<java.util.Map<String, String>> selectedParts =
                    (List<java.util.Map<String, String>>) session.getAttribute("selectedParts");

            if (selectedParts == null || selectedParts.isEmpty() || supplierIdStr == null) {
                response.sendRedirect("PartReceiving.jsp?error=nodata");
                return;
            }

            // Tạo danh sách chi tiết hóa đơn
            List<ImportInvoiceItem> invoiceItems = new ArrayList<>();
            List<Map<String, String>> invoiceItemsDisplay = new ArrayList<>();
            float totalAmount = 0f;

            for (int i = 0; i < selectedParts.size(); i++) {
                String quantityStr = request.getParameter("quantity_" + i);
                String priceStr = request.getParameter("price_" + i);
                String supplierPartIdStr = request.getParameter("supplierPartId_" + i);

                if (quantityStr != null && priceStr != null && supplierPartIdStr != null) {
                    Map<String, String> part = selectedParts.get(i);
                    
                    int quantity = Integer.parseInt(quantityStr);
                    float price = Float.parseFloat(priceStr);
                    float subtotal = quantity * price;

                    ImportInvoiceItem item = new ImportInvoiceItem();
                    item.setSupplierPartId(Integer.parseInt(supplierPartIdStr));
                    item.setQty(quantity);
                    item.setUnitPrice(price);
                    item.setLineAmount(subtotal);

                    invoiceItems.add(item);
                    
                    // Tạo Map để hiển thị trên JSP
                    Map<String, String> displayItem = new HashMap<>();
                    displayItem.put("supplierPartId", supplierPartIdStr);
                    displayItem.put("partName", part.get("partName"));
                    displayItem.put("quantity", String.valueOf(quantity));
                    displayItem.put("price", String.valueOf(price));
                    displayItem.put("subtotal", String.valueOf(subtotal));
                    invoiceItemsDisplay.add(displayItem);
                    
                    totalAmount += subtotal;
                }
            }

            // Tạo hóa đơn chính
            LocalDate today = LocalDate.now();
            String invoiceCode = "PN" + today.format(DateTimeFormatter.ofPattern("yyyyMMdd"))
                    + "-" + System.currentTimeMillis() % 10000;

            ImportInvoice invoice = new ImportInvoice();
            invoice.setInvoiceCode(invoiceCode);
            invoice.setDate(new Date());
            invoice.setTotalAmount(totalAmount);
            invoice.setStatus("COMPLETED");
            invoice.setSupplierId(Integer.parseInt(supplierIdStr));
            invoice.setEmployeeId(employeeId);

            // Lưu hóa đơn chính
            int importId = importInvoiceDAO.createImportInvoice(invoice);

            if (importId > 0) {
                boolean success = true;

                // Lưu chi tiết hóa đơn,cập nhật tồn kho
                for (ImportInvoiceItem item : invoiceItems) {
                    item.setImportId(importId);

                    if (!importInvoiceItemDAO.createImportInvoiceItem(item)) {
                        success = false;
                        break;
                    }

                    if (!supplierPartDAO.updateQuantity(item.getSupplierPartId(), item.getQty())) {
                        success = false;
                        break;
                    }
                }

                if (success) {
                    // Lưu thông tin vào session để hiển thị lại trong JSP
                    session.setAttribute("successInvoiceCode", invoiceCode);
                    session.setAttribute("successImportId", importId);
                    session.setAttribute("invoiceItems", invoiceItemsDisplay);
                    session.setAttribute("invoiceSupplierName", supplierName);
                    session.setAttribute("invoiceSupplierId", supplierIdStr);
                    session.setAttribute("invoiceTotalAmount", totalAmount);

                    // Xóa session cũ không cần thiết
                    session.removeAttribute("selectedParts");
                    session.removeAttribute("currentSupplierId");

                    // Chuyển đến trang chi tiết hóa đơn
                    response.sendRedirect("ImportInvoice.jsp");
                } else {
                    response.sendRedirect("PartReceiving.jsp?supplierId=" + supplierIdStr +
                            "&supplierName=" + URLEncoder.encode(supplierName, "UTF-8") +
                            "&error=savefailed");
                }
            } else {
                response.sendRedirect("PartReceiving.jsp?supplierId=" + supplierIdStr +
                        "&supplierName=" + URLEncoder.encode(supplierName, "UTF-8") +
                        "&error=createfailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            String supplierIdStr = request.getParameter("supplierId");
            String supplierName = request.getParameter("supplierName");
            response.sendRedirect("PartReceiving.jsp?supplierId=" + supplierIdStr +
                    "&supplierName=" + URLEncoder.encode(supplierName != null ? supplierName : "", "UTF-8") +
                    "&error=exception");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
