package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.DAO.CustomerDAO;
import org.example.Model.Customer;

import java.io.IOException;

/**
 * Servlet xử lý đăng nhập người dùng
 */
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private CustomerDAO customerDAO;

    /**
     * Xử lý GET request - chuyển hướng đến trang login
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    /**
     * Xử lý POST request - xử lý đăng nhập
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");

        // Validate input
        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=empty");
            return;
        }

        // Kiểm tra đăng nhập Customer từ database
        Customer customer = customerDAO.validateLogin(username, password);

        if (customer != null) {
            // Đăng nhập thành công - Tạo session
            HttpSession session = request.getSession();
            session.setAttribute("customer", customer);
            session.setAttribute("customerId", customer.getCustomerId());
            session.setAttribute("customerName", customer.getName());
            session.setAttribute("username", customer.getUsername());
            session.setAttribute("loginTime", System.currentTimeMillis());

            // Nếu chọn "Ghi nhớ đăng nhập", set session timeout dài hơn
            if (remember != null && "on".equals(remember)) {
                session.setMaxInactiveInterval(60 * 60 * 24 * 7); // 7 ngày
            } else {
                session.setMaxInactiveInterval(60 * 30); // 30 phút
            }

            // Chuyển hướng đến trang MainCustomer
            response.sendRedirect("MainCustomer.jsp");
        } else {
            // Đăng nhập thất bại
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}
