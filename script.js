// Route legacy demo-dashboard links into the authenticated Phase 4 app.
document.addEventListener('DOMContentLoaded', () => {
    const legacyDemoSession = sessionStorage.getItem('gameZoneLoggedIn') === 'true';
    const dashboardHash = window.location.hash === '#dashboard';

    if (legacyDemoSession || dashboardHash) {
        sessionStorage.removeItem('gameZoneLoggedIn');
        window.location.replace('http://localhost:8080/GamingZonePhase4/dashboard');
    }
});
