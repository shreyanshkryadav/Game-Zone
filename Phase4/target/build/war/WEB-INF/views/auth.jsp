<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login | GameZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/login.css">
</head>
<body class="login-page">
    <a href="${pageContext.request.contextPath}/home" class="back-home">← Back to Home</a>
    <main class="auth-container">
        <section class="auth-info">
            <div class="auth-logo">🎮 GameZone</div>
            <h1>READY TO <span>PLAY?</span></h1>
            <p>Login to reserve your gaming station, manage your bookings and enjoy your gaming experience.</p>
            <div class="auth-features">
                <div>🎮 <span>Premium Gaming Stations</span></div>
                <div>📅 <span>Easy Slot Reservation</span></div>
                <div>⚡ <span>Quick &amp; Simple Booking</span></div>
            </div>
        </section>

        <section class="auth-box">
            <p class="server-notice" role="status">${noticeMessage}</p>
            <p class="server-error" role="alert">${errorMessage}</p>
            <div class="form-container active">
                <h2>Welcome Back!</h2>
                <p class="form-subtitle">Login to continue to GameZone</p>
                <form id="login" method="post" action="${pageContext.request.contextPath}/auth">
                    <div class="input-group">
                        <label for="loginEmail">Email Address</label>
                        <input type="email" id="loginEmail" name="username" autocomplete="username" placeholder="Enter your email" required>
                    </div>
                    <div class="input-group">
                        <label for="loginPassword">Password</label>
                        <input type="password" id="loginPassword" name="password" autocomplete="current-password" placeholder="Enter your password" required>
                    </div>
                    <button type="submit" class="auth-btn">LOGIN</button>
                    <p class="switch-form">Don't have an account? <a href="${pageContext.request.contextPath}/register" class="switch-btn">Sign Up</a></p>
                </form>
            </div>
        </section>
    </main>
</body>
</html>
