
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.List" %>
<%@ page import="com.playzone.model.Arena" %>

<%
    // Only admin users can access this page
    String role = (String) session.getAttribute("userRole");

    if (role == null || !role.equals("ADMIN")) {
        response.sendRedirect("login.jsp");
        return;
    }

    List<Arena> arenas = (List<Arena>) request.getAttribute("arenas");

    String added = request.getParameter("added");
    String updated = request.getParameter("updated");
    String error = request.getParameter("error");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Manage Arenas | PlayZone</title>

<link rel="stylesheet"
    href="<%= request.getContextPath() %>/css/style.css">

<style>
.admin-arena-section {
    max-width: 1100px;
    margin: 40px auto;
    padding: 20px;
}

.admin-arena-section h1 {
    text-align: center;
    margin-bottom: 30px;
}

.arena-form-card {
    background: #ffffff;
    padding: 25px;
    border-radius: 12px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.08);
    margin-bottom: 40px;
}

.arena-form-card h2 {
    margin-bottom: 20px;
}

.arena-form {
    display: grid;
    grid-template-columns: 1fr 1fr;
    gap: 15px;
}

.arena-form input,
.arena-form textarea,
.arena-form select {
    width: 100%;
    padding: 12px;
    border: 1px solid #ccc;
    border-radius: 7px;
    box-sizing: border-box;
    font-size: 15px;
}

.arena-form textarea {
    grid-column: 1 / 3;
    resize: vertical;
}

.arena-form button {
    grid-column: 1 / 3;
}

.add-btn,
.update-btn {
    background: #2563eb;
    color: white;
    border: none;
    padding: 12px 20px;
    border-radius: 7px;
    cursor: pointer;
    font-weight: bold;
}

.admin-arena-list {
    display: grid;
    grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
    gap: 20px;
}

.admin-arena-card {
    background: white;
    padding: 20px;
    border-radius: 12px;
    box-shadow: 0 3px 12px rgba(0,0,0,0.08);
}

.admin-arena-card h3 {
    margin-top: 0;
}

.active-status {
    color: #15803d;
    font-weight: bold;
}

.inactive-status {
    color: #dc2626;
    font-weight: bold;
}

.edit-arena-details {
    margin-top: 15px;
    border-top: 1px solid #ddd;
    padding-top: 12px;
}

.edit-arena-details summary {
    cursor: pointer;
    color: #2563eb;
    font-weight: bold;
    margin-bottom: 12px;
}

.edit-form {
    display: flex;
    flex-direction: column;
    gap: 10px;
}

.edit-form input,
.edit-form textarea,
.edit-form select {
    width: 100%;
    padding: 10px;
    border: 1px solid #ccc;
    border-radius: 6px;
    box-sizing: border-box;
}

.edit-form textarea {
    resize: vertical;
}

.arena-actions {
    margin-top: 15px;
}

.arena-actions form {
    margin-top: 10px;
}

.deactivate-btn {
    background: #dc2626;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 6px;
    cursor: pointer;
}

.activate-btn {
    background: #15803d;
    color: white;
    border: none;
    padding: 10px 15px;
    border-radius: 6px;
    cursor: pointer;
}

.success-message {
    color: #15803d;
    background: #dcfce7;
    padding: 12px;
    border-radius: 6px;
    margin-bottom: 20px;
}

.error-message {
    color: #b91c1c;
    background: #fee2e2;
    padding: 12px;
    border-radius: 6px;
    margin-bottom: 20px;
}

.back-link {
    display: inline-block;
    margin-bottom: 20px;
    text-decoration: none;
    color: #2563eb;
}

@media(max-width: 600px) {
    .arena-form {
        grid-template-columns: 1fr;
    }

    .arena-form textarea,
    .arena-form button {
        grid-column: 1;
    }
}
</style>
</head>

<body>

<div class="admin-arena-section">

    <a href="<%= request.getContextPath() %>/admin-dashboard"
       class="back-link">← Back to Admin Dashboard</a>

    <h1>Manage Arenas</h1>

    <% if ("1".equals(added)) { %>
        <div class="success-message">
            Arena added successfully!
        </div>
    <% } %>

    <% if ("1".equals(updated)) { %>
        <div class="success-message">
            Arena details or status updated successfully!
        </div>
    <% } %>

    <% if (error != null) { %>
        <div class="error-message">
            Unable to complete the operation. Please check the details and try again.
        </div>
    <% } %>


    <!-- ADD ARENA FORM -->

    <div class="arena-form-card">

        <h2>Add New Arena</h2>

        <form action="<%= request.getContextPath() %>/admin-arenas"
              method="post"
              class="arena-form">

            <input type="text"
                   name="arenaName"
                   placeholder="Arena Name"
                   required>

            <select name="sportType" required>
                <option value="">Select Sport</option>
                <option value="Badminton">Badminton</option>
                <option value="Football">Football</option>
                <option value="Cricket">Cricket</option>
                <option value="Basketball">Basketball</option>
                <option value="Volleyball">Volleyball</option>
                <option value="Tennis">Tennis</option>
            </select>

            <input type="text"
                   name="location"
                   placeholder="Location"
                   required>

            <input type="number"
                   name="price"
                   placeholder="Price Per Hour"
                   min="1"
                   step="0.01"
                   required>

            <textarea name="description"
                      placeholder="Arena Description"
                      rows="3"></textarea>

            <button type="submit" class="add-btn">
                Add Arena
            </button>

        </form>
    </div>


    <!-- DISPLAY ALL ARENAS -->

    <h2>All Arenas</h2>

    <div class="admin-arena-list">

        <% if (arenas != null && !arenas.isEmpty()) { %>

            <% for (Arena arena : arenas) { %>

                <div class="admin-arena-card">

                    <h3><%= arena.getArenaName() %></h3>

                    <p>
                        <strong>Sport:</strong>
                        <%= arena.getSportType() %>
                    </p>

                    <p>
                        <strong>Location:</strong>
                        <%= arena.getLocation() %>
                    </p>

                    <p>
                        <strong>Price:</strong>
                        ₹<%= arena.getPricePerHour() %> / hour
                    </p>

                    <p>
                        <strong>Description:</strong>
                        <%= arena.getDescription() == null
                            ? "No description available"
                            : arena.getDescription() %>
                    </p>

                    <p>
                        <strong>Status:</strong>

                        <% if (arena.isActive()) { %>
                            <span class="active-status">ACTIVE</span>
                        <% } else { %>
                            <span class="inactive-status">INACTIVE</span>
                        <% } %>
                    </p>


                    <!-- EDIT ARENA -->

                    <details class="edit-arena-details">

                        <summary>Edit Arena</summary>

                        <form action="<%= request.getContextPath() %>/arena-action"
                              method="post"
                              class="edit-form">

                            <input type="hidden"
                                   name="action"
                                   value="update">

                            <input type="hidden"
                                   name="arenaId"
                                   value="<%= arena.getArenaId() %>">

                            <input type="text"
                                   name="arenaName"
                                   value="<%= arena.getArenaName() %>"
                                   placeholder="Arena Name"
                                   required>

                            <input type="text"
                                   name="sportType"
                                   value="<%= arena.getSportType() %>"
                                   placeholder="Sport Type"
                                   required>

                            <input type="text"
                                   name="location"
                                   value="<%= arena.getLocation() %>"
                                   placeholder="Location"
                                   required>

                            <input type="number"
                                   name="price"
                                   value="<%= arena.getPricePerHour() %>"
                                   min="1"
                                   step="0.01"
                                   required>

                            <textarea name="description"
                                      rows="3"
                                      placeholder="Description"><%= arena.getDescription() == null ? "" : arena.getDescription() %></textarea>

                            <button type="submit" class="update-btn">
                                Save Changes
                            </button>

                        </form>

                    </details>


                    <!-- ACTIVATE / DEACTIVATE -->

                    <div class="arena-actions">

                        <% if (arena.isActive()) { %>

                            <form action="<%= request.getContextPath() %>/arena-action"
                                  method="post"
                                  onsubmit="return confirm('Are you sure you want to deactivate this arena?');">

                                <input type="hidden"
                                       name="action"
                                       value="deactivate">

                                <input type="hidden"
                                       name="arenaId"
                                       value="<%= arena.getArenaId() %>">

                                <button type="submit" class="deactivate-btn">
                                    Deactivate Arena
                                </button>

                            </form>

                        <% } else { %>

                            <form action="<%= request.getContextPath() %>/arena-action"
                                  method="post"
                                  onsubmit="return confirm('Do you want to activate this arena again?');">

                                <input type="hidden"
                                       name="action"
                                       value="activate">

                                <input type="hidden"
                                       name="arenaId"
                                       value="<%= arena.getArenaId() %>">

                                <button type="submit" class="activate-btn">
                                    Activate Arena
                                </button>

                            </form>

                        <% } %>

                    </div>

                </div>

            <% } %>

        <% } else { %>

            <p>No arenas found.</p>

        <% } %>

    </div>

</div>

</body>
</html>
