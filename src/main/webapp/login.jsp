
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | PlayZone</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

    <nav class="navbar">
        <div class="logo">Play<span>Zone</span></div>

        <div class="nav-links">
            <a href="index.jsp">Home</a>
            <a href="arenas">Arenas</a>
        </div>

        <div class="nav-buttons">
            <a href="register.jsp" class="register-btn">Register</a>
        </div>
    </nav>

    <section class="auth-section">

        <div class="auth-card">

            <h2>Welcome Back!</h2>
            <p>Login to continue your PlayZone experience.</p>

            <% if ("1".equals(request.getParameter("registered"))) { %>
                <p style="color:green;">
                    Registration successful! Please login.
                </p>
            <% } %>

            <% if (request.getAttribute("error") != null) { %>
                <p class="error-message">
                    <%= request.getAttribute("error") %>
                </p>
            <% } %>

            <form action="login" method="post">

                <label>Email Address</label>
                <input type="email"
                       name="email"
                       placeholder="Enter your email"
                       required>

                <label>Password</label>
                <input type="password"
                       name="password"
                       placeholder="Enter your password"
                       required>

                <button type="submit" class="auth-btn">
                    Login
                </button>

            </form>

            <p class="auth-link">
                Don't have an account?
                <a href="register.jsp">Register here</a>
            </p>

        </div>

    </section>

    <footer>
        <h2>Play<span>Zone</span></h2>
        <p>Book. Play. Repeat.</p>
        <p class="copyright">© 2026 PlayZone. All Rights Reserved.</p>
    </footer>

</body>
</html>
