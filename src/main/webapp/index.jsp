
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>PlayZone | Sports Arena Booking</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>

    <!-- Navigation Bar -->
    <nav class="navbar">
        <div class="logo">Play<span>Zone</span></div>

        <div class="nav-links">
            <a href="index.jsp" class="active">Home</a>
            <a href="arenas">Arenas</a>
        </div>

        <div class="nav-buttons">
            <a href="login.jsp" class="login-btn">Login</a>
            <a href="register.jsp" class="register-btn">Register</a>
        </div>
    </nav>


    <!-- Hero Section -->
    <section class="hero">
        <div class="hero-content">

            <p class="tagline">YOUR GAME. YOUR ARENA.</p>

            <h1>
                Find Your Game.
                <span>Book Your Arena.</span>
            </h1>

            <p class="hero-description">
                Discover the best sports arenas around you.
                Book your favourite sport and enjoy playing
                with your friends.
            </p>

            <a href="arenas" class="explore-btn">
                Explore Arenas →
            </a>

        </div>
    </section>


    <!-- Sports Categories -->
    <section class="sports" id="sports">

        <div class="section-heading">
            <p>CHOOSE YOUR GAME</p>
            <h2>Explore Sports</h2>
        </div>

        <div class="sports-container">

            <div class="sport-card">
                <div class="sport-icon">🏸</div>
                <h3>Badminton</h3>
            </div>

            <div class="sport-card">
                <div class="sport-icon">⚽</div>
                <h3>Football</h3>
            </div>

            <div class="sport-card">
                <div class="sport-icon">🏏</div>
                <h3>Cricket</h3>
            </div>

            <div class="sport-card">
                <div class="sport-icon">🏀</div>
                <h3>Basketball</h3>
            </div>

        </div>

    </section>


    <!-- Popular Arenas Preview -->
    <section class="arenas" id="arenas">

        <div class="section-heading">
            <p>POPULAR DESTINATIONS</p>
            <h2>Discover Popular Arenas</h2>
        </div>

        <div class="arena-container">

            <div class="arena-card">
                <div class="arena-image badminton"></div>

                <div class="arena-info">
                    <span class="arena-type">BADMINTON</span>
                    <h3>Smash Arena</h3>
                    <p>📍 Bangalore</p>

                    <div class="arena-bottom">
                        <h3>₹300 <small>/ hour</small></h3>
                        <a href="arenas">Explore</a>
                    </div>
                </div>
            </div>


            <div class="arena-card">
                <div class="arena-image football"></div>

                <div class="arena-info">
                    <span class="arena-type">FOOTBALL</span>
                    <h3>PowerPlay Turf</h3>
                    <p>📍 Bangalore</p>

                    <div class="arena-bottom">
                        <h3>₹1200 <small>/ hour</small></h3>
                        <a href="arenas">Explore</a>
                    </div>
                </div>
            </div>


            <div class="arena-card">
                <div class="arena-image cricket"></div>

                <div class="arena-info">
                    <span class="arena-type">CRICKET</span>
                    <h3>Elite Cricket Ground</h3>
                    <p>📍 Bangalore</p>

                    <div class="arena-bottom">
                        <h3>₹1500 <small>/ hour</small></h3>
                        <a href="arenas">Explore</a>
                    </div>
                </div>
            </div>

        </div>

        <div class="section-heading">
            <a href="arenas" class="explore-btn">
                View All Arenas →
            </a>
        </div>

    </section>


    <!-- Footer -->
    <footer>

        <h2>Play<span>Zone</span></h2>

        <p>Book. Play. Repeat.</p>

        <p class="copyright">
            © 2026 PlayZone. All Rights Reserved.
        </p>

    </footer>

</body>
</html>
