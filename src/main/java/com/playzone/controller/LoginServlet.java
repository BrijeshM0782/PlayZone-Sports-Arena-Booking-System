
package com.playzone.controller;

import java.io.IOException;

import com.playzone.dao.UserDAO;
import com.playzone.model.User;
import com.playzone.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (email == null || password == null ||
            email.trim().isEmpty() || password.isEmpty()) {

            request.setAttribute("error", "Please enter email and password.");

            request.getRequestDispatcher("/login.jsp")
                   .forward(request, response);
            return;
        }

        try {
            UserDAO dao = new UserDAO();

            User user = dao.getUserByEmail(email.trim().toLowerCase());

            if (user != null &&
                PasswordUtil.verifyPassword(password, user.getPassword())) {

                HttpSession oldSession = request.getSession(false);

                if (oldSession != null) {
                    oldSession.invalidate();
                }

                HttpSession session = request.getSession(true);

                session.setAttribute("userId", user.getUserId());
                session.setAttribute("userName", user.getName());
                session.setAttribute("userEmail", user.getEmail());
                session.setAttribute("userRole", user.getRole());

                session.setMaxInactiveInterval(30 * 60);

                if ("ADMIN".equals(user.getRole())) {
                    response.sendRedirect("admin-dashboard");
                } else {
                    response.sendRedirect("dashboard.jsp");
                }

            } else {
                request.setAttribute("error", "Invalid email or password.");

                request.getRequestDispatcher("/login.jsp")
                       .forward(request, response);
            }

        } catch (Exception e) {
            throw new ServletException("Login failed.", e);
        }
    }
}
