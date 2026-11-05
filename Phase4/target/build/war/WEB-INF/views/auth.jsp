<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Sign in | GameZone</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/login.css">
</head>
<body class="login-page" data-show-signup="${showSignup}">
    <a href="${pageContext.request.contextPath}/auth" class="back-home">← GameZone</a>
    <main class="auth-container">
        <section class="auth-info">
            <div class="auth-logo">🎮 GameZone</div>
            <h1>READY TO <span>PLAY?</span></h1>
            <p>Sign in to explore gaming stations and manage your reservations.</p>
            <div class="auth-features">
                <div>🎮 <span>Explore gaming stations</span></div>
                <div>📅 <span>Plan a gaming session</span></div>
                <div>⚡ <span>Review your bookings</span></div>
            </div>
        </section>

        <section class="auth-box">
            <p class="server-notice" role="status">${noticeMessage}</p>
            <p class="server-error" role="alert">${errorMessage}</p>

            <div id="loginForm" class="form-container active">
                <h2>Welcome Back!</h2>
                <p class="form-subtitle">Log in to continue to GameZone</p>
                <form id="login" method="post" action="${pageContext.request.contextPath}/auth">
                    <div class="input-group">
                        <label for="loginEmail">Email Address</label>
                        <input type="email" id="loginEmail" name="username" placeholder="Enter your email" autocomplete="username" required>
                    </div>
                    <div class="input-group">
                        <label for="loginPassword">Password</label>
                        <input type="password" id="loginPassword" name="password" placeholder="Enter your password" autocomplete="current-password" required>
                    </div>
                    <button type="submit" class="auth-btn">LOGIN</button>
                    <p class="switch-form">Don't have an account?
                        <button type="button" id="showSignup" class="switch-btn">Sign Up</button>
                    </p>
                </form>
            </div>

            <div id="signupForm" class="form-container">
                <h2>Create Account</h2>
                <p class="form-subtitle">Join GameZone and start planning your sessions</p>
                <form id="signup" method="post" action="${pageContext.request.contextPath}/register">
                    <div class="input-group">
                        <label for="signupName">Full Name</label>
                        <input type="text" id="signupName" name="fullName" maxlength="80" autocomplete="name" required>
                    </div>
                    <div class="input-group">
                        <label for="signupEmail">Email Address</label>
                        <input type="email" id="signupEmail" name="username" autocomplete="email" required>
                    </div>
                    <div class="input-group">
                        <label for="signupPassword">Password</label>
                        <input type="password" id="signupPassword" name="password" minlength="6" autocomplete="new-password" required>
                    </div>
                    <div class="input-group">
                        <label for="confirmPassword">Confirm Password</label>
                        <input type="password" id="confirmPassword" name="confirmPassword" minlength="6" autocomplete="new-password" required>
                    </div>
                    <label class="terms">
                        <input type="checkbox" id="terms" name="terms" required>
                        I agree to the Terms &amp; Conditions
                    </label>
                    <button type="submit" class="auth-btn">CREATE ACCOUNT</button>
                    <p class="switch-form">Already have an account?
                        <button type="button" id="showLogin" class="switch-btn">Login</button>
                    </p>
                </form>
            </div>
        </section>
    </main>
    <script src="${pageContext.request.contextPath}/assets/auth.js"></script>
</body>
</html>
