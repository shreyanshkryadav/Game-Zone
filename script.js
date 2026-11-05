document.addEventListener('DOMContentLoaded', () => {
    const landingPage = document.getElementById('landingPage');
    const dashboardPage = document.getElementById('dashboardPage');

    const showDashboard = () => {
        if (landingPage) landingPage.classList.add('hidden-dashboard');
        if (dashboardPage) dashboardPage.classList.remove('hidden-dashboard');
        if (window.location.hash !== '#dashboard') {
            window.history.replaceState(null, '', '#dashboard');
        }
        if (typeof initialize === 'function') {
            initialize();
        }
    };

    const showLanding = () => {
        if (landingPage) landingPage.classList.remove('hidden-dashboard');
        if (dashboardPage) dashboardPage.classList.add('hidden-dashboard');
    };

    if (sessionStorage.getItem('gameZoneLoggedIn') === 'true' || window.location.hash === '#dashboard') {
        showDashboard();
    }

    document.querySelectorAll('[data-back-home="true"]').forEach((link) => {
        link.addEventListener('click', (e) => {
            e.preventDefault();
            showLanding();
        });
    });

    document.getElementById('logoutButton')?.addEventListener('click', () => {
        sessionStorage.removeItem('gameZoneLoggedIn');
        showLanding();
    });
});
