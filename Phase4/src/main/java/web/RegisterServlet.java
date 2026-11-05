package web;

import exception.InvalidUserException;
import model.User;
import service.UserService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Locale;
import java.util.regex.Pattern;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    private static final Pattern EMAIL = Pattern.compile("^[^\\s@]+@[^\\s@]+\\.[^\\s@]+$");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String fullName = value(request, "fullName").trim();
        String email = value(request, "username").trim().toLowerCase(Locale.ROOT);
        String password = value(request, "password");
        String confirmation = value(request, "confirmPassword");
        String terms = value(request, "terms");

        String error = validateForm(fullName, email, password, confirmation, terms);
        if (error != null) {
            showError(request, response, error);
            return;
        }

        UserService users = (UserService) getServletContext()
                .getAttribute(AppContextListener.USER_SERVICE);
        try {
            users.registerUser(new User(fullName, email, password));
            response.sendRedirect(request.getContextPath() + "/auth?registered=1");
        } catch (InvalidUserException ex) {
            showError(request, response, ex.getMessage());
        }
    }

    private String validateForm(String fullName, String email, String password,
                                String confirmation, String terms) {
        if (fullName.isEmpty()) return "Enter your name.";
        if (fullName.length() > 80 || fullName.chars().anyMatch(Character::isISOControl)) {
            return "Enter a name using no more than 80 characters.";
        }
        if (!EMAIL.matcher(email).matches()) return "Enter a valid email address.";
        if (password.isBlank()) return "Enter a password.";
        if (password.length() < 6) return "Password must contain at least 6 characters.";
        if (!password.equals(confirmation)) return "The passwords do not match.";
        if (!"on".equals(terms)) return "Please accept the Terms and Conditions.";
        return null;
    }

    private String value(HttpServletRequest request, String key) {
        String value = request.getParameter(key);
        return value == null ? "" : value;
    }

    private void showError(HttpServletRequest request, HttpServletResponse response, String message)
            throws ServletException, IOException {
        request.setAttribute("errorMessage", HtmlEscape.escape(message));
        request.setAttribute("showSignup", "true");
        request.getRequestDispatcher("/WEB-INF/views/auth.jsp").forward(request, response);
    }
}
