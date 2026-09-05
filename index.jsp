<%@ page language="java"
         contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"
         import="java.text.DecimalFormat,java.util.Date,java.text.SimpleDateFormat" %>

<%!
    // ================= JSP DECLARATIONS =================

    // Calculate item total
    double calculateItemTotal(double price, int quantity) {
        return price * quantity;
    }

    // Calculate bulk discount
    double calculateDiscount(double subtotal, int totalItems) {
        if (totalItems >= 10) {
            return subtotal * 0.10;
        } else if (totalItems >= 5) {
            return subtotal * 0.05;
        } else {
            return 0.0;
        }
    }

    // Calculate GST
    double calculateTax(double amount) {
        return amount * 0.18;
    }
%>

<%
    // ================= CUSTOMER DETAILS =================

    String customerName = request.getParameter("customerName");
    String phone = request.getParameter("phone");
    String location = request.getParameter("location");
    String address = request.getParameter("address");
    String paymentMethod = request.getParameter("paymentMethod");

    if (customerName == null || customerName.trim().equals("")) {
        customerName = "Guest Customer";
    }

    if (phone == null) {
        phone = "";
    }

    if (location == null) {
        location = "";
    }

    if (address == null) {
        address = "";
    }

    if (paymentMethod == null || paymentMethod.trim().equals("")) {
        paymentMethod = "Not Selected";
    }


    // ================= PRODUCT PRICES =================

    double laptopPrice = 55000.00;
    double headphonePrice = 2500.00;
    double mousePrice = 1200.00;
    double keyboardPrice = 1800.00;
    double smartphonePrice = 25000.00;


    // ================= QUANTITIES =================

    int laptopQty = 0;
    int headphoneQty = 0;
    int mouseQty = 0;
    int keyboardQty = 0;
    int smartphoneQty = 0;


    // ================= READ QUANTITIES =================

    try {
        laptopQty = Integer.parseInt(request.getParameter("laptopQty"));
    } catch (Exception e) {
        laptopQty = 0;
    }

    try {
        headphoneQty = Integer.parseInt(request.getParameter("headphoneQty"));
    } catch (Exception e) {
        headphoneQty = 0;
    }

    try {
        mouseQty = Integer.parseInt(request.getParameter("mouseQty"));
    } catch (Exception e) {
        mouseQty = 0;
    }

    try {
        keyboardQty = Integer.parseInt(request.getParameter("keyboardQty"));
    } catch (Exception e) {
        keyboardQty = 0;
    }

    try {
        smartphoneQty = Integer.parseInt(request.getParameter("smartphoneQty"));
    } catch (Exception e) {
        smartphoneQty = 0;
    }


    // ================= ITEM TOTALS =================

    double laptopTotal =
        calculateItemTotal(laptopPrice, laptopQty);

    double headphoneTotal =
        calculateItemTotal(headphonePrice, headphoneQty);

    double mouseTotal =
        calculateItemTotal(mousePrice, mouseQty);

    double keyboardTotal =
        calculateItemTotal(keyboardPrice, keyboardQty);

    double smartphoneTotal =
        calculateItemTotal(smartphonePrice, smartphoneQty);


    // ================= BILL CALCULATION =================

    int totalItems =
        laptopQty +
        headphoneQty +
        mouseQty +
        keyboardQty +
        smartphoneQty;

    double subtotal =
        laptopTotal +
        headphoneTotal +
        mouseTotal +
        keyboardTotal +
        smartphoneTotal;

    double discount =
        calculateDiscount(subtotal, totalItems);

    double discountedAmount =
        subtotal - discount;

    double tax =
        calculateTax(discountedAmount);

    double grandTotal =
        discountedAmount + tax;


    // ================= FORMATTING =================

    DecimalFormat df =
        new DecimalFormat("0.00");

    SimpleDateFormat sdf =
        new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");

    String invoiceDate =
        sdf.format(new Date());


    // ================= INVOICE NUMBER =================

    String invoiceNumber =
        "SCT-" + System.currentTimeMillis();
%>


<!DOCTYPE html>
<html>

<head>

<meta charset="UTF-8">

<title>Smart E-Commerce Billing System</title>


<style>

* {
    box-sizing: border-box;
}

body {

    font-family: Arial, sans-serif;

    background: #f2f4f7;

    margin: 0;

    padding: 30px;
}


.container {

    width: 950px;

    margin: auto;

    background: white;

    padding: 30px;

    border-radius: 12px;

    box-shadow: 0 4px 18px rgba(0,0,0,0.15);
}


.header {

    text-align: center;

    border-bottom: 2px solid #333;

    padding-bottom: 20px;

    margin-bottom: 25px;
}


.header h1 {

    margin: 0;

    font-size: 30px;
}


.company {

    font-size: 18px;

    font-weight: bold;

    margin-top: 8px;
}


.section-title {

    background: #343a40;

    color: white;

    padding: 12px;

    margin-top: 20px;

    border-radius: 5px;

    font-size: 18px;

    font-weight: bold;
}


.customer-grid {

    display: grid;

    grid-template-columns: 1fr 1fr;

    gap: 15px;

    margin-top: 15px;
}


.form-group {

    display: flex;

    flex-direction: column;

    gap: 6px;
}


.form-group label {

    font-weight: bold;
}


input[type="text"],
input[type="number"],
textarea,
select {

    padding: 10px;

    border: 1px solid #ccc;

    border-radius: 5px;

    font-size: 14px;

    width: 100%;
}


textarea {

    resize: vertical;

    min-height: 80px;
}


.full-width {

    grid-column: 1 / 3;
}


table {

    width: 100%;

    border-collapse: collapse;

    margin-top: 15px;
}


th,
td {

    border: 1px solid #ddd;

    padding: 12px;

    text-align: center;
}


th {

    background: #343a40;

    color: white;
}


.product-table input {

    width: 90px;

    text-align: center;
}


.payment-options {

    display: grid;

    grid-template-columns: repeat(3, 1fr);

    gap: 10px;

    margin-top: 15px;
}


.payment-option {

    border: 1px solid #ccc;

    padding: 12px;

    border-radius: 6px;

    background: #fafafa;
}


.payment-option label {

    cursor: pointer;

    font-weight: bold;
}


.button-area {

    text-align: center;

    margin-top: 25px;
}


button {

    padding: 13px 25px;

    border: none;

    border-radius: 6px;

    cursor: pointer;

    font-size: 16px;

    margin: 5px;
}


.generate {

    background: #007bff;

    color: white;
}


.print {

    background: #28a745;

    color: white;
}


button:hover {

    opacity: 0.85;
}


.invoice {

    margin-top: 35px;

    border-top: 3px solid #333;

    padding-top: 25px;
}


.invoice-header {

    display: flex;

    justify-content: space-between;

    margin-bottom: 20px;
}


.customer-details {

    background: #f8f9fa;

    padding: 15px;

    border-radius: 6px;

    line-height: 1.7;
}


.summary {

    width: 420px;

    margin-left: auto;

    margin-top: 25px;
}


.summary td {

    text-align: right;
}


.grand-total {

    font-size: 20px;

    font-weight: bold;

    background: #e9ecef;
}


.discount {

    font-weight: bold;

}


.thank-you {

    text-align: center;

    margin-top: 30px;

    font-weight: bold;

    font-size: 16px;
}


.footer {

    text-align: center;

    margin-top: 15px;

    font-size: 12px;

    color: #666;
}


/* ================= PRINT STYLE ================= */

@media print {

    body {

        background: white;

        padding: 0;
    }

    .container {

        width: 100%;

        box-shadow: none;

        padding: 10px;
    }

    .input-section,
    .button-area,
    .section-title.form-title {

        display: none !important;
    }

    .invoice {

        border-top: none;

        margin-top: 0;
    }

    .print-hide {

        display: none !important;
    }

}

</style>


<script>

function printInvoice() {

    window.print();

}

</script>

</head>


<body>


<div class="container">


<!-- ================= HEADER ================= -->

<div class="header">

    <h1>Dynamic Smart Receipt</h1>

    <div class="company">
        SmartCart Technologies
    </div>

    <div>
        Smart E-Commerce Billing System
    </div>

</div>



<!-- ================= INPUT SECTION ================= -->

<div class="input-section">


<div class="section-title form-title">
    Customer Information
</div>


<form method="post" action="index.jsp">


<div class="customer-grid">


<div class="form-group">

    <label>Customer Name</label>

    <input type="text"
           name="customerName"
           placeholder="Enter customer name"
           value="<%= customerName.equals("Guest Customer") ? "" : customerName %>"
           required>

</div>


<div class="form-group">

    <label>Phone Number</label>

    <input type="text"
           name="phone"
           placeholder="Enter phone number"
           value="<%= phone %>"
           maxlength="10"
           required>

</div>


<div class="form-group">

    <label>Location</label>

    <input type="text"
           name="location"
           placeholder="City / Location"
           value="<%= location %>"
           required>

</div>


<div class="form-group">

    <label>Delivery Address</label>

    <input type="text"
           name="address"
           placeholder="Enter delivery address"
           value="<%= address %>"
           required>

</div>


</div>



<!-- ================= PRODUCTS ================= -->

<div class="section-title">
    Select Products and Quantity
</div>


<table class="product-table">

<tr>

    <th>Product</th>

    <th>Unit Price</th>

    <th>Quantity</th>

</tr>


<tr>

    <td>Laptop</td>

    <td>₹55,000.00</td>

    <td>
        <input type="number"
               name="laptopQty"
               min="0"
               value="<%= laptopQty %>">
    </td>

</tr>


<tr>

    <td>Wireless Headphones</td>

    <td>₹2,500.00</td>

    <td>
        <input type="number"
               name="headphoneQty"
               min="0"
               value="<%= headphoneQty %>">
    </td>

</tr>


<tr>

    <td>Wireless Mouse</td>

    <td>₹1,200.00</td>

    <td>
        <input type="number"
               name="mouseQty"
               min="0"
               value="<%= mouseQty %>">
    </td>

</tr>


<tr>

    <td>Keyboard</td>

    <td>₹1,800.00</td>

    <td>
        <input type="number"
               name="keyboardQty"
               min="0"
               value="<%= keyboardQty %>">
    </td>

</tr>


<tr>

    <td>Smartphone</td>

    <td>₹25,000.00</td>

    <td>
        <input type="number"
               name="smartphoneQty"
               min="0"
               value="<%= smartphoneQty %>">
    </td>

</tr>

</table>



<!-- ================= PAYMENT ================= -->

<div class="section-title">
    Payment Method
</div>


<div class="payment-options">


<div class="payment-option">

    <label>

        <input type="radio"
               name="paymentMethod"
               value="UPI"
               <%= paymentMethod.equals("UPI") ? "checked" : "" %>>

        UPI

    </label>

</div>


<div class="payment-option">

    <label>

        <input type="radio"
               name="paymentMethod"
               value="Cash"
               <%= paymentMethod.equals("Cash") ? "checked" : "" %>>

        Cash

    </label>

</div>


<div class="payment-option">

    <label>

        <input type="radio"
               name="paymentMethod"
               value="Wallet"
               <%= paymentMethod.equals("Wallet") ? "checked" : "" %>>

        Wallet

    </label>

</div>


<div class="payment-option">

    <label>

        <input type="radio"
               name="paymentMethod"
               value="Net Banking"
               <%= paymentMethod.equals("Net Banking") ? "checked" : "" %>>

        Net Banking

    </label>

</div>


<div class="payment-option">

    <label>

        <input type="radio"
               name="paymentMethod"
               value="Credit/Debit Card"
               <%= paymentMethod.equals("Credit/Debit Card") ? "checked" : "" %>>

        Credit/Debit Card

    </label>

</div>


</div>



<div class="button-area">

    <button class="generate" type="submit">

        Generate Smart Receipt

    </button>

</div>


</form>

</div>



<!-- ================= INVOICE ================= -->

<div class="invoice" id="invoice">


<div class="invoice-header">


<div>

    <h2>INVOICE / RECEIPT</h2>

    <strong>Invoice No:</strong>
    <%= invoiceNumber %>

</div>


<div>

    <strong>Date:</strong>
    <%= invoiceDate %>

</div>


</div>



<!-- ================= CUSTOMER DETAILS ================= -->

<div class="section-title">

    Customer & Delivery Details

</div>


<div class="customer-details">


<strong>Customer Name:</strong>
<%= customerName %>
<br>


<strong>Phone Number:</strong>
<%= phone.equals("") ? "Not Provided" : phone %>
<br>


<strong>Location:</strong>
<%= location.equals("") ? "Not Provided" : location %>
<br>


<strong>Delivery Address:</strong>
<%= address.equals("") ? "Not Provided" : address %>
<br>


<strong>Payment Method:</strong>
<%= paymentMethod %>


</div>



<!-- ================= ITEMIZED INVOICE ================= -->

<div class="section-title">

    Purchased Items

</div>


<table>


<tr>

    <th>Product</th>

    <th>Quantity</th>

    <th>Unit Price</th>

    <th>Item Total</th>

</tr>


<% if (laptopQty > 0) { %>

<tr>

    <td>Laptop</td>

    <td><%= laptopQty %></td>

    <td>₹<%= df.format(laptopPrice) %></td>

    <td>₹<%= df.format(laptopTotal) %></td>

</tr>

<% } %>


<% if (headphoneQty > 0) { %>

<tr>

    <td>Wireless Headphones</td>

    <td><%= headphoneQty %></td>

    <td>₹<%= df.format(headphonePrice) %></td>

    <td>₹<%= df.format(headphoneTotal) %></td>

</tr>

<% } %>


<% if (mouseQty > 0) { %>

<tr>

    <td>Wireless Mouse</td>

    <td><%= mouseQty %></td>

    <td>₹<%= df.format(mousePrice) %></td>

    <td>₹<%= df.format(mouseTotal) %></td>

</tr>

<% } %>


<% if (keyboardQty > 0) { %>

<tr>

    <td>Keyboard</td>

    <td><%= keyboardQty %></td>

    <td>₹<%= df.format(keyboardPrice) %></td>

    <td>₹<%= df.format(keyboardTotal) %></td>

</tr>

<% } %>


<% if (smartphoneQty > 0) { %>

<tr>

    <td>Smartphone</td>

    <td><%= smartphoneQty %></td>

    <td>₹<%= df.format(smartphonePrice) %></td>

    <td>₹<%= df.format(smartphoneTotal) %></td>

</tr>

<% } %>


</table>



<!-- ================= BILL SUMMARY ================= -->

<table class="summary">


<tr>

    <td>
        <strong>Total Items:</strong>
    </td>

    <td>
        <%= totalItems %>
    </td>

</tr>


<tr>

    <td>
        <strong>Subtotal:</strong>
    </td>

    <td>
        ₹<%= df.format(subtotal) %>
    </td>

</tr>


<tr>

    <td class="discount">
        Bulk Discount:
    </td>

    <td class="discount">
        - ₹<%= df.format(discount) %>
    </td>

</tr>


<tr>

    <td>
        <strong>Amount After Discount:</strong>
    </td>

    <td>
        ₹<%= df.format(discountedAmount) %>
    </td>

</tr>


<tr>

    <td>
        <strong>GST (18%):</strong>
    </td>

    <td>
        ₹<%= df.format(tax) %>
    </td>

</tr>


<tr class="grand-total">

    <td>
        GRAND TOTAL:
    </td>

    <td>
        ₹<%= df.format(grandTotal) %>
    </td>

</tr>


</table>



<!-- ================= PRINT BUTTON ================= -->

<div class="button-area print-hide">

    <button class="print"
            onclick="printInvoice()">

        🖨️ Print Invoice / Receipt

    </button>

</div>



<div class="thank-you">

    Thank you for shopping with SmartCart Technologies!

</div>


<div class="footer">

    This is a computer-generated invoice and does not require a signature.

</div>


</div>


</div>


</body>

</html>