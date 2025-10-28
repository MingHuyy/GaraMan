package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.DAO.SupplierPartDAO;
import org.example.Model.SupplierPart;

import java.io.IOException;

@WebServlet("/part")
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

        // Nhận ID để xem chi tiết
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

                // Gửi dữ liệu lên JSP
                request.setAttribute("supplierPart", supplierPart);
                
                // Forward về trang chi tiết
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

