document.addEventListener('DOMContentLoaded', () => {
    const loginForm = document.getElementById('login');
    const signupForm = document.getElementById('signup');

    const redirectToDashboard = (email) => {
        const displayName = email.split('@')[0]
            .replace(/[._-]+/g, ' ')
            .replace(/\b\w/g, (char) => char.toUpperCase());

        sessionStorage.setItem('gameZoneLoggedIn', 'true');
        sessionStorage.setItem('gameZonePlayerName', displayName || 'Player');

        window.location.href = 'index.html#dashboard';
    };

    if (loginForm) {
        loginForm.addEventListener('submit', (event) => {
            event.preventDefault();

            const emailInput = document.getElementById('loginEmail');
            const passwordInput = document.getElementById('loginPassword');
            const email = emailInput.value.trim();
            const password = passwordInput.value.trim();

            if (!email || !password) {
                alert('Please enter your email and password.');
                return;
            }

            if (!email.includes('@')) {
                alert('Please enter a valid email address.');
                return;
            }

            redirectToDashboard(email);
        });
    }

    if (signupForm) {
        signupForm.addEventListener('submit', (event) => {
            event.preventDefault();

            const nameInput = document.getElementById('signupName');
            const emailInput = document.getElementById('signupEmail');
            const passwordInput = document.getElementById('signupPassword');
            const confirmPasswordInput = document.getElementById('confirmPassword');
            const termsCheckbox = document.getElementById('terms');

            const name = nameInput.value.trim();
            const email = emailInput.value.trim();
            const password = passwordInput.value.trim();
            const confirmPassword = confirmPasswordInput.value.trim();

            if (!name || !email || !password || !confirmPassword) {
                alert('Please fill in all fields.');
                return;
            }

            if (!email.includes('@')) {
                alert('Please enter a valid email address.');
                return;
            }

            if (password.length < 6) {
                alert('Password must be at least 6 characters long.');
                return;
            }

            if (password !== confirmPassword) {
                alert('Passwords do not match.');
                return;
            }

            if (!termsCheckbox.checked) {
                alert('Please accept the Terms & Conditions.');
                return;
            }

            redirectToDashboard(email);
        });
    }
});
