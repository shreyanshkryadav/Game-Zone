# Gaming Zone Reservation System Phase 4

This is a new, self-contained Phase 4 web application. It connects the Java user model and account-service contract from Phases 1 and 2 to the registration and login interface and booking dashboard from Phase 3. Existing project folders are not edited; the Phase 1/2 Java classes and Phase 3 web assets are copied into this folder.

## What is connected

- The Phase 3 sign-up form submits to `RegisterServlet` with HTTP POST. The servlet validates the name, email, password, confirmation, and terms on the server, then calls the Phase 2 `UserOperations` service contract.
- The Phase 3 login form submits to `AuthServlet` with HTTP POST. The server checks the account through the service and creates an `HttpSession` only after valid credentials are confirmed.
- `DashboardServlet` checks for the session before forwarding to the JSP dashboard. The JSP and dashboard JavaScript use the signed-in player's name and email.
- The Phase 3 station catalogue, filters, booking form, price calculation, and booking list are retained in the copied dashboard. Demo reservations remain in browser `localStorage`, keyed by the signed-in email so accounts in the same browser see separate lists.
- The logout form submits to `LogoutServlet` using POST. The servlet invalidates the session and returns the player to the sign-in page.

The web-scoped account service keeps its user map in memory, so accounts reset when Tomcat restarts. Passwords are salted and hashed in this Phase 4 copy. The original Phase 1/2 files are unchanged. Reservation records are still browser-local demo data; Phase 4 does not add a database or shared server-side booking store.

## Folder layout

```text
Phase4/
  build.bat
  import_phase3_assets.py
  src/main/java/model/                 Phase 1 user model
  src/main/java/service/               Phase 2 user-operation contract and service
  src/main/java/exception/             Phase 2 validation exception
  src/main/java/web/                   Phase 4 Servlets and session utilities
  src/main/webapp/WEB-INF/views/        Login and protected dashboard JSPs
  src/main/webapp/assets/               Copied Phase 3 styles and booking JavaScript
  dist/                                 Built WAR is written here
```

## Build with the installed XAMPP Tomcat

The supplied XAMPP Tomcat 8.5.96 uses the `javax.servlet` API. The build uses its local `servlet-api.jar`, so Maven or an internet download is not needed. Apache lists the Tomcat 8.5 line as archived, with end of life on 31 March 2024; use this build for local coursework and move to a supported Tomcat release before any public deployment. The namespace changes in Tomcat 10 and later, so this `javax.servlet` build is intended for your currently installed Tomcat line. See the [Apache Tomcat version guide](https://tomcat.apache.org/whichversion).

1. Open Command Prompt.
2. Set the JDK and Tomcat folders if they differ from these defaults:

   ```bat
   set "JAVA_HOME=C:\Program Files\Java\jdk-22"
   set "CATALINA_HOME=C:\xampp\tomcat"
   ```

3. Change to this `Phase4` folder and run `build.bat`.
4. Confirm that `dist\GamingZonePhase4.war` was created.
5. Copy that WAR into `C:\xampp\tomcat\webapps\` and start Tomcat from the XAMPP Control Panel.
6. Open `http://localhost:8080/GamingZonePhase4/` in a browser.

## How to verify Phase 4 manually

1. Open the application URL. The sign-in and sign-up screen should appear.
2. Try registering with a password shorter than six characters or mismatched confirmation. The page should show a server response and should not create an account.
3. Register a valid name and email with a password of at least six characters. The sign-in page should confirm that the account was created.
4. Try logging in with the wrong password. The server should reject it. Then log in with the correct details; the URL should move to `/dashboard` and show the player dashboard.
5. Open `http://localhost:8080/GamingZonePhase4/dashboard` in a private browser window or after logging out. The server should redirect to sign-in.
6. Log out, then use the browser Back button and refresh. The protected dashboard should still redirect to sign-in because the session was invalidated.
7. In the dashboard, create a demo booking. It should appear in the bookings view and remain associated with that email in this browser.

For this classroom build, accounts are stored only in memory and disappear when Tomcat restarts. Booking data remains in browser storage. Do not use real passwords or deploy this demo publicly.
