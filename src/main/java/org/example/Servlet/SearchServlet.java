package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.DAO.PartDAO;
import org.example.DAO.ServiceDAO;
import org.example.Model.Part;
import org.example.Model.Service;
import org.example.Model.SupplierPart;

import java.io.IOException;
import java.util.List;

/**
 * Servlet xử lý tìm kiếm dịch vụ và phụ tùng
 */
@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ServiceDAO serviceDAO;
    private PartDAO partDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        serviceDAO = new ServiceDAO();
        partDAO = new PartDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy từ khóa tìm kiếm
        String keyword = request.getParameter("keyword");

        if (keyword != null && !keyword.trim().isEmpty()) {
            // Tìm kiếm dịch vụ
            List<Service> services = serviceDAO.searchByName(keyword.trim());
            request.setAttribute("services", services);

            // Tìm kiếm phụ tùng
            List<Part> parts = partDAO.searchByName(keyword.trim());
            request.setAttribute("parts", parts);

            // Lấy thông tin nhà cung cấp cho mỗi phụ tùng
            for (Part part : parts) {
                List<SupplierPart> supplierParts = partDAO.getSupplierPartsByPartId(part.getPartId());
                request.setAttribute("supplierParts_" + part.getPartId(), supplierParts);
            }
        }

        // Forward đến trang kết quả
        request.getRequestDispatcher("ListPartServices.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}
