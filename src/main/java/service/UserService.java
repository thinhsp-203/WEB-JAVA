package service;

import model.User;

public interface UserService {
    User login(String username, String password);
    boolean register(String username, String password, String email, String fullname, String phone);
}
