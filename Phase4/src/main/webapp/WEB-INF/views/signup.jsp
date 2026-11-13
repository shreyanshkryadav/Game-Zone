<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign Up | GameZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/login.css">
</head>
<body class="login-page signup-page">
    <a href="${pageContext.request.contextPath}/home" class="back-home">← Back to Home</a>
    <main class="auth-container">
        <section class="auth-info">
            <div class="auth-logo">🎮 GameZone</div>
            <h1>JOIN THE <span>GAME</span></h1>
            <p>Create your GameZone account to reserve a gaming station, manage your bookings and enjoy your gaming experience.</p>
            <div class="auth-features">
                <div>🎮 <span>Premium Gaming Stations</span></div>
                <div>📅 <span>Easy Slot Reservation</span></div>
                <div>⚡ <span>Quick &amp; Simple Booking</span></div>
            </div>
        </section>

        <section class="auth-box">
            <p class="server-error" role="alert">${errorMessage}</p>
            <div class="form-container active">
                <h2>Create Account</h2>
                <p class="form-subtitle">Join GameZone and start playing</p>
                <form id="signup" method="post" action="${pageContext.request.contextPath}/register">
                    <div class="input-group">
                        <label for="signupName">Full Name</label>
                        <input type="text" id="signupName" name="fullName" maxlength="80" autocomplete="name" placeholder="Enter your name" required>
                    </div>
                    <div class="input-group">
                        <label for="signupEmail">Email Address</label>
                        <input type="email" id="signupEmail" name="username" autocomplete="email" placeholder="Enter your email" required>
                    </div>
                    <div class="input-group">
                        <label for="signupPassword">Password</label>
                        <input type="password" id="signupPassword" name="password" minlength="6" autocomplete="new-password" placeholder="Create a password" required>
                    </div>
                    <div class="input-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" minlength="6" autocomplete="new-password" placeholder="Confirm your password" required>
                    </div>
                    <label class="terms" for="terms">
                        <input type="checkbox" id="terms" name="terms" required>
                        <span>I agree to the Terms &amp; Conditions</span>
                    </label>
                    <button type="submit" class="auth-btn">CREATE ACCOUNT</button>
                    <p class="switch-form">Already have an account? <a href="${pageContext.request.contextPath}/auth" class="switch-btn">Login</a></p>
                </form>
            </div>
        </section>
    </main>
    <script src="${pageContext.request.contextPath}/assets/auth.js" defer></script>
</body>
</html>
