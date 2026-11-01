
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    Integer userId = (Integer) session.getAttribute("userId");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    String userName = (String) session.getAttribute("userName");
    String userEmail = (String) session.getAttribute("userEmail");
    String role = (String) session.getAttribute("userRole");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard - PlayZone</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<nav class="navbar">
    <h2>PlayZone</h2>

    <div>
        <a href="index.jsp">Home</a>
        <a href="arenas">Arenas</a>
        <a href="my-bookings">My Bookings</a>
        <a href="logout">Logout</a>
    </div>
</nav>

<section class="dashboard-section">

    <div class="dashboard-header">
        <h1>Welcome, <%= userName != null ? userName : "User" %>!</h1>
        <p>Welcome to your PlayZone dashboard. Manage your arena bookings here.</p>
    </div>

    <div class="dashboard-details">

        <h2>Account Information</h2>

        <p>
            <strong>User ID:</strong>
            <%= userId %>
        </p>

        <p>
            <strong>Name:</strong>
            <%= userName != null ? userName : "N/A" %>
        </p>

        <p>
            <strong>Email:</strong>
            <%= userEmail != null ? userEmail : "N/A" %>
        </p>

        <p>
            <strong>Role:</strong>
            <%= role != null ? role : "USER" %>
        </p>

    </div>

    <h2 class="dashboard-heading">Quick Actions</h2>

    <div class="dashboard-actions">

        <div class="dashboard-card">
            <h3>Explore Arenas</h3>
            <p>Discover sports facilities available in your area.</p>
            <a href="arenas">View Arenas</a>
        </div>

        <div class="dashboard-card">
            <h3>Book a Slot</h3>
            <p>Select your favourite arena and reserve a time slot.</p>
            <a href="book">Book Now</a>
        </div>

        <div class="dashboard-card">
            <h3>My Bookings</h3>
            <p>View your booking history and manage reservations.</p>
            <a href="my-bookings">View Bookings</a>
        </div>

    </div>

</section>

</body>
</html>