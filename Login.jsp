<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    String errorMsg = "";
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String user = request.getParameter("username");
        String pass = request.getParameter("password");
        
        // Credentials check
        if ("Vara".equals(user) && "varatech".equals(pass)) {
            session.setAttribute("adminLoggedIn", "true");
            response.sendRedirect("index.jsp");
            return;
        } else {
            errorMsg = "Invalid Username or Password!";
        }
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SmartCart - Admin Login</title>
    <style>
        body { font-family: Arial, sans-serif; background: linear-gradient(135deg, #3b82f6, #1e3a8a); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .login-box { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.2); width: 360px; text-align: center; }
        h2 { color: #1e3a8a; margin-bottom: 5px; }
        p { color: #666; font-size: 13px; margin-bottom: 25px; }
        .form-group { margin-bottom: 20px; text-align: left; }
        label { display: block; margin-bottom: 6px; color: #333; font-size: 14px; font-weight: bold; }
        input[type="text"], input[type="password"] { width: 100%; padding: 12px; border: 1px solid #ccc; border-radius: 6px; box-sizing: border-box; font-size: 14px; }
        button { width: 100%; padding: 12px; background-color: #2563eb; color: white; border: none; border-radius: 6px; font-size: 16px; font-weight: bold; cursor: pointer; }
        button:hover { background-color: #1d4ed8; }
        .error { color: #dc2626; font-size: 13px; margin-bottom: 15px; font-weight: bold; }
    </style>
</head>
<body>

<div class="login-box">
    <h2>Admin Login</h2>
    <p>Smart E-Commerce Billing System</p>
    
    <% if (!errorMsg.isEmpty()) { %>
        <div class="error"><%= errorMsg %></div>
    <% } %>
    
    <form action="Login.jsp" method="post">
        <div class="form-group">
            <label>Username</label>
            <input type="text" name="username" placeholder="Enter username" required autocomplete="off">
        </div>
        <div class="form-group">
            <label>Password</label>
            <input type="password" name="password" placeholder="Enter password" required>
        </div>
        <button type="submit">Login</button>
    </form>
</div>

</body>
</html>