package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.DAO.EmployeeDAO;
import org.example.Model.Employee;

import java.io.IOException;

public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private EmployeeDAO employeeDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        employeeDAO = new EmployeeDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.sendRedirect("login.jsp");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Set encoding để xử lý tiếng Việt
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        // Lấy thông tin từ form
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("========== LOGIN ATTEMPT ==========");
        System.out.println("Username: " + username);
        System.out.println("Password: " + password);
        System.out.println("===================================");

        // Validate input
        if (username == null || username.trim().isEmpty() ||
                password == null || password.trim().isEmpty()) {
            response.sendRedirect("login.jsp?error=empty");
            return;
        }

        // Truy vấn database để validate login
        Employee employee = employeeDAO.validateLogin(username, password);

        if (employee != null) {
            // Đăng nhập thành công - Tạo session
            HttpSession session = request.getSession();
            session.setAttribute("employee", employee);
            session.setAttribute("employeeId", employee.getEmployeeId());
            session.setAttribute("employeeName", employee.getName());
            session.setAttribute("username", employee.getUsername());
            session.setAttribute("role", employee.getRole());
            session.setAttribute("phone", employee.getPhone());
            session.setAttribute("loginTime", System.currentTimeMillis());
            session.setMaxInactiveInterval(60 * 30); // 30 phút

            // Chuyển hướng đến trang MainEmployee
            response.sendRedirect("MainEmployee.jsp");
        } else {
            // Đăng nhập thất bại
            response.sendRedirect("login.jsp?error=invalid");
        }
    }
}
