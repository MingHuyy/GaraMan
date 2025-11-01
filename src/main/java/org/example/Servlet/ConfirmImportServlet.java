package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.DAO.ImportInvoiceDAO;
import org.example.DAO.SupplierPartDAO;
import org.example.Model.ImportInvoice;
import org.example.Model.ImportInvoiceItem;

import java.io.IOException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.Date;
import java.util.List;
import java.util.Map;

@WebServlet("/confirmImport")
public class ConfirmImportServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ImportInvoiceDAO importInvoiceDAO;
    private SupplierPartDAO supplierPartDAO;

    @Override
    public void init() throws ServletException {
        importInvoiceDAO = new ImportInvoiceDAO();
        supplierPartDAO = new SupplierPartDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        try {
            List<Map<String, String>> invoiceItems =
                    (List<Map<String, String>>) session.getAttribute("invoiceItems");
            String supplierIdStr = (String) session.getAttribute("invoiceSupplierId");
            Double totalAmount = (Double) session.getAttribute("invoiceTotalAmount");
            Integer employeeId = (Integer) session.getAttribute("employeeId");

            if (invoiceItems == null || invoiceItems.isEmpty() || supplierIdStr == null) {
                response.sendRedirect("PartReceiving.jsp?error=nodata");
                return;
            }
            
            LocalDate today = LocalDate.now();
            String invoiceCode = "PN" + today.format(DateTimeFormatter.ofPattern("yyyyMMdd"))
                    + "-" + System.currentTimeMillis() % 10000;

            ImportInvoice invoice = new ImportInvoice();
            invoice.setInvoiceCode(invoiceCode);
            invoice.setDate(new Date());
            invoice.setTotalAmount(totalAmount.floatValue());
            invoice.setStatus("COMPLETED");
            invoice.setSupplierId(Integer.parseInt(supplierIdStr));
            invoice.setEmployeeId(employeeId);

            // Lưu hóa đơn
            int importId = importInvoiceDAO.createImportInvoice(invoice);

            if (importId > 0) {
                // Lưu chi tiết hóa đơn và cập nhật số lượng tồn kho
                boolean success = true;

                for (Map<String, String> item : invoiceItems) {

                    ImportInvoiceItem invoiceItem = new ImportInvoiceItem();
                    invoiceItem.setImportId(importId);
                    invoiceItem.setSupplierPartId(Integer.parseInt(item.get("supplierPartId")));
                    invoiceItem.setQty(Integer.parseInt(item.get("quantity")));
                    invoiceItem.setUnitPrice(Float.parseFloat(item.get("price")));
                    invoiceItem.setLineAmount(Float.parseFloat(item.get("subtotal")));

                    if (!importInvoiceDAO.createImportInvoiceItem(invoiceItem)) {
                        success = false;
                        break;
                    }

                    // Cập nhật số lượng tồn kho
                    if (!supplierPartDAO.updateQuantity(
                            Integer.parseInt(item.get("supplierPartId")),
                            Integer.parseInt(item.get("quantity")))) {
                        success = false;
                        break;
                    }
                }

                if (success) {
                    // Lưu mã hóa đơn vào session để hiển thị
                    session.setAttribute("successInvoiceCode", invoiceCode);
                    session.setAttribute("successImportId", importId);
                    
                    // Xóa session data không cần thiết
                    session.removeAttribute("selectedParts");
                    session.removeAttribute("currentSupplierId");

                    // Chuyển đến trang chi tiết hóa đơn
                    response.sendRedirect("ImportInvoiceDetail.jsp");
                } else {
                    response.sendRedirect("ImportInvoice.jsp?error=savefailed");
                }
            } else {
                response.sendRedirect("ImportInvoice.jsp?error=createfailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("ImportInvoice.jsp?error=exception");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

