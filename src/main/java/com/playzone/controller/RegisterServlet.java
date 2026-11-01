
package com.playzone.controller;

import java.io.IOException;
import java.sql.SQLException;

import com.playzone.dao.UserDAO;
import com.playzone.model.User;
import com.playzone.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        if (name == null || email == null || password == null ||
            name.trim().isEmpty() || email.trim().isEmpty() ||
            password.length() < 8) {

            request.setAttribute("error",
                "Please enter all details. Password must contain at least 8 characters.");

            request.getRequestDispatcher("/register.jsp")
                   .forward(request, response);
            return;
        }

        try {
            String hashedPassword = PasswordUtil.hashPassword(password);

            User user = new User(
                name.trim(),
                email.trim().toLowerCase(),
                hashedPassword
            );

            UserDAO dao = new UserDAO();

            if (dao.registerUser(user)) {
                response.sendRedirect(
                    request.getContextPath() + "/login.jsp?registered=1"
                );
            } else {
                request.setAttribute("error", "Registration failed.");
                request.getRequestDispatcher("/register.jsp")
                       .forward(request, response);
            }

        } catch (SQLException e) {

            if (e.getSQLState() != null &&
                e.getSQLState().startsWith("23")) {

                request.setAttribute("error",
                    "This email is already registered.");

                request.getRequestDispatcher("/register.jsp")
                       .forward(request, response);

            } else {
                throw new ServletException("Registration failed.", e);
            }

        } catch (Exception e) {
            throw new ServletException("Password processing failed.", e);
        }
    }
}
