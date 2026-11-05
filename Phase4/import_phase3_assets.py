"""Copy Phase 3 presentation assets into Phase 4 and wire the dashboard to JSP/session."""
from pathlib import Path
import re
import shutil

PROJECT = Path(__file__).resolve().parent.parent
PHASE3 = Path(r"C:\xampp\htdocs\Gaming zone reservation System")
WEBAPP = Path(__file__).resolve().parent / "src" / "main" / "webapp"
ASSETS = WEBAPP / "assets"
VIEWS = WEBAPP / "WEB-INF" / "views"

for filename in ("style.css", "login.css", "dashboard.css", "dashboard.js"):
    shutil.copy2(PHASE3 / filename, ASSETS / filename)

html = (PHASE3 / "dashboard.html").read_text(encoding="utf-8")
html = html.replace('href="dashboard.css"', 'href="${pageContext.request.contextPath}/assets/dashboard.css"')
html = html.replace('src="dashboard.js" defer', 'src="${pageContext.request.contextPath}/assets/dashboard.js" defer')
html = html.replace('<body>', '<body data-player-name="${playerName}" data-player-email="${username}">')
html = html.replace('href="index.html"', 'href="${pageContext.request.contextPath}/auth"')
old_logout = '<button class="nav-item logout-button" id="logoutButton" type="button"><span>↪</span> Log out</button>'
new_logout = ('<form action="${pageContext.request.contextPath}/logout" method="post">'
              '<button class="nav-item logout-button" id="logoutButton" type="submit">'
              '<span>↪</span> Log out</button></form>')
if old_logout not in html:
    raise SystemExit("Could not locate the Phase 3 dashboard logout control.")
html = html.replace(old_logout, new_logout)
if '<body data-player-name="${playerName}" data-player-email="${username}">' not in html:
    raise SystemExit("Could not add the authenticated player name to the dashboard.")
(VIEWS / "dashboard.jsp").write_text(
    '<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>\n' + html,
    encoding="utf-8",
)

script = (ASSETS / "dashboard.js").read_text(encoding="utf-8")
script, n = re.subn(
    r"function getPlayerName\(\) \{.*?\n\}",
    'function getPlayerName() {\n  return document.body.dataset.playerName || "Player";\n}',
    script,
    count=1,
    flags=re.S,
)
if n != 1:
    raise SystemExit("Could not connect the dashboard player label to the server session.")
script = script.replace(
    'const BOOKING_KEY = "gameZoneDashboardBookings";',
    'const BOOKING_KEY = `gameZoneDashboardBookings:${(document.body.dataset.playerEmail || "guest").toLowerCase()}`;'
)
script, n = re.subn(
    r'\$\("logoutButton"\)\.addEventListener\("click", \(\) => \{.*?\n\}\);',
    "",
    script,
    count=1,
    flags=re.S,
)
if n != 1:
    raise SystemExit("Could not remove the old client-only logout behavior.")
(ASSETS / "dashboard.js").write_text(script, encoding="utf-8")
print("Phase 3 styles and dashboard interactions copied into Phase4 and connected to its session routes.")
