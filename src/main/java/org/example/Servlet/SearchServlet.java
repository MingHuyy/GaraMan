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
            // ======= DATA ẢO ĐỂ TEST GIAO DIỆN =======
            // TODO: Uncomment phần dưới để dùng database thật
            /*
             * // Tìm kiếm dịch vụ
             * List<Service> services = serviceDAO.searchByName(keyword.trim());
             * request.setAttribute("services", services);
             * 
             * // Tìm kiếm phụ tùng
             * List<Part> parts = partDAO.searchByName(keyword.trim());
             * request.setAttribute("parts", parts);
             * 
             * // Lấy thông tin nhà cung cấp cho mỗi phụ tùng
             * for (Part part : parts) {
             * List<SupplierPart> supplierParts =
             * partDAO.getSupplierPartsByPartId(part.getPartId());
             * request.setAttribute("supplierParts_" + part.getPartId(), supplierParts);
             * }
             */

            // DATA ẢO - Dịch vụ
            List<Service> services = new java.util.ArrayList<>();

            Service s1 = new Service();
            s1.setServiceId(1);
            s1.setName("Thay dầu động cơ");
            s1.setDescription("Thay dầu động cơ toàn tổng hợp, bao gồm lọc dầu và kiểm tra toàn bộ hệ thống");
            s1.setPrice(450000f);
            s1.setDuration(45);
            services.add(s1);

            Service s2 = new Service();
            s2.setServiceId(2);
            s2.setName("Bảo dưỡng định kỳ");
            s2.setDescription("Kiểm tra và bảo dưỡng toàn diện theo chu kỳ: thay dầu, lọc gió, kiểm tra phanh...");
            s2.setPrice(850000f);
            s2.setDuration(90);
            services.add(s2);

            Service s3 = new Service();
            s3.setServiceId(3);
            s3.setName("Thay má phanh");
            s3.setDescription("Thay má phanh trước/sau, kiểm tra đĩa phanh và hệ thống phanh");
            s3.setPrice(1200000f);
            s3.setDuration(120);
            services.add(s3);

            Service s4 = new Service();
            s4.setServiceId(4);
            s4.setName("Cân bằng động");
            s4.setDescription("Cân bằng động 4 bánh xe, giúp xe chạy êm ái và giảm mòn lốp");
            s4.setPrice(200000f);
            s4.setDuration(30);
            services.add(s4);

            Service s5 = new Service();
            s5.setServiceId(5);
            s5.setName("Vệ sinh kim phun");
            s5.setDescription("Vệ sinh kim phun xăng bằng máy chuyên dụng, giúp xe vận hành mượt mà hơn");
            s5.setPrice(650000f);
            s5.setDuration(60);
            services.add(s5);

            request.setAttribute("services", services);

            // DATA ẢO - Phụ tùng
            List<Part> parts = new java.util.ArrayList<>();

            Part p1 = new Part();
            p1.setPartId(1);
            p1.setName("Lốp xe Michelin 205/55R16");
            parts.add(p1);

            Part p2 = new Part();
            p2.setPartId(2);
            p2.setName("Ắc quy GS 65Ah");
            parts.add(p2);

            Part p3 = new Part();
            p3.setPartId(3);
            p3.setName("Bộ má phanh Toyota Vios");
            parts.add(p3);

            Part p4 = new Part();
            p4.setPartId(4);
            p4.setName("Lọc dầu động cơ");
            parts.add(p4);

            Part p5 = new Part();
            p5.setPartId(5);
            p5.setName("Lọc gió động cơ");
            parts.add(p5);

            request.setAttribute("parts", parts);

            // DATA ẢO - Thông tin nhà cung cấp cho phụ tùng

            // Lốp xe Michelin
            List<SupplierPart> sp1 = new java.util.ArrayList<>();
            SupplierPart sp1_1 = new SupplierPart();
            sp1_1.setDescription("Lốp Michelin chính hãng - Nhà cung cấp A");
            sp1_1.setUnitPrice(2850000f);
            sp1_1.setStockQty(15);
            sp1.add(sp1_1);

            SupplierPart sp1_2 = new SupplierPart();
            sp1_2.setDescription("Lốp Michelin - Nhà cung cấp B");
            sp1_2.setUnitPrice(2750000f);
            sp1_2.setStockQty(8);
            sp1.add(sp1_2);
            request.setAttribute("supplierParts_1", sp1);

            // Ắc quy GS
            List<SupplierPart> sp2 = new java.util.ArrayList<>();
            SupplierPart sp2_1 = new SupplierPart();
            sp2_1.setDescription("Ắc quy GS chính hãng - Bảo hành 18 tháng");
            sp2_1.setUnitPrice(1650000f);
            sp2_1.setStockQty(25);
            sp2.add(sp2_1);
            request.setAttribute("supplierParts_2", sp2);

            // Bộ má phanh
            List<SupplierPart> sp3 = new java.util.ArrayList<>();
            SupplierPart sp3_1 = new SupplierPart();
            sp3_1.setDescription("Má phanh Toyota chính hãng");
            sp3_1.setUnitPrice(850000f);
            sp3_1.setStockQty(3);
            sp3.add(sp3_1);

            SupplierPart sp3_2 = new SupplierPart();
            sp3_2.setDescription("Má phanh Akebono - Hàng cao cấp");
            sp3_2.setUnitPrice(950000f);
            sp3_2.setStockQty(12);
            sp3.add(sp3_2);
            request.setAttribute("supplierParts_3", sp3);

            // Lọc dầu
            List<SupplierPart> sp4 = new java.util.ArrayList<>();
            SupplierPart sp4_1 = new SupplierPart();
            sp4_1.setDescription("Lọc dầu Mann Filter");
            sp4_1.setUnitPrice(185000f);
            sp4_1.setStockQty(50);
            sp4.add(sp4_1);

            SupplierPart sp4_2 = new SupplierPart();
            sp4_2.setDescription("Lọc dầu Bosch");
            sp4_2.setUnitPrice(195000f);
            sp4_2.setStockQty(0);
            sp4.add(sp4_2);
            request.setAttribute("supplierParts_4", sp4);

            // Lọc gió
            List<SupplierPart> sp5 = new java.util.ArrayList<>();
            SupplierPart sp5_1 = new SupplierPart();
            sp5_1.setDescription("Lọc gió động cơ chính hãng");
            sp5_1.setUnitPrice(165000f);
            sp5_1.setStockQty(30);
            sp5.add(sp5_1);
            request.setAttribute("supplierParts_5", sp5);
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
