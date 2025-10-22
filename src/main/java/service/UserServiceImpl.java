package service;

import dao.UserDao;
import dao.UserDaoImpl;
import model.User;
import java.util.Date;

public class UserServiceImpl implements UserService {
    private UserDao userDao = new UserDaoImpl();

    @Override
    public User login(String username, String password) {
        User user = userDao.get(username);
        if (user != null) {
            System.out.println("DB password=" + user.getPassWord() + ", input=" + password);
        }
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
}
