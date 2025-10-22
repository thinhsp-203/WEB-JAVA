package controller;

import service.UserService;
import service.UserServiceImpl;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet(urlPatterns = "/register")
public class RegisterController extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");
        req.getRequestDispatcher("views/register.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        resp.setCharacterEncoding("UTF-8");

        // Lấy & chuẩn hóa dữ liệu
        String email    = safe(req.getParameter("email"));
        String username = safe(req.getParameter("username"));
        String fullname = safe(req.getParameter("fullname"));
        String password = safe(req.getParameter("password"));
        String phone    = safe(req.getParameter("phone"));

        // Validate đơn giản
        if (email.isEmpty() || username.isEmpty() || password.isEmpty()) {
            req.setAttribute("alert", "Email/Username/Password không được rỗng!");
            req.getRequestDispatcher("views/register.jsp").forward(req, resp);
            return;
        }

        UserService service = new UserServiceImpl();
        if (service.register(username, password, email, fullname, phone)) {
            resp.sendRedirect(req.getContextPath() + "/login");
        } else {
            req.setAttribute("alert", "Tài khoản / Email / Số điện thoại đã tồn tại!");
            req.getRequestDispatcher("views/register.jsp").forward(req, resp);
        }
    }

    private String safe(String s) {
        return (s == null) ? "" : s.trim();
    }
}
