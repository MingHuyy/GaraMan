package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/importInvoice")
public class ImportInvoiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();

        String supplierId = request.getParameter("supplierId");
        String supplierName = request.getParameter("supplierName");

        List<Map<String, String>> selectedParts = 
            (List<Map<String, String>>) session.getAttribute("selectedParts");
        
        if (selectedParts == null || selectedParts.isEmpty()) {
            response.sendRedirect("PartReceiving.jsp?error=noparts");
            return;
        }

        List<Map<String, String>> invoiceItems = new ArrayList<>();
        double totalAmount = 0;
        
        for (int i = 0; i < selectedParts.size(); i++) {
            String quantityStr = request.getParameter("quantity_" + i);
            String supplierPartId = request.getParameter("supplierPartId_" + i);
            String priceStr = request.getParameter("price_" + i);
            
            if (quantityStr != null && supplierPartId != null && priceStr != null) {
                Map<String, String> part = selectedParts.get(i);
                Map<String, String> invoiceItem = new HashMap<>();
                
                int quantity = Integer.parseInt(quantityStr);
                double price = Double.parseDouble(priceStr);
                double subtotal = quantity * price;
                
                invoiceItem.put("supplierPartId", supplierPartId);
                invoiceItem.put("partName", part.get("partName"));
                invoiceItem.put("quantity", String.valueOf(quantity));
                invoiceItem.put("price", priceStr);
                invoiceItem.put("subtotal", String.valueOf(subtotal));
                
                invoiceItems.add(invoiceItem);
                totalAmount += subtotal;
                
                // Cập nhật quantity và inputPrice trong selectedParts
                part.put("quantity", String.valueOf(quantity));
                part.put("inputPrice", priceStr);
            }
        }
        
        // Lưu vào session để hiển thị
        session.setAttribute("invoiceItems", invoiceItems);
        session.setAttribute("invoiceSupplierId", supplierId);
        session.setAttribute("invoiceSupplierName", supplierName);
        session.setAttribute("invoiceTotalAmount", totalAmount);
        session.setAttribute("selectedParts", selectedParts);
        
        // Chuyển đến trang preview
        request.getRequestDispatcher("ImportInvoice.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}

