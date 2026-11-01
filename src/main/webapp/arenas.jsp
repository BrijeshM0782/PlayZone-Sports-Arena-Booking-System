
<%@ page import="java.util.List" %>
<%@ page import="com.playzone.model.Arena" %>

<%
    List<Arena> arenas = (List<Arena>) request.getAttribute("arenas");

    String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Explore Sports Arenas | PlayZone</title>

    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: Arial, sans-serif;
            background-color: #f5f7fb;
            color: #172b4d;
        }

        .pz-page {
            width: 100%;
            min-height: 100vh;
            padding: 35px 6%;
        }

        /* Header */
        .pz-header {
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
            margin-bottom: 35px;
        }

        .pz-back {
            position: absolute;
            left: 0;
            text-decoration: none;
            color: #2563eb;
            font-size: 17px;
            font-weight: 500;
        }

        .pz-back:hover {
            text-decoration: underline;
        }

        .pz-header h1 {
            font-size: 36px;
            color: #172b4d;
            text-align: center;
        }

        /* Arena grid */
        .pz-arena-grid {
            width: 100%;
            max-width: 1200px;
            margin: 0 auto;
            display: grid;
            grid-template-columns: repeat(3, minmax(0, 1fr));
            gap: 25px;
        }

        /* Arena card */
        .pz-arena-card {
            background: #ffffff;
            padding: 25px;
            border-radius: 15px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.08);
            transition: transform 0.2s ease, box-shadow 0.2s ease;
        }

        .pz-arena-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 7px 20px rgba(0, 0, 0, 0.12);
        }

        .pz-arena-card h2 {
            font-size: 23px;
            margin-bottom: 12px;
            color: #172b4d;
        }

        .pz-arena-card p {
            font-size: 16px;
            line-height: 1.7;
            color: #333333;
        }

        /* Availability */
        .pz-status {
            display: inline-block;
            margin-top: 12px;
            padding: 7px 14px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: bold;
        }

        .pz-available {
            background-color: #dcfce7;
            color: #15803d;
        }

        .pz-unavailable {
            background-color: #fee2e2;
            color: #b91c1c;
        }

        /* Buttons */
        .pz-book-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 22px;
            background-color: #2563eb;
            color: white;
            text-decoration: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: bold;
            transition: background-color 0.2s ease;
        }

        .pz-book-btn:hover {
            background-color: #1d4ed8;
        }

        .pz-disabled-btn {
            display: inline-block;
            margin-top: 15px;
            padding: 12px 22px;
            background-color: #9ca3af;
            color: white;
            border-radius: 8px;
            font-size: 15px;
            font-weight: bold;
            cursor: not-allowed;
        }

        /* Empty state */
        .pz-empty {
            grid-column: 1 / -1;
            text-align: center;
            padding: 40px;
            background: white;
            border-radius: 12px;
            color: #666;
        }

        /* Responsive */
        @media (max-width: 900px) {
            .pz-arena-grid {
                grid-template-columns: repeat(2, minmax(0, 1fr));
            }
        }

        @media (max-width: 600px) {
            .pz-page {
                padding: 25px 15px;
            }

            .pz-header {
                flex-direction: column;
                gap: 20px;
            }

            .pz-back {
                position: static;
                align-self: flex-start;
            }

            .pz-header h1 {
                font-size: 27px;
            }

            .pz-arena-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

<div class="pz-page">

    <div class="pz-header">

        <a href="<%= contextPath %>/index.jsp" class="pz-back">
            &#8592; Back to Home
        </a>

        <h1>Explore Sports Arenas</h1>

    </div>

    <div class="pz-arena-grid">

        <%
            if (arenas != null && !arenas.isEmpty()) {

                for (Arena arena : arenas) {
        %>

        <div class="pz-arena-card">

            <h2><%= arena.getArenaName() %></h2>

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
                &#8377;<%= arena.getPricePerHour() %> / hour
            </p>

            <p>
                <%= arena.getDescription() == null
                    ? "" : arena.getDescription() %>
            </p>

            <% if (arena.isActive()) { %>

                <span class="pz-status pz-available">
                    AVAILABLE
                </span>

                <br>

                <a class="pz-book-btn"
                   href="<%= contextPath %>/book?arenaId=<%= arena.getArenaId() %>">
                    Book Now
                </a>

            <% } else { %>

                <span class="pz-status pz-unavailable">
                    UNAVAILABLE
                </span>

                <br>

                <span class="pz-disabled-btn">
                    Currently Unavailable
                </span>

            <% } %>

        </div>

        <%
                }

            } else {
        %>

            <div class="pz-empty">
                <h2>No arenas found!</h2>
                <p>Please check again later.</p>
            </div>

        <%
            }
        %>

    </div>

</div>

</body>
</html>
