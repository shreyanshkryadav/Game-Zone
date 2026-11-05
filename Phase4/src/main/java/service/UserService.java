package service;

import exception.InvalidUserException;
import model.User;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;
import java.security.MessageDigest;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Locale;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

/**
 * Web-scoped Phase 2 service implementation. User accounts remain in memory,
 * while passwords are salted and hashed before storage.
 */
public class UserService implements UserOperations {
    private static final int ITERATIONS = 120_000;
    private static final int HASH_BITS = 256;
    private static final SecureRandom RANDOM = new SecureRandom();
    private final Map<String, Account> users = new ConcurrentHashMap<>();

    @Override
    public void validateUser(User user) throws InvalidUserException {
        if (user == null) {
            throw new InvalidUserException("User information cannot be null.");
        }
        String username = user.getUsername();
        String password = user.getPassword();
        if (username == null || username.isBlank()) {
            throw new InvalidUserException("Email address cannot be empty.");
        }
        if (!username.equals(username.trim())) {
            throw new InvalidUserException("Email address cannot begin or end with spaces.");
        }
        if (password == null || password.isBlank()) {
            throw new InvalidUserException("Password cannot be empty.");
        }
        if (password.length() < 6) {
            throw new InvalidUserException("Password must contain at least 6 characters.");
        }
    }

    @Override
    public void registerUser(User user) throws InvalidUserException {
        validateUser(user);
        String key = user.getUsername().toLowerCase(Locale.ROOT);
        byte[] salt = new byte[16];
        RANDOM.nextBytes(salt);
        byte[] hash = derive(user.getPassword().toCharArray(), salt);
        Account account = new Account(user.getFullName(), salt, hash);
        if (users.putIfAbsent(key, account) != null) {
            throw new InvalidUserException("This email address is already registered.");
        }
    }

    @Override
    public boolean authenticateUser(String username, String password) throws InvalidUserException {
        if (username == null || username.isBlank()) {
            throw new InvalidUserException("Enter your email address.");
        }
        if (password == null || password.isBlank()) {
            throw new InvalidUserException("Enter your password.");
        }
        Account account = users.get(username.trim().toLowerCase(Locale.ROOT));
        if (account == null) return false;
        byte[] candidate = derive(password.toCharArray(), account.salt);
        return MessageDigest.isEqual(candidate, account.passwordHash);
    }

    public String getFullName(String username) {
        if (username == null) return "Player";
        Account account = users.get(username.toLowerCase(Locale.ROOT));
        return account == null || account.fullName.isBlank() ? username : account.fullName;
    }

    private static byte[] derive(char[] password, byte[] salt) throws InvalidUserException {
        PBEKeySpec spec = new PBEKeySpec(password, salt, ITERATIONS, HASH_BITS);
        try {
            return SecretKeyFactory.getInstance("PBKDF2WithHmacSHA256")
                    .generateSecret(spec).getEncoded();
        } catch (Exception ex) {
            throw new InvalidUserException("The account service could not process the password.");
        } finally {
            spec.clearPassword();
            java.util.Arrays.fill(password, '\0');
        }
    }

    private static final class Account {
        private final String fullName;
        private final byte[] salt;
        private final byte[] passwordHash;

        private Account(String fullName, byte[] salt, byte[] passwordHash) {
            this.fullName = fullName == null ? "" : fullName;
            this.salt = salt.clone();
            this.passwordHash = passwordHash.clone();
        }
    }
}
