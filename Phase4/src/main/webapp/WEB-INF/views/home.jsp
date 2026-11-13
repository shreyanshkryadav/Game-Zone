<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="Reserve a gaming station at GameZone">
    <title>GameZone | Gaming Zone Reservation</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/dashboard.css">
</head>
<body>
    <div class="landing-page">
        <header class="navbar">
            <a class="logo" href="${pageContext.request.contextPath}/home">🎮 <span>GameZone</span></a>
            <nav>
                <a class="active" href="${pageContext.request.contextPath}/home">Home</a>
                <a href="#games">Games</a>
                <a href="#about">About</a>
                <a href="#contact">Contact</a>
            </nav>
            <div class="nav-buttons">
                <a href="${pageContext.request.contextPath}/auth" class="login-btn">Login</a>
                <a href="${pageContext.request.contextPath}/register" class="signup-btn">Sign Up</a>
            </div>
        </header>

        <main>
            <section class="hero">
                <div class="hero-content">
                    <p class="hero-small-title">WELCOME TO GAMEZONE</p>
                    <h1>LEVEL UP YOUR <span>GAMING</span> EXPERIENCE</h1>
                    <p class="hero-description">Book your favorite gaming station, choose your preferred time slot and get ready to play.</p>
                    <div class="hero-buttons">
                        <a href="${pageContext.request.contextPath}/auth" class="primary-btn">🎮 Book Your Slot</a>
                        <a href="#games" class="secondary-btn">Explore Games →</a>
                    </div>
                </div>
                <div class="hero-visual">
                    <div class="gaming-card">
                        <div class="controller">🎮</div>
                        <h3>GAME ON!</h3>
                        <p>Play • Compete • Enjoy</p>
                    </div>
                </div>
            </section>

            <section id="games" class="games-section">
                <div class="section-heading">
                    <p>OUR GAMING ZONE</p>
                    <h2>CHOOSE YOUR <span>GAME</span></h2>
                </div>
                <div class="games-container">
                    <div class="game-card"><div class="game-icon">🎮</div><h3>PlayStation 5</h3><p>Next-generation console gaming.</p><strong>₹150 / hour</strong></div>
                    <div class="game-card"><div class="game-icon">🥽</div><h3>VR Gaming</h3><p>Experience immersive virtual reality.</p><strong>₹350 / hour</strong></div>
                    <div class="game-card"><div class="game-icon">🏎️</div><h3>Racing Simulator</h3><p>Feel the speed with realistic racing.</p><strong>₹250 / hour</strong></div>
                    <div class="game-card"><div class="game-icon">💻</div><h3>PC Gaming</h3><p>High-performance competitive gaming.</p><strong>₹100 / hour</strong></div>
                </div>
            </section>

            <section id="about" class="about-section">
                <div><p class="section-label">WHY GAMEZONE?</p><h2>YOUR GAME. <span>YOUR TIME.</span></h2></div>
                <p>GameZone makes gaming reservations simple. Choose your favorite game, select an available time slot and reserve your gaming session in just a few clicks.</p>
            </section>
        </main>

        <footer id="contact">
            <div class="footer-logo">🎮 GameZone</div>
            <p>Gaming Zone Reservation System</p>
            <p>© 2026 GameZone. All Rights Reserved.</p>
        </footer>
    </div>
</body>
</html>
