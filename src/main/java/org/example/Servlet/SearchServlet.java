package org.example.Servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.DAO.SupplierPartDAO;
import org.example.DAO.ServiceDAO;
import org.example.Model.SupplierPart;
import org.example.Model.Service;

import java.io.IOException;
import java.util.List;

@WebServlet("/search")
public class SearchServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private SupplierPartDAO supplierPartDAO;
    private ServiceDAO serviceDAO;

    @Override
    public void init() throws ServletException {
        supplierPartDAO = new SupplierPartDAO();
        serviceDAO = new ServiceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String keyword = request.getParameter("keyword");


        List<SupplierPart> supplierParts = supplierPartDAO.searchByPartKeyword(keyword);
        List<Service> services = serviceDAO.searchByName(keyword);

        request.setAttribute("supplierParts", supplierParts);
        request.setAttribute("services", services);
        request.setAttribute("keyword", keyword);

        request.getRequestDispatcher("ListPartServices.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }
}

