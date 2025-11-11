package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/partReceiving")
public class PartReceivingServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        request.getRequestDispatcher("warehousestaff/PartReceiving.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        String action = request.getParameter("action");

        String supplierId = request.getParameter("supplierId");
        String supplierName = request.getParameter("supplierName");

        if ("add".equals(action)) {
            handleAddPart(request, session);
        } else if ("remove".equals(action)) {
            handleRemovePart(request, session);
        }

        String redirectUrl = "warehousestaff/PartReceiving.jsp";
        if (supplierId != null && !supplierId.isEmpty()) {
            redirectUrl += "?supplierId=" + supplierId;
            if (supplierName != null && !supplierName.isEmpty()) {
                redirectUrl += "&supplierName=" + URLEncoder.encode(supplierName, "UTF-8");
            }
        }
        
        response.sendRedirect(redirectUrl);
    }

    private void handleAddPart(HttpServletRequest request, HttpSession session) {
        String supplierPartId = request.getParameter("supplierPartId");
        String partName = request.getParameter("partName");
        String priceStr = request.getParameter("price");
        String currentQuantityStr = request.getParameter("currentQuantity");

        if (supplierPartId == null || partName == null || priceStr == null) {
            return;
        }

        // Lấy danh sách phụ tùng đã chọn từ session
        @SuppressWarnings("unchecked")
        List<Map<String, String>> selectedParts = 
            (List<Map<String, String>>) session.getAttribute("selectedParts");

        if (selectedParts == null) {
            selectedParts = new ArrayList<>();
        }

        // Kiểm tra xem phụ tùng đã được chọn chưa
        boolean alreadyExists = false;
        for (Map<String, String> existingPart : selectedParts) {
            if (existingPart.get("supplierPartId").equals(supplierPartId)) {
                alreadyExists = true;
                break;
            }
        }

        // Nếu chưa tồn tại, thêm vào danh sách
        if (!alreadyExists) {
            Map<String, String> part = new HashMap<>();
            part.put("supplierPartId", supplierPartId);
            part.put("partName", partName);
            part.put("price", priceStr);
            part.put("currentQuantity", currentQuantityStr != null ? currentQuantityStr : "0");
            part.put("quantity", "1"); // Số lượng mặc định

            selectedParts.add(part);
            session.setAttribute("selectedParts", selectedParts);
            session.setAttribute("addSuccess", "true");
        } else {
            session.setAttribute("addError", "exists");
        }
    }
    
    private void handleRemovePart(HttpServletRequest request, HttpSession session) {
        String removeIndexStr = request.getParameter("removeIndex");

        if (removeIndexStr == null) {
            return;
        }

        try {
            int removeIndex = Integer.parseInt(removeIndexStr);

            @SuppressWarnings("unchecked")
            List<Map<String, String>> selectedParts = 
                (List<Map<String, String>>) session.getAttribute("selectedParts");

            if (selectedParts != null && removeIndex >= 0 && removeIndex < selectedParts.size()) {
                selectedParts.remove(removeIndex);
                session.setAttribute("selectedParts", selectedParts);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace();
        }
    }
}

