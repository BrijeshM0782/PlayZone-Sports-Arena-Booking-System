<%@ page import="java.util.List" %>
<%@ page import="com.playzone.model.Booking" %>

<%
    Integer userId = (Integer) session.getAttribute("userId");

    if (userId == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Booking> bookings =
        (List<Booking>) request.getAttribute("bookings");
%>

<!DOCTYPE html>
<html>
<head>
    <title>My Bookings - PlayZone</title>
    <link rel="stylesheet" href="css/style.css">
</head>

<body>

<nav class="navbar">
    <h2>PlayZone</h2>

    <div>
        <a href="dashboard.jsp">Dashboard</a>
        <a href="arenas">Arenas</a>
        <a href="logout">Logout</a>
    </div>
</nav>

<section class="booking-history">

    <h1>My Bookings</h1>
    <p>View and manage your arena reservations.</p>

    <% if ("1".equals(request.getParameter("cancelled"))) { %>
        <p class="success-message">
            Booking cancelled successfully!
        </p>
    <% } %>

    <% if ("1".equals(request.getParameter("error"))) { %>
        <p class="error-message">
            Unable to cancel booking. Please try again.
        </p>
    <% } %>

    <% if (bookings != null && !bookings.isEmpty()) { %>

        <div class="booking-list">

            <% for (Booking b : bookings) { %>

                <div class="booking-card">

                    <h2><%= b.getArenaName() %></h2>

                    <p><strong>Sport:</strong>
                        <%= b.getSportType() %>
                    </p>

                    <p><strong>Location:</strong>
                        <%= b.getLocation() %>
                    </p>

                    <p><strong>Date:</strong>
                        <%= b.getBookingDate() %>
                    </p>

                    <p><strong>Time:</strong>
                        <%= b.getTimeSlot() %>
                    </p>

                    <p><strong>Price:</strong>
                        ₹<%= b.getTotalPrice() %>
                    </p>

                    <p><strong>Status:</strong>
                        <span class="booking-status">
                            <%= b.getStatus() %>
                        </span>
                    </p>

                    <% if ("CONFIRMED".equals(b.getStatus())) { %>

                        <form action="cancel-booking" method="post"
                              onsubmit="return confirm('Are you sure you want to cancel this booking?');">

                            <input type="hidden"
                                   name="bookingId"
                                   value="<%= b.getBookingId() %>">

                            <button type="submit"
                                    class="cancel-btn">
                                Cancel Booking
                            </button>

                        </form>

                    <% } else { %>

                        <p class="cancelled-text">
                            This booking has been cancelled.
                        </p>

                    <% } %>

                </div>

            <% } %>

        </div>

    <% } else { %>

        <div class="empty-bookings">
            <h2>No bookings yet!</h2>
            <p>Explore arenas and book your first slot.</p>
            <a href="arenas">Explore Arenas</a>
        </div>

    <% } %>

</section>

</body>
</html>