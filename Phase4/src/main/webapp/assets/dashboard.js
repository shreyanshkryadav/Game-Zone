/* GameZone dashboard interactions. Demo-only: localStorage, no server booking. */
"use strict";

const GAMEZONE_GAMES = [
  { id: "ps5", name: "PlayStation 5", category: "console", categoryLabel: "CONSOLE", icon: "🎮", description: "Next-generation console gaming with friends.", rate: 69, tag: "POPULAR" },
  { id: "vr", name: "VR Gaming", category: "vr", categoryLabel: "VIRTUAL REALITY", icon: "🥽", description: "Step into immersive virtual worlds.", rate: 500, tag: "IMMERSIVE" },
  { id: "racing", name: "Racing Simulator", category: "racing", categoryLabel: "RACING", icon: "🏎️", description: "Race with a realistic driving experience.", rate: 300, tag: "HIGH SPEED" },
  { id: "pc", name: "PC Gaming", category: "pc", categoryLabel: "PC GAMING", icon: "💻", description: "Play competitive games on a powerful PC.", rate: 150, tag: "COMPETITIVE" }
];

const BOOKING_KEY = `gameZoneDashboardBookings:${(document.body.dataset.playerEmail || "guest").toLowerCase()}`;
const PLAYER_NAME_KEY = "gameZonePlayerName";
const $ = (id) => document.getElementById(id);
const money = (amount) => new Intl.NumberFormat("en-IN", { style: "currency", currency: "INR", maximumFractionDigits: 0 }).format(amount);

let toastTimeout;
let currentGame = null;

function safeReadBookings() {
  try {
    const data = JSON.parse(localStorage.getItem(BOOKING_KEY) || "[]");
    return Array.isArray(data) ? data : [];
  } catch (error) {
    console.warn("Unable to read demo bookings", error);
    return [];
  }
}

function saveBookings(bookings) {
  localStorage.setItem(BOOKING_KEY, JSON.stringify(bookings));
}

function getPlayerName() {
  return document.body.dataset.playerName || "Player";
}

function initializePlayer() {
  const name = getPlayerName();
  $("welcomeName").textContent = name;
  $("sidebarPlayerName").textContent = name;
  $("avatarInitial").textContent = name.charAt(0).toUpperCase();
  $("topAvatar").textContent = name.charAt(0).toUpperCase();
  $("availableGames").textContent = GAMEZONE_GAMES.length;
}

function gameCard(game) {
  return `
    <article class="game-card">
      <div class="game-art">
        <span class="game-tag">${game.tag}</span>
        <span class="game-emoji" aria-hidden="true">${game.icon}</span>
      </div>
      <div class="game-body">
        <h3>${game.name}</h3>
        <p>${game.description}</p>
        <div class="game-bottom">
          <div class="game-price">${money(game.rate)} <small>/ hour</small></div>
          <button class="book-small" type="button" data-book-game="${game.id}">Book now ↗</button>
        </div>
      </div>
    </article>`;
}

function renderGames() {
  $("featuredGames").innerHTML = GAMEZONE_GAMES.map(gameCard).join("");
  const query = $("gameSearch").value.trim().toLowerCase();
  const category = $("categoryFilter").value;
  const sort = $("sortFilter").value;
  let games = GAMEZONE_GAMES.filter(game => {
    const matchesQuery = `${game.name} ${game.description} ${game.categoryLabel}`.toLowerCase().includes(query);
    return matchesQuery && (category === "all" || game.category === category);
  });
  if (sort === "low") games.sort((a, b) => a.rate - b.rate);
  if (sort === "high") games.sort((a, b) => b.rate - a.rate);
  $("allGames").innerHTML = games.map(gameCard).join("");
  $("noGames").classList.toggle("hidden", games.length > 0);
}

function showToast(message) {
  const toast = $("toast");
  toast.textContent = message;
  toast.classList.add("show");
  clearTimeout(toastTimeout);
  toastTimeout = setTimeout(() => toast.classList.remove("show"), 2800);
}

function openBooking(gameId) {
  currentGame = GAMEZONE_GAMES.find(game => game.id === gameId);
  if (!currentGame) return;
  $("selectedGameId").value = currentGame.id;
  $("dialogGameName").textContent = `Book ${currentGame.name}`;
  $("dialogGameDescription").textContent = currentGame.description;
  $("dialogGameIcon").textContent = currentGame.icon;
  $("dialogStationName").textContent = currentGame.name;
  $("dialogRate").textContent = `${money(currentGame.rate)} per hour`;
  $("bookingDate").value = "";
  $("bookingDate").min = new Date().toLocaleDateString("en-CA");
  $("bookingDuration").value = "1";
  $("bookingTime").value = "";
  $("bookingError").textContent = "";
  updatePrice();
  $("bookingDialog").showModal();
}

function updatePrice() {
  if (!currentGame) return;
  $("estimatedPrice").textContent = money(currentGame.rate * Number($("bookingDuration").value || 1));
}

function formatDate(dateString) {
  const date = new Date(`${dateString}T12:00:00`);
  return date.toLocaleDateString("en-IN", { day: "numeric", month: "short", year: "numeric" });
}

function formatTime(timeString) {
  const [hour, minute] = timeString.split(":").map(Number);
  const date = new Date();
  date.setHours(hour, minute, 0, 0);
  return date.toLocaleTimeString("en-IN", { hour: "numeric", minute: "2-digit" });
}

function bookingCard(booking, includeCancel = true) {
  const game = GAMEZONE_GAMES.find(item => item.id === booking.gameId);
  const gameName = game ? game.name : booking.gameName;
  const icon = game ? game.icon : "🎮";
  const duration = Number(booking.duration);
  const endHour = Number(booking.time.split(":")[0]) + duration;
  const endTime = `${String(endHour % 24).padStart(2, "0")}:${booking.time.split(":")[1]}`;
  return `
    <article class="booking-row">
      <div class="booking-emoji">${icon}</div>
      <div class="booking-info">
        <strong>${escapeHtml(gameName)}</strong>
        <p>${formatDate(booking.date)} · ${formatTime(booking.time)}–${formatTime(endTime)} · ${duration} hour${duration > 1 ? "s" : ""}</p>
        <span class="booking-status">Demo reservation</span>
      </div>
      <div class="booking-price">${money(booking.total)}</div>
      ${includeCancel ? `<button class="cancel-button" type="button" data-cancel-booking="${booking.id}">Cancel</button>` : ""}
    </article>`;
}

function escapeHtml(value) {
  return String(value).replace(/[&<>"']/g, char => ({
    "&": "&amp;", "<": "&lt;", ">": "&gt;", '"': "&quot;", "'": "&#39;"
  })[char]);
}

function renderBookings() {
  const bookings = safeReadBookings().sort((a, b) =>
    `${a.date}T${a.time}`.localeCompare(`${b.date}T${b.time}`)
  );
  const upcoming = bookings.filter(booking => booking.date >= new Date().toLocaleDateString("en-CA"));
  $("bookingCount").textContent = bookings.length;
  $("totalBookings").textContent = bookings.length;
  $("totalSpend").textContent = money(bookings.reduce((sum, booking) => sum + Number(booking.total || 0), 0));
  $("bookingSummary").textContent = `${bookings.length} reservation${bookings.length === 1 ? "" : "s"}`;
  $("upcomingBookings").innerHTML = upcoming.length
    ? upcoming.slice(0, 3).map(booking => bookingCard(booking, false)).join("")
    : `<div class="empty-panel"><div>🕹️</div><h3>No upcoming sessions</h3><p>Pick a game and reserve your next session.</p><button class="btn btn-primary" type="button" data-jump="games">Explore games</button></div>`;
  $("allBookings").innerHTML = bookings.map(booking => bookingCard(booking, true)).join("");
  $("emptyBookings").classList.toggle("hidden", bookings.length > 0);
}

function showView(viewId) {
  document.querySelectorAll(".view-section").forEach(section => section.classList.toggle("hidden", section.id !== viewId));
  document.querySelectorAll(".nav-item[data-view]").forEach(link => link.classList.toggle("active", link.dataset.view === viewId));
  const title = viewId === "games" ? "Explore games" : viewId === "bookings" ? "My bookings" : "Overview";
  $("breadcrumbTitle").textContent = title;
  $("sidebar").classList.remove("open");
  window.location.hash = viewId;
  window.scrollTo({ top: 0, behavior: "smooth" });
}

document.addEventListener("click", event => {
  const bookButton = event.target.closest("[data-book-game]");
  if (bookButton) {
    openBooking(bookButton.dataset.bookGame);
    return;
  }
  const jumpButton = event.target.closest("[data-jump]");
  if (jumpButton) {
    showView(jumpButton.dataset.jump);
    return;
  }
  const navLink = event.target.closest("[data-view]");
  if (navLink) {
    event.preventDefault();
    showView(navLink.dataset.view);
    return;
  }
  const cancelButton = event.target.closest("[data-cancel-booking]");
  if (cancelButton) {
    const bookings = safeReadBookings();
    const updated = bookings.filter(booking => booking.id !== cancelButton.dataset.cancelBooking);
    saveBookings(updated);
    renderBookings();
    showToast("Demo reservation cancelled.");
  }
});

$("gameSearch").addEventListener("input", renderGames);
$("categoryFilter").addEventListener("change", renderGames);
$("sortFilter").addEventListener("change", renderGames);
$("bookingDuration").addEventListener("change", updatePrice);
$("closeDialog").addEventListener("click", () => $("bookingDialog").close());
$("bookingDialog").addEventListener("click", event => {
  if (event.target === $("bookingDialog")) $("bookingDialog").close();
});

$("bookingForm").addEventListener("submit", event => {
  event.preventDefault();
  const date = $("bookingDate").value;
  const time = $("bookingTime").value;
  const duration = Number($("bookingDuration").value);
  const error = $("bookingError");
  error.textContent = "";

  if (!currentGame || !date || !time) {
    error.textContent = "Please choose a date and start time.";
    return;
  }
  const today = new Date().toLocaleDateString("en-CA");
  if (date < today) {
    error.textContent = "Please choose today or a future date.";
    return;
  }
  const startHour = Number(time.split(":")[0]);
  if (startHour + duration > 22) {
    error.textContent = "Please choose a duration that ends by 10:00 PM.";
    return;
  }

  const bookings = safeReadBookings();
  const overlaps = bookings.some(booking => {
    if (booking.date !== date || booking.gameId !== currentGame.id) return false;
    const existingStart = Number(booking.time.split(":")[0]);
    const existingEnd = existingStart + Number(booking.duration);
    return startHour < existingEnd && startHour + duration > existingStart;
  });
  if (overlaps) {
    error.textContent = "You already have a demo booking for this station during that time.";
    return;
  }

  const booking = {
    id: `gz-${Date.now()}-${Math.random().toString(36).slice(2, 7)}`,
    gameId: currentGame.id,
    gameName: currentGame.name,
    date,
    time,
    duration,
    total: currentGame.rate * duration,
    createdAt: new Date().toISOString()
  };

  bookings.push(booking);
  saveBookings(bookings);
  $("bookingDialog").close();
  renderBookings();
  showToast(`Demo booking saved for ${currentGame.name}.`);
  showView("bookings");
});

$("menuToggle").addEventListener("click", () => $("sidebar").classList.toggle("open"));


function initialize() {
  initializePlayer();
  renderGames();
  renderBookings();
  const initialView = ["overview", "games", "bookings"].includes(location.hash.slice(1))
    ? location.hash.slice(1) : "overview";
  showView(initialView);
}
initialize();
