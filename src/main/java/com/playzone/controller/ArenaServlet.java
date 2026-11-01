
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

public class ArenaServlet extends HttpServlet {

    private ArenaDAO arenaDAO = new ArenaDAO();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            List<Arena> arenas = arenaDAO.getArenasForBooking();

            request.setAttribute("arenas", arenas);

            request.getRequestDispatcher("/arenas.jsp")
                   .forward(request, response);

        } catch (SQLException e) {

            e.printStackTrace();

            throw new ServletException(
                "Unable to load arenas.", e
            );
        }
    }
}
