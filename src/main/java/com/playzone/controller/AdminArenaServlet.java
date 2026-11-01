package com.playzone.controller;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.playzone.dao.ArenaDAO;
import com.playzone.model.Arena;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class AdminArenaServlet extends HttpServlet {

    private ArenaDAO arenaDAO = new ArenaDAO();

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
            List<Arena> arenas = arenaDAO.getArenasForAdmin();

            request.setAttribute("arenas", arenas);

            request.getRequestDispatcher("/admin-arenas.jsp")
                   .forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();

            response.sendError(
                HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                "Unable to load arenas."
            );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            !"ADMIN".equals(session.getAttribute("userRole"))) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {
            String name = request.getParameter("arenaName");
            String sport = request.getParameter("sportType");
            String location = request.getParameter("location");
            String description = request.getParameter("description");
            String priceText = request.getParameter("price");

            if (name == null || name.isBlank()
                    || sport == null || sport.isBlank()
                    || location == null || location.isBlank()
                    || priceText == null || priceText.isBlank()) {

                request.setAttribute("error", "Please fill all required fields.");
                doGet(request, response);
                return;
            }

            double price = Double.parseDouble(priceText);

            if (!Double.isFinite(price) || price <= 0) {
                request.setAttribute("error", "Enter a valid price greater than zero.");
                doGet(request, response);
                return;
            }

            Arena arena = new Arena(
                0,
                name.trim(),
                sport.trim(),
                location.trim(),
                price,
                description == null ? "" : description.trim()
            );

            boolean added = arenaDAO.addArena(arena);

            if (added) {
                response.sendRedirect("admin-arenas?added=1");
            } else {
                request.setAttribute("error", "Unable to add arena.");
                doGet(request, response);
            }

        } catch (NumberFormatException e) {
            request.setAttribute("error", "Please enter a valid price.");
            doGet(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error while adding arena.");
            doGet(request, response);
        }
    }
}