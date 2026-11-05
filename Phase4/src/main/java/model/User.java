package model;

/**
 * Phase 4 copy of the Phase 1 player model, extended with a display name.
 * The original Phase 1 source remains unchanged.
 */
public class User {
    private String fullName;
    private String username;
    private String password;

    public User(String username, String password) {
        this("", username, password);
    }

    public User(String fullName, String username, String password) {
        this.fullName = fullName;
        this.username = username;
        this.password = password;
    }

    public String getFullName() { return fullName; }
    public void setFullName(String fullName) { this.fullName = fullName; }
    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public boolean validateUser() {
        return username != null && !username.isBlank()
                && username.equals(username.trim())
                && password != null && !password.isBlank()
                && password.length() >= 6;
    }
}
