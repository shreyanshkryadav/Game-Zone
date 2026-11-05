package web;

import service.UserService;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;

/** Creates one account service shared by requests in this web application. */
@WebListener
public class AppContextListener implements ServletContextListener {
    public static final String USER_SERVICE = UserService.class.getName();

    @Override
    public void contextInitialized(ServletContextEvent event) {
        event.getServletContext().setAttribute(USER_SERVICE, new UserService());
    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {
        event.getServletContext().removeAttribute(USER_SERVICE);
    }
}
