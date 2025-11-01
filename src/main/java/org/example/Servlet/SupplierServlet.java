package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.DAO.SupplierDAO;
import org.example.Model.Supplier;

import java.io.IOException;
import java.util.List;

@WebServlet("/searchSupplier")
public class SupplierServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private SupplierDAO supplierDAO;

    @Override
    public void init() throws ServletException {
        super.init();
        supplierDAO = new SupplierDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");

        if (keyword != null && !keyword.trim().isEmpty()) {
            List<Supplier> suppliers = supplierDAO.searchSupplierByName(keyword.trim());
            request.setAttribute("suppliers", suppliers);
            request.setAttribute("keyword", keyword);
        }

        request.getRequestDispatcher("SearchSupplier.jsp").forward(request, response);
    }
}

