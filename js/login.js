document.addEventListener('DOMContentLoaded', () => {
    const signupForm = document.getElementById('signup');
    const passwordInput = document.getElementById('signupPassword');
    const confirmInput = document.getElementById('confirmPassword');

    if (!signupForm || !passwordInput || !confirmInput) return;

    signupForm.addEventListener('submit', (event) => {
        const passwordsMatch = passwordInput.value === confirmInput.value;
        confirmInput.setCustomValidity(passwordsMatch ? '' : 'The passwords do not match.');
        if (!passwordsMatch) {
            event.preventDefault();
            confirmInput.reportValidity();
        }
    });

    confirmInput.addEventListener('input', () => confirmInput.setCustomValidity(''));
});
