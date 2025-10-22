package service;

import dao.UserDao;
import dao.UserDaoImpl;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import model.User;

public class UserServiceImpl implements UserService {
	private final UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        User user = userDao.get(username);
        if (user != null && password.trim().equals(user.getPassWord().trim())) {
            return user;
        }
        return null;
    }


    @Override
    public boolean register(String username, String password, String email, String fullname, String phone) {
        if (userDao.checkExistUsername(username) || userDao.checkExistEmail(email) || userDao.checkExistPhone(phone)) {
            return false;
        }
        User user = new User();
        user.setEmail(email);
        user.setUserName(username);
        user.setFullName(fullname);
        user.setPassWord(password);
        user.setRoleid(3);
        user.setPhone(phone);
        user.setCreatedDate(new Date());
        userDao.insert(user);
        return true;
    }
    
    @Override
    public int countUsers(String keyword, Integer roleId) {
        return userDao.count(keyword, roleId);
    }

    @Override
    public List<User> searchUsers(String keyword, Integer roleId, int page, int pageSize) {
        if (page <= 0 || pageSize <= 0) {
            return Collections.emptyList();
        }
        int offset = (page - 1) * pageSize;
        return userDao.search(keyword, roleId, offset, pageSize);
    }
}
