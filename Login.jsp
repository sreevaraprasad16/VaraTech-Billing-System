<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    String error = "";
    if (request.getMethod().equalsIgnoreCase("POST")) {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        
        if ("admin".equals(user) && "varatech".equals(pass)) {
            session.setAttribute("adminLoggedIn", "true");
            response.sendRedirect("admin.jsp");
            return;
        } else {
            error = "Invalid username or password.";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Login - VaraTech</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f2f5f9; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background: white; padding: 30px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.15); width: 300px; text-align: center; }
        input { width: 90%; padding: 10px; margin: 10px 0; border: 1px solid #ddd; border-radius: 5px; }
        button { background: #1d4ed8; color: white; border: none; padding: 10px 20px; border-radius: 5px; cursor: pointer; width: 100%; margin-top: 10px; }
        .error { color: red; font-size: 14px; margin-bottom: 10px; }
    </style>
</head>
<body>
    <div class="login-box">
        <h2>🔒 Admin Access</h2>
        <p class="error"><%= error %></p>
        <form method="post">
            <input type="text" name="username" placeholder="Username" required>
            <input type="password" name="password" placeholder="Password" required>
            <button type="submit">Login</button>
        </form>
        <br>
        <a href="index.jsp" style="font-size: 14px; color: #777; text-decoration: none;">🔙 Back to Store</a>
    </div>
</body>
</html>