<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Invalidate the session to clear all credentials and active states
    if (session != null) {
        session.invalidate();
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>SmartCart - Logged Out</title>
    <style>
        body { font-family: Arial, sans-serif; background: linear-gradient(135deg, #3b82f6, #1e3a8a); display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; }
        .logout-box { background: white; padding: 40px; border-radius: 12px; box-shadow: 0 8px 24px rgba(0,0,0,0.2); width: 360px; text-align: center; }
        h2 { color: #1e3a8a; margin-bottom: 10px; }
        p { color: #666; font-size: 14px; margin-bottom: 25px; }
        .btn-login { display: inline-block; width: 100%; padding: 12px; background-color: #2563eb; color: white; text-decoration: none; border-radius: 6px; font-size: 16px; font-weight: bold; box-sizing: border-box; }
        .btn-login:hover { background-color: #1d4ed8; }
    </style>
</head>
<body>

<div class="logout-box">
    <h2>Logged Out</h2>
    <p>You have successfully ended your session and logged out of the SmartCart Billing System.</p>
    <a href="Login.jsp" class="btn-login">Go to Login</a>
</div>

</body>
</html>