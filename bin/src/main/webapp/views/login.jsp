<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head><title>Login</title></head>
<body>
<h2>Đăng nhập</h2>
<form action="login" method="post">
    <p style="color:red">${alert}</p>
    Username: <input type="text" name="username" /><br/>
    Password: <input type="password" name="password" /><br/>
    <input type="submit" value="Login" />
</form>
<p><a href="register">Đăng ký</a></p>
</body>
</html>
