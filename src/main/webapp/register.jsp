
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | PlayZone</title>
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
            <a href="login.jsp" class="login-btn">Login</a>
        </div>
    </nav>

    <section class="auth-section">

        <div class="auth-card">

            <h2>Create Account</h2>
            <p>Join PlayZone and book your favourite arena.</p>

            <% if (request.getAttribute("error") != null) { %>
                <p class="error-message">
                    <%= request.getAttribute("error") %>
                </p>
            <% } %>

            <form action="register" method="post">

                <label>Full Name</label>
                <input type="text"
                       name="name"
                       placeholder="Enter your full name"
                       maxlength="100"
                       required>

                <label>Email Address</label>
                <input type="email"
                       name="email"
                       placeholder="Enter your email"
                       maxlength="100"
                       required>

                <label>Password</label>
                <input type="password"
                       name="password"
                       placeholder="Minimum 8 characters"
                       minlength="8"
                       required>

                <button type="submit" class="auth-btn">
                    Create Account
                </button>

            </form>

            <p class="auth-link">
                Already have an account?
                <a href="login.jsp">Login here</a>
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
