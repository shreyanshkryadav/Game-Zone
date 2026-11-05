package service;

import exception.InvalidUserException;
import model.User;

/** Phase 2 account contract reused by the Phase 4 web application. */
public interface UserOperations {
    void validateUser(User user) throws InvalidUserException;
    void registerUser(User user) throws InvalidUserException;
    boolean authenticateUser(String username, String password) throws InvalidUserException;
}
