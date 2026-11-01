
package com.playzone.controller;

import java.io.IOException;
import java.sql.Date;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Arrays;
import java.util.List;

import com.playzone.dao.ArenaDAO;
import com.playzone.dao.BookingDAO;
import com.playzone.model.Arena;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class BookingServlet extends HttpServlet {

    private ArenaDAO arenaDAO = new ArenaDAO();
    private BookingDAO bookingDAO = new BookingDAO();

    private final List<String> allowedSlots = Arrays.asList(
        "06:00 PM - 07:00 PM",
        "07:00 PM - 08:00 PM",
        "08:00 PM - 09:00 PM",
        "09:00 PM - 10:00 PM"
    );


    // DISPLAY BOOKING PAGE
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {

            // Load active AND inactive arenas
            List<Arena> arenas = arenaDAO.getArenasForBooking();

            request.setAttribute("arenas", arenas);

            // Pass selected arena ID to JSP
            String arenaId = request.getParameter("arenaId");

            if (arenaId != null) {
                request.setAttribute("selectedArenaId", arenaId);
            }

            request.getRequestDispatcher("/booking.jsp")
                   .forward(request, response);

        } catch (SQLException e) {

            e.printStackTrace();

            throw new ServletException(
                "Unable to load booking page.", e
            );
        }
    }


    // PROCESS BOOKING
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null ||
            session.getAttribute("userId") == null) {

            response.sendRedirect("login.jsp");
            return;
        }

        try {

            int userId = (Integer) session.getAttribute("userId");

            int arenaId = Integer.parseInt(
                request.getParameter("arenaId")
            );

            String dateString = request.getParameter("bookingDate");
            String timeSlot = request.getParameter("timeSlot");

            // Validate date
            LocalDate selectedDate = LocalDate.parse(dateString);

            if (selectedDate.isBefore(LocalDate.now())) {
                throw new IllegalArgumentException(
                    "Please select today or a future date."
                );
            }

            // Validate time slot
            if (!allowedSlots.contains(timeSlot)) {
                throw new IllegalArgumentException(
                    "Please select a valid time slot."
                );
            }

            Date bookingDate = Date.valueOf(selectedDate);

            // DAO checks whether arena is active
            boolean success = bookingDAO.createBooking(
                userId, arenaId, bookingDate, timeSlot
            );

            if (success) {

                response.sendRedirect(
                    "my-bookings?success=1"
                );

            } else {

                response.sendRedirect(
                    "book?error=booking"
                );
            }

        } catch (IllegalArgumentException e) {

            e.printStackTrace();

            response.sendRedirect(
                "book?error=invalid"
            );

        } catch (SQLException e) {

            e.printStackTrace();

            if ("23000".equals(e.getSQLState())) {
                response.sendRedirect(
                    "book?error=duplicate"
                );
            } else if (e.getMessage() != null &&
                       e.getMessage().contains("Arena is inactive")) {

                response.sendRedirect(
                    "book?error=unavailable"
                );
            } else {
                throw new ServletException("Booking failed.", e);
            }

        }
    }
}
