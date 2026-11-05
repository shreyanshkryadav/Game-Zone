package web;

import exception.InvalidUserException;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Locale;

@WebServlet("/auth")
public class AuthServlet extends HttpServlet {
    private UserService service() {
        return (UserService) getServletContext().getAttribute(AppContextListener.USER_SERVICE);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String message = null;
        if ("1".equals(request.getParameter("registered"))) {
            message = "Account created. Log in with your new details.";
        } else if ("1".equals(request.getParameter("loggedOut"))) {
            message = "You have been logged out.";
        } else if ("1".equals(request.getParameter("loginRequired"))) {
            message = "Please log in to open your dashboard.";
        }
        request.setAttribute("noticeMessage", HtmlEscape.escape(message));
        request.setAttribute("showSignup", "false");
        request.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        username = username == null ? "" : username.trim().toLowerCase(Locale.ROOT);

        try {
            if (service().authenticateUser(username, password)) {
                HttpSession session = request.getSession(true);
                request.changeSessionId();
                session.setAttribute("username", username);
                session.setAttribute("playerName", service().getFullName(username));
                session.setMaxInactiveInterval(30 * 60);
                response.sendRedirect(request.getContextPath() + "/dashboard");
                return;
            }
            showError(request, response, "Email or password is incorrect.");
        } catch (InvalidUserException ex) {
            showError(request, response, ex.getMessage());
        }
    }

    private void showError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", HtmlEscape.escape(message));
        request.setAttribute("showSignup", "false");
        request.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(request, response);
    }
}
