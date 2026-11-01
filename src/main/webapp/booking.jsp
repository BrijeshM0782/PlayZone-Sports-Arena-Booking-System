
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ page import="java.util.List" %>
<%@ page import="com.playzone.model.Arena" %>
<%@ page import="java.time.LocalDate" %>

<%
    if (session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Arena> arenas =
        (List<Arena>) request.getAttribute("arenas");

    String selectedArenaId =
        (String) request.getAttribute("selectedArenaId");

    String error = request.getParameter("error");

    String contextPath = request.getContextPath();

    LocalDate today = LocalDate.now();
%>

<!DOCTYPE html>
<html>
<head>

<meta charset="UTF-8">
<title>Book Arena | PlayZone</title>

<link rel="stylesheet"
      href="<%= contextPath %>/css/style.css">

<style>

.booking-container {
    max-width: 650px;
    margin: 50px auto;
    padding: 30px;
    background: white;
    border-radius: 12px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.08);
}

.booking-container h1 {
    text-align: center;
    margin-bottom: 25px;
}

.booking-form {
    display: flex;
    flex-direction: column;
    gap: 15px;
}

.booking-form label {
    font-weight: bold;
}

.booking-form input,
.booking-form select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 7px;
    font-size: 15px;
    box-sizing: border-box;
}

.booking-form button {
    padding: 13px;
    border: none;
    background: #2563eb;
    color: white;
    border-radius: 7px;
    font-size: 16px;
    font-weight: bold;
    cursor: pointer;
}

.booking-form button:hover {
    background: #1d4ed8;
}

.booking-form button:disabled {
    background: #999;
    cursor: not-allowed;
}

.error-message {
    background: #fee2e2;
    color: #991b1b;
    padding: 12px;
    border-radius: 7px;
    margin-bottom: 18px;
}

.info-message {
    background: #dbeafe;
    color: #1e40af;
    padding: 12px;
    border-radius: 7px;
    margin-bottom: 18px;
}

.booking-back {
    display: inline-block;
    margin-bottom: 20px;
    color: #2563eb;
    text-decoration: none;
}

</style>

</head>

<body>

<div class="booking-container">

    <a href="<%= contextPath %>/arenas"
       class="booking-back">
        ← Back to Arenas
    </a>

    <h1>Book Your Arena</h1>


    <!-- ERROR MESSAGES -->

    <% if ("duplicate".equals(error)) { %>

        <div class="error-message">
            This time slot is already booked.
            Please select another time slot.
        </div>

    <% } else if ("unavailable".equals(error)) { %>

        <div class="error-message">
            This arena is currently unavailable.
            Please select another active arena.
        </div>

    <% } else if ("invalid".equals(error)) { %>

        <div class="error-message">
            Invalid date or time slot.
            Please check your booking details.
        </div>

    <% } else if ("booking".equals(error)) { %>

        <div class="error-message">
            Booking could not be completed.
            Please try again.
        </div>

    <% } %>


    <% if (arenas != null && !arenas.isEmpty()) { %>

        <form action="<%= contextPath %>/book"
              method="post"
              class="booking-form">

            <!-- ARENA SELECTION -->

            <label>Select Arena</label>

            <select name="arenaId" required>

                <option value="">Choose an Arena</option>

                <% for (Arena arena : arenas) { %>

                    <option
                        value="<%= arena.getArenaId() %>"
                        <%= !arena.isActive() ? "disabled" : "" %>
                        <%= selectedArenaId != null &&
                            selectedArenaId.equals(
                                String.valueOf(arena.getArenaId())
                            ) ? "selected" : "" %>>

                        <%= arena.getArenaName() %>
                        -
                        ₹<%= arena.getPricePerHour() %>/hour

                        <%= arena.isActive()
                            ? "(Available)"
                            : "(Unavailable)" %>

                    </option>

                <% } %>

            </select>


            <!-- BOOKING DATE -->

            <label>Select Booking Date</label>

            <input type="date"
                   name="bookingDate"
                   min="<%= today %>"
                   required>


            <!-- TIME SLOT -->

            <label>Select Time Slot</label>

            <select name="timeSlot" required>

                <option value="">Choose a Time Slot</option>

                <option value="06:00 PM - 07:00 PM">
                    06:00 PM - 07:00 PM
                </option>

                <option value="07:00 PM - 08:00 PM">
                    07:00 PM - 08:00 PM
                </option>

                <option value="08:00 PM - 09:00 PM">
                    08:00 PM - 09:00 PM
                </option>

                <option value="09:00 PM - 10:00 PM">
                    09:00 PM - 10:00 PM
                </option>

            </select>


            <div class="info-message">
                Only active arenas can be booked.
                Inactive arenas are shown as unavailable.
            </div>


            <button type="submit">
                Confirm Booking
            </button>

        </form>

    <% } else { %>

        <div class="error-message">
            No arenas are currently available for booking.
        </div>

    <% } %>

</div>

</body>
</html>
