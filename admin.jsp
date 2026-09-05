<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    // Verify admin authentication session
    if (session.getAttribute("adminLoggedIn") == null) {
        response.sendRedirect("Login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>VaraTech Electronics - Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; background-color: #f4f6f9; margin: 0; padding: 0; }
        .navbar { background-color: #1d4ed8; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
        .navbar h2 { margin: 0; font-size: 22px; }
        .navbar a { color: white; background-color: #dc3545; padding: 8px 15px; text-decoration: none; border-radius: 4px; font-weight: bold; }
        .navbar a:hover { background-color: #c82333; }
        .container { max-width: 900px; margin: 40px auto; background: white; padding: 30px; border-radius: 8px; box-shadow: 0 4px 12px rgba(0,0,0,0.1); text-align: center; }
        h1 { color: #333; }
        p { color: #666; font-size: 16px; margin-bottom: 30px; }
        .btn-portal { display: inline-block; background-color: #1d4ed8; color: white; padding: 12px 25px; text-decoration: none; border-radius: 6px; font-size: 16px; font-weight: bold; }
        .btn-portal:hover { background-color: #1e40af; }
    </style>
</head>
<body>

<div class="navbar">
    <h2>VaraTech Administration</h2>
    <a href="logout.jsp">Logout</a>
</div>

<div class="container">
    <h1>Welcome, Administrator</h1>
    <p>You have successfully logged into the VaraTech Electronics Billing System control panel.</p>
    <a href="index.jsp" class="btn-portal">Go to Billing Portal</a>
</div>

</body>
</html>