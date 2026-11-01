
package com.playzone.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.playzone.dao.ArenaDAO;
import com.playzone.model.Arena;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class ArenaActionServlet extends HttpServlet {

    private ArenaDAO arenaDAO = new ArenaDAO();

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

        String action = request.getParameter("action");

        try {

            int arenaId = Integer.parseInt(
                request.getParameter("arenaId")
            );

            boolean success = false;

            if ("deactivate".equals(action)) {

                success = arenaDAO.changeArenaStatus(arenaId, false);

            } else if ("activate".equals(action)) {

                success = arenaDAO.changeArenaStatus(arenaId, true);

            } else if ("update".equals(action)) {

                String name = request.getParameter("arenaName");
                String sport = request.getParameter("sportType");
                String location = request.getParameter("location");
                String description = request.getParameter("description");

                double price = Double.parseDouble(
                    request.getParameter("price")
                );

                if (name == null || name.trim().isEmpty()
                    || sport == null || sport.trim().isEmpty()
                    || location == null || location.trim().isEmpty()
                    || !Double.isFinite(price) || price <= 0) {

                    response.sendRedirect("admin-arenas?error=1");
                    return;
                }

                Arena arena = new Arena(
                    arenaId,
                    name.trim(),
                    sport.trim(),
                    location.trim(),
                    price,
                    description
                );

                success = arenaDAO.updateArena(arena);

            } else {

                response.sendRedirect("admin-arenas?error=1");
                return;
            }

            if (success) {
                response.sendRedirect("admin-arenas?updated=1");
            } else {
                response.sendRedirect("admin-arenas?error=1");
            }

        } catch (NumberFormatException | SQLException e) {

            e.printStackTrace();
            response.sendRedirect("admin-arenas?error=1");
        }
    }
}
