package com.playzone.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.playzone.dao.BookingDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class CancelBookingServlet extends HttpServlet {

    private BookingDAO bookingDAO = new BookingDAO();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");

        try {
            int bookingId = Integer.parseInt(
                request.getParameter("bookingId")
            );

            boolean cancelled =
                    bookingDAO.cancelBooking(bookingId, userId);

            if (cancelled) {
                response.sendRedirect("my-bookings?cancelled=1");
            } else {
                response.sendRedirect("my-bookings?error=1");
            }

        } catch (NumberFormatException e) {
            response.sendRedirect("my-bookings?error=1");

        } catch (SQLException e) {
            e.printStackTrace();
            response.sendRedirect("my-bookings?error=1");
        }
    }
}