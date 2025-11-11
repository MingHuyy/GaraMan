package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.DAO.ServiceDAO;
import org.example.Model.Service;

import java.io.IOException;

@WebServlet("/service")
public class ServiceServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private ServiceDAO serviceDAO;
    
    @Override
    public void init() throws ServletException {
        serviceDAO = new ServiceDAO();
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
                int serviceId = Integer.parseInt(idParam);
                
                // Lấy chi tiết Service
                Service service = serviceDAO.getServiceById(serviceId);
                
                if (service != null) {
                    System.out.println("Tên: " + service.getName());
                    System.out.println("Giá: " + service.getPrice());
                    System.out.println("Thời gian: " + service.getDuration() + " phút");
                    System.out.println("Mô tả: " + service.getDescription());
                } else {
                    System.out.println("Không tìm thấy!");
                }

                // Gửi dữ liệu lên JSP
                request.setAttribute("service", service);
                
                // Forward về trang chi tiết
                request.getRequestDispatcher("customer/Detail.jsp").forward(request, response);
                
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

