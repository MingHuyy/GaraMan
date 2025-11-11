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
import org.example.Model.SupplierPart;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

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
                response.sendRedirect("warehousestaff/PartReceiving.jsp?error=nodata");
                return;
            }

            List<ImportInvoiceItem> invoiceItems = new ArrayList<>();

            for (int i = 0; i < selectedParts.size(); i++) {
                String quantityStr = request.getParameter("quantity_" + i);
                String priceStr = request.getParameter("price_" + i);
                String supplierPartIdStr = request.getParameter("supplierPartId_" + i);

                if (quantityStr != null && priceStr != null && supplierPartIdStr != null) {
                    int quantity = Integer.parseInt(quantityStr);
                    float price = Float.parseFloat(priceStr);
                    int supplierPartId = Integer.parseInt(supplierPartIdStr);

                    SupplierPart supplierPart = supplierPartDAO.getSupplierPartById(supplierPartId);

                    ImportInvoiceItem item = new ImportInvoiceItem();
                    item.setSupplierPart(supplierPart);
                    item.setQty(quantity);
                    item.setUnitPrice(price);
                    item.calculateLineAmount();

                    invoiceItems.add(item);
                }
            }

            ImportInvoice invoice = new ImportInvoice();
            invoice.setDate(new Date());
            invoice.setStatus("COMPLETED");
            invoice.setSupplierId(Integer.parseInt(supplierIdStr));
            invoice.setEmployeeId(employeeId);
            invoice.setListImportInvoiceItem(invoiceItems);
            invoice.generateInvoiceCode();
            invoice.calculateTotal();

            // Lưu hóa đơn chính
            int importId = importInvoiceDAO.createImportInvoice(invoice);

            if (importId > 0) {
                boolean success = true;

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
                    session.setAttribute("successInvoiceCode", invoice.getInvoiceCode());
                    session.setAttribute("successImportId", importId);
                    session.setAttribute("invoiceItems", invoiceItems);
                    session.setAttribute("invoiceSupplierName", supplierName);
                    session.setAttribute("invoiceSupplierId", supplierIdStr);
                    session.setAttribute("invoiceTotalAmount", invoice.getTotalAmount());

                    session.removeAttribute("selectedParts");
                    session.removeAttribute("currentSupplierId");

                    response.sendRedirect("warehousestaff/ImportInvoice.jsp");
                } else {
                    response.sendRedirect("warehousestaff/PartReceiving.jsp?supplierId=" + supplierIdStr +
                            "&supplierName=" + URLEncoder.encode(supplierName, "UTF-8") +
                            "&error=savefailed");
                }
            } else {
                response.sendRedirect("warehousestaff/PartReceiving.jsp?supplierId=" + supplierIdStr +
                        "&supplierName=" + URLEncoder.encode(supplierName, "UTF-8") +
                        "&error=createfailed");
            }

        } catch (Exception e) {
            e.printStackTrace();
            String supplierIdStr = request.getParameter("supplierId");
            String supplierName = request.getParameter("supplierName");
            response.sendRedirect("warehousestaff/PartReceiving.jsp?supplierId=" + supplierIdStr +
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
