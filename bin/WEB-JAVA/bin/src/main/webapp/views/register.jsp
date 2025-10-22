<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Đăng ký</title></head>
<body>
<h2>Tạo tài khoản mới</h2>
<form action="register" method="post">
    <p style="color:red">${alert}</p>
    Email: <input type="text" name="email" /><br/>
    Username: <input type="text" name="username" /><br/>
    Fullname: <input type="text" name="fullname" /><br/>
    Password: <input type="password" name="password" /><br/>
    Phone: <input type="text" name="phone" /><br/>
    <input type="submit" value="Đăng ký" />
</form>
<p><a href="login">Quay lại đăng nhập</a></p>
</body>
</html>
