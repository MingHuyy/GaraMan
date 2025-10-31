package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.DAO.SupplierPartDAO;
import org.example.Model.SupplierPart;

import java.io.IOException;
import java.util.List;

@WebServlet(urlPatterns = {"/part", "/searchPart"})
public class PartServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private SupplierPartDAO supplierPartDAO;

    @Override
    public void init() throws ServletException {
        supplierPartDAO = new SupplierPartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String servletPath = request.getServletPath();

        if ("/searchPart".equals(servletPath)) {
            String keyword = request.getParameter("keyword");
            String supplierIdParam = request.getParameter("supplierId");

            if (keyword != null && !keyword.trim().isEmpty() && supplierIdParam != null) {
                try {
                    int supplierId = Integer.parseInt(supplierIdParam);
                    List<SupplierPart> supplierParts = supplierPartDAO.searchByPartKeywordAndSupplier(keyword.trim(), supplierId);
                    request.setAttribute("supplierParts", supplierParts);
                    request.setAttribute("keyword", keyword);
                } catch (NumberFormatException e) {
                    e.printStackTrace();
                }
            }

            request.getRequestDispatcher("SearchPart.jsp").forward(request, response);
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam != null && !idParam.isEmpty()) {
            try {
                int supplierPartId = Integer.parseInt(idParam);
                
                // Lấy chi tiết SupplierPart
                SupplierPart supplierPart = supplierPartDAO.getSupplierPartById(supplierPartId);
                
                System.out.println("=================================");
                System.out.println("PartServlet - Chi tiết Part ID: " + supplierPartId);
                if (supplierPart != null) {
                    System.out.println("Tên: " + supplierPart.getPartName());
                    System.out.println("Nhà cung cấp: " + supplierPart.getSupplierName());
                    System.out.println("Giá: " + supplierPart.getPrice());
                    System.out.println("Số lượng: " + supplierPart.getQuantity());
                } else {
                    System.out.println("Không tìm thấy!");
                }
                System.out.println("=================================");
                
                request.setAttribute("supplierPart", supplierPart);

                request.getRequestDispatcher("Detail.jsp").forward(request, response);
                
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid ID");
            }
        } else {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Missing ID parameter");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

