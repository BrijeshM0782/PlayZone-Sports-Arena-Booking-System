```jsp
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<%
    HttpSession adminSession = request.getSession(false);

    if (adminSession == null ||
        !"ADMIN".equals(adminSession.getAttribute("userRole"))) {

        response.sendRedirect("login.jsp");
        return;
    }

    String adminName =
        (String) adminSession.getAttribute("userName");
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">

    <title>Admin Dashboard - PlayZone</title>

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>

<!-- Navigation Bar -->

<nav class="navbar">

    <h2>PlayZone Admin</h2>

    <div>
        <a href="index.jsp">Home</a>
        <a href="admin-dashboard">Dashboard</a>
        <a href="admin-arenas">Manage Arenas</a>
        <a href="arenas">View Arenas</a>
        <a href="logout">Logout</a>
    </div>

</nav>


<!-- Admin Dashboard -->

<section class="admin-section">

    <div class="admin-header">

        <h1>
            Welcome, <%= adminName != null ? adminName : "Admin" %>!
        </h1>

        <p>
            Manage your PlayZone sports arena booking system.
        </p>

    </div>


    <!-- Dashboard Statistics -->

    <h2>Dashboard Overview</h2>

    <div class="admin-stats">

        <div class="admin-card">

            <h3>Total Users</h3>

            <h1>${totalUsers}</h1>

            <p>Registered users</p>

        </div>


        <div class="admin-card">

            <h3>Active Arenas</h3>

            <h1>${totalArenas}</h1>

            <p>Available sports arenas</p>

        </div>


        <div class="admin-card">

            <h3>Total Bookings</h3>

            <h1>${totalBookings}</h1>

            <p>All booking records</p>

        </div>

    </div>


    <!-- Management Section -->

    <h2 class="admin-management-heading">
        Management
    </h2>

    <div class="admin-management">


        <!-- Arena Management -->

        <div class="admin-management-card">

            <h3>Arena Management</h3>

            <p>
                Add new sports arenas, view existing arenas
                and manage arena availability.
            </p>

            <a href="admin-arenas">
                Manage Arenas
            </a>

        </div>


        <!-- Booking Management -->

        <div class="admin-management-card">

            <h3>Booking Management</h3>

            <p>
                Monitor customer reservations and
                manage booking records.
            </p>

            <span>Coming Soon</span>

        </div>


        <!-- User Management -->

        <div class="admin-management-card">

            <h3>User Management</h3>

            <p>
                View registered users and their account
                information.
            </p>

            <span>Coming Soon</span>

        </div>


    </div>

</section>

</body>
</html>
```