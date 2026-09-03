<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.sql.*" %>
<% if (session.getAttribute("adminLoggedIn") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>VaraTech Sales History</title>
    <style>
        body { font-family: Arial, sans-serif; background: #f2f5f9; margin: 0; padding: 20px; }
        .container { max-width: 1000px; margin: 0 auto; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.15); }
        .header { text-align: center; border-bottom: 2px solid #ddd; padding-bottom: 15px; margin-bottom: 20px; }
        h2 { color: #1d4ed8; margin: 0; }
        table { width: 100%; border-collapse: collapse; margin-top: 15px; }
        th { background: #1d4ed8; color: white; padding: 12px; text-align: center; }
        td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        tr:nth-child(even) { background-color: #f8fafc; }
        .nav-btn { display: inline-block; margin-top: 20px; padding: 10px 20px; background: #16a34a; color: white; text-decoration: none; border-radius: 6px; }
    </style>
</head>
<body>

<div class="container">
    <div class="header">
        <h2>📊 VaraTech Electronics - Sales History</h2>
        <p>Live Database Records</p>
    </div>

    <table>
        <thead>
            <tr>
                <th>Order ID</th>
                <th>Invoice No</th>
                <th>Customer Name</th>
                <th>Phone</th>
                <th>Total Items</th>
                <th>Grand Total (₹)</th>
                <th>Date & Time</th>
            </tr>
        </thead>
        <tbody>
            <%
                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/varatech_db", "root", "");
                    Statement stmt = con.createStatement();
                    
                    // Fetch all sales ordered by newest first
                    ResultSet rs = stmt.executeQuery("SELECT * FROM sales ORDER BY id DESC");
                    
                    while (rs.next()) {
            %>
                        <tr>
                            <td><%= rs.getInt("id") %></td>
                            <td><b><%= rs.getString("invoice_no") %></b></td>
                            <td><%= rs.getString("customer_name") %></td>
                            <td><%= rs.getString("phone") %></td>
                            <td><%= rs.getInt("total_items") %></td>
                            <td><b>₹<%= rs.getDouble("grand_total") %></b></td>
                            <td><%= rs.getString("sale_date") %></td>
                        </tr>
            <%
                    }
                    con.close();
                } catch (Exception e) {
                    out.println("<tr><td colspan='7' style='color:red;'>Database Error: " + e.getMessage() + "</td></tr>");
                }
            %>
        </tbody>
    </table>

    <div style="text-align: center;">
        <a href="logout.jsp" class="nav-btn" style="background: #dc2626;">🚪 Logout</a>
    </div>
</div>

</body>
</html>