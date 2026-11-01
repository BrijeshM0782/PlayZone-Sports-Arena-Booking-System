package com.playzone.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.playzone.dao.AdminDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminDashboardServlet extends HttpServlet {

    private AdminDAO adminDAO = new AdminDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            !"ADMIN".equals(session.getAttribute("userRole"))) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {
            int[] stats = adminDAO.getDashboardStats();

            request.setAttribute("totalUsers", stats[0]);
            request.setAttribute("totalArenas", stats[1]);
            request.setAttribute("totalBookings", stats[2]);

            request.getRequestDispatcher("/admin-dashboard.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();

            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Unable to load admin dashboard."
            );
        }
    }
}