package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

/**
 * Servlet xử lý đăng xuất người dùng
 */
public class LogoutServlet extends HttpServlet {
    
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Lấy session hiện tại
        HttpSession session = request.getSession(false);
        
        // Hủy session nếu tồn tại
        if (session != null) {
            session.invalidate();
        }
        
        // Chuyển hướng về trang login với thông báo đăng xuất thành công
        response.sendRedirect("login.jsp?success=logout");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        doGet(request, response);
    }
}

