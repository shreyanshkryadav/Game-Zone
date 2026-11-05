<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="description" content="GameZone player dashboard and gaming reservations">
  <title>GameZone | Player Dashboard</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/assets/dashboard.css">
  <script src="${pageContext.request.contextPath}/assets/dashboard.js" defer></script>
</head>
<body data-player-name="${playerName}" data-player-email="${username}">
  <aside class="sidebar" id="sidebar">
    <a class="brand" href="${pageContext.request.contextPath}/auth"><span class="brand-icon">🎮</span><span>Game<span class="accent">Zone</span></span></a>
    <div class="profile-mini">
      <div class="avatar" id="avatarInitial">P</div>
      <div><strong id="sidebarPlayerName">Player</strong><small>Gaming member</small></div>
    </div>
    <nav class="side-nav" aria-label="Dashboard navigation">
      <a class="nav-item active" href="#overview" data-view="overview"><span>▦</span> Overview</a>
      <a class="nav-item" href="#games" data-view="games"><span>🎮</span> Explore games</a>
      <a class="nav-item" href="#bookings" data-view="bookings"><span>▣</span> My bookings <span class="nav-count" id="bookingCount">0</span></a>
    </nav>
    <div class="sidebar-bottom">
      <div class="help-card"><span>💡</span><strong>Ready to play?</strong><p>Choose a game, select a time and reserve your session.</p></div>
      <a class="nav-item" href="${pageContext.request.contextPath}/auth"><span>←</span> Back to home</a>
      <form action="${pageContext.request.contextPath}/logout" method="post"><button class="nav-item logout-button" id="logoutButton" type="submit"><span>↪</span> Log out</button></form>
    </div>
  </aside>

  <main class="main-content">
    <header class="topbar">
      <button class="mobile-menu" id="menuToggle" type="button" aria-label="Toggle navigation">☰</button>
      <div class="breadcrumb">GameZone <span>/</span> <strong id="breadcrumbTitle">Overview</strong></div>
      <div class="topbar-right"><span class="status-dot"></span><span>Player dashboard</span><div class="avatar small-avatar" id="topAvatar">P</div></div>
    </header>

    <section class="view-section" id="overview">
      <div class="welcome-row">
        <div><p class="eyebrow">PLAYER ZONE</p><h1>Welcome back, <span id="welcomeName">Player</span> 👋</h1><p class="subheading">Your next gaming session is just a few clicks away.</p></div>
        <button class="btn btn-primary" type="button" data-jump="games">＋ Book a session</button>
      </div>

      <div class="stats-grid">
        <article class="stat-card"><div class="stat-icon purple">🎮</div><div><p>Games available</p><strong id="availableGames">4</strong><small>Gaming experiences</small></div></article>
        <article class="stat-card"><div class="stat-icon green">▣</div><div><p>My reservations</p><strong id="totalBookings">0</strong><small>Saved on this browser</small></div></article>
        <article class="stat-card"><div class="stat-icon orange">₹</div><div><p>Total booking value</p><strong id="totalSpend">₹0</strong><small>Across saved bookings</small></div></article>
      </div>

      <div class="section-title-row"><div><p class="eyebrow">PICK YOUR EXPERIENCE</p><h2>Popular gaming stations</h2></div><button class="text-button" type="button" data-jump="games">View all games →</button></div>
      <div class="game-grid featured-grid" id="featuredGames"></div>

      <div class="section-title-row bookings-heading"><div><p class="eyebrow">YOUR SCHEDULE</p><h2>Upcoming reservations</h2></div><button class="text-button" type="button" data-jump="bookings">All bookings →</button></div>
      <div class="booking-list" id="upcomingBookings"></div>
    </section>

    <section class="view-section hidden" id="games">
      <div class="page-heading"><p class="eyebrow">FIND YOUR NEXT CHALLENGE</p><h1>Explore games</h1><p class="subheading">Choose your station and reserve a time that works for you.</p></div>
      <div class="toolbar">
        <label class="search-box"><span>⌕</span><input id="gameSearch" type="search" placeholder="Search gaming stations..." aria-label="Search games"></label>
        <select id="categoryFilter" aria-label="Filter games"><option value="all">All categories</option><option value="console">Console</option><option value="vr">Virtual reality</option><option value="racing">Racing</option><option value="pc">PC gaming</option></select>
        <select id="sortFilter" aria-label="Sort games"><option value="popular">Sort: Recommended</option><option value="low">Price: Low to high</option><option value="high">Price: High to low</option></select>
      </div>
      <div class="game-grid" id="allGames"></div>
      <p class="empty-state hidden" id="noGames">No gaming stations match your search.</p>
    </section>

    <section class="view-section hidden" id="bookings">
      <div class="page-heading"><p class="eyebrow">YOUR GAME PLAN</p><h1>My bookings</h1><p class="subheading">Review or cancel reservations saved in this browser.</p></div>
      <div class="booking-toolbar"><div><strong id="bookingSummary">0 reservations</strong><p class="muted">Demo reservations are stored locally on this device.</p></div><button class="btn btn-primary" type="button" data-jump="games">＋ New booking</button></div>
      <div class="booking-list full-booking-list" id="allBookings"></div>
      <div class="empty-panel hidden" id="emptyBookings"><div>🕹️</div><h3>No bookings yet</h3><p>Choose a gaming station to make your first reservation.</p><button class="btn btn-primary" type="button" data-jump="games">Explore games</button></div>
    </section>

    <footer class="dashboard-footer">© 2026 GameZone · Gaming Zone Reservation System <span>Frontend demo — reservations are not sent to a server.</span></footer>
  </main>

  <dialog class="booking-dialog" id="bookingDialog">
    <form id="bookingForm" class="booking-form" novalidate>
      <div class="dialog-top"><div><p class="eyebrow">RESERVE YOUR SESSION</p><h2 id="dialogGameName">Book a station</h2><p class="muted" id="dialogGameDescription"></p></div><button class="icon-button" id="closeDialog" type="button" aria-label="Close">✕</button></div>
      <input type="hidden" id="selectedGameId">
      <div class="selected-station"><span id="dialogGameIcon">🎮</span><div><strong id="dialogStationName">Gaming station</strong><small id="dialogRate">₹0 per hour</small></div><span class="availability-pill">Demo availability</span></div>
      <div class="form-grid">
        <div class="field"><label for="bookingDate">Date</label><input type="date" id="bookingDate" required></div>
        <div class="field"><label for="bookingDuration">Duration</label><select id="bookingDuration"><option value="1">1 hour</option><option value="2">2 hours</option><option value="3">3 hours</option><option value="4">4 hours</option></select></div>
        <div class="field full-field"><label for="bookingTime">Start time</label><select id="bookingTime" required><option value="">Choose a time</option><option>10:00</option><option>11:00</option><option>12:00</option><option>13:00</option><option>14:00</option><option>15:00</option><option>16:00</option><option>17:00</option><option>18:00</option><option>19:00</option><option>20:00</option><option>21:00</option></select></div>
      </div>
      <div class="price-summary"><span>Estimated total</span><strong id="estimatedPrice">₹0</strong></div>
      <p class="form-error" id="bookingError" role="alert"></p>
      <button class="btn btn-primary submit-booking" type="submit">Confirm demo booking</button>
      <p class="dialog-note">Demo only: this does not verify real station availability or process payment.</p>
    </form>
  </dialog>

  <div class="toast" id="toast" role="status" aria-live="polite"></div>
</body>
</html>
