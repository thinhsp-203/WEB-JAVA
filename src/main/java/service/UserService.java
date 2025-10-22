package service;

import java.util.List;
import model.User;

public interface UserService {
    User login(String username, String password);
    boolean register(String username, String password, String email, String fullname, String phone);
    int countUsers(String keyword, Integer roleId);
    List<User> searchUsers(String keyword, Integer roleId, int page, int pageSize);
}
