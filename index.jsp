<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" import="java.text.SimpleDateFormat,java.util.Date,java.text.DecimalFormat,java.sql.*" %>
<%!
    // ================= JSP DECLARATION =================
    // Method for calculating item total
    double calculateTotal(double price, int quantity) {
        return price * quantity;
    }

    // Method for calculating automatic bulk discount
    double calculateDiscount(double subtotal, int totalItems) {
        if (totalItems >= 10) {
            return subtotal * 0.10;   // 10% discount
        } else if (totalItems >= 5) {
            return subtotal * 0.05;   // 5% discount
        }
        return 0;
    }

    // Method for calculating GST
    double calculateGST(double amount) {
        return amount * 0.12;         // 12% GST
    }
%>

<%
    // ================= JSP SCRIPTLET =================

    // Customer details
    String customerName = request.getParameter("customerName");
    String phone = request.getParameter("phone");
    String paymentMethod = request.getParameter("paymentMethod");

    if (customerName == null || customerName.trim().equals("")) { customerName = "Guest Customer"; }
    if (phone == null || phone.trim().equals("")) { phone = "Not Provided"; }
    if (paymentMethod == null || paymentMethod.trim().equals("")) { paymentMethod = "Not Selected"; }

    // Product quantities
    int laptop = 0, desktop = 0, smartphone = 0, tablet = 0, keyboard = 0, mouse = 0;
    int headphones = 0, speaker = 0, camera = 0, smartwatch = 0, printer = 0, television = 0;
    int gamingConsole = 0, powerBank = 0, charger = 0, usbCable = 0, router = 0, microphone = 0;

    // Read quantities from form
    if (request.getParameter("laptop") != null) {
        laptop = Integer.parseInt(request.getParameter("laptop"));
        desktop = Integer.parseInt(request.getParameter("desktop"));
        smartphone = Integer.parseInt(request.getParameter("smartphone"));
        tablet = Integer.parseInt(request.getParameter("tablet"));
        keyboard = Integer.parseInt(request.getParameter("keyboard"));
        mouse = Integer.parseInt(request.getParameter("mouse"));
        headphones = Integer.parseInt(request.getParameter("headphones"));
        speaker = Integer.parseInt(request.getParameter("speaker"));
        camera = Integer.parseInt(request.getParameter("camera"));
        smartwatch = Integer.parseInt(request.getParameter("smartwatch"));
        printer = Integer.parseInt(request.getParameter("printer"));
        television = Integer.parseInt(request.getParameter("television"));
        gamingConsole = Integer.parseInt(request.getParameter("gamingConsole"));
        powerBank = Integer.parseInt(request.getParameter("powerBank"));
        charger = Integer.parseInt(request.getParameter("charger"));
        usbCable = Integer.parseInt(request.getParameter("usbCable"));
        router = Integer.parseInt(request.getParameter("router"));
        microphone = Integer.parseInt(request.getParameter("microphone"));
    }

    // Product prices (Defaults set in case the database is empty or names don't match)
    double laptopPrice = 50000, desktopPrice = 45000, smartphonePrice = 25000;
    double tabletPrice = 18000, keyboardPrice = 1500, mousePrice = 800;
    double headphonesPrice = 2500, speakerPrice = 3500, cameraPrice = 30000;
    double smartwatchPrice = 5000, printerPrice = 12000, televisionPrice = 40000;
    double gamingConsolePrice = 45000, powerBankPrice = 2000, chargerPrice = 1200;
    double usbCablePrice = 500, routerPrice = 2500, microphonePrice = 3000;

    // Connect to MySQL to fetch live prices (will overwrite the defaults above if found)
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/varatech_db", "root", "");
        Statement stmt = con.createStatement();
        ResultSet rs = stmt.executeQuery("SELECT name, price FROM products");

        while (rs.next()) {
            String dbName = rs.getString("name");
            if (dbName.equals("Laptop")) laptopPrice = rs.getDouble("price");
            if (dbName.equals("Desktop Computer")) desktopPrice = rs.getDouble("price");
            if (dbName.equals("Smartphone")) smartphonePrice = rs.getDouble("price");
            if (dbName.equals("Tablet")) tabletPrice = rs.getDouble("price");
            if (dbName.equals("Keyboard")) keyboardPrice = rs.getDouble("price");
            if (dbName.equals("Mouse")) mousePrice = rs.getDouble("price");
            if (dbName.equals("Headphones")) headphonesPrice = rs.getDouble("price");
            if (dbName.equals("Bluetooth Speaker") || dbName.equals("Speaker")) speakerPrice = rs.getDouble("price");
            if (dbName.equals("Camera")) cameraPrice = rs.getDouble("price");
            if (dbName.equals("Smart Watch") || dbName.equals("Smartwatch")) smartwatchPrice = rs.getDouble("price");
            if (dbName.equals("Printer")) printerPrice = rs.getDouble("price");
            if (dbName.equals("Television")) televisionPrice = rs.getDouble("price");
            if (dbName.equals("Gaming Console")) gamingConsolePrice = rs.getDouble("price");
            if (dbName.equals("Power Bank")) powerBankPrice = rs.getDouble("price");
            if (dbName.equals("Charger")) chargerPrice = rs.getDouble("price");
            if (dbName.equals("USB Cable")) usbCablePrice = rs.getDouble("price");
            if (dbName.equals("Wi-Fi Router") || dbName.equals("Router")) routerPrice = rs.getDouble("price");
            if (dbName.equals("Microphone")) microphonePrice = rs.getDouble("price");
        }
        con.close();
    } catch (Exception e) {
        out.println("<p style='color:red;'>Database Error: " + e.getMessage() + "</p>");
    }

    // Item totals
    double laptopTotal = calculateTotal(laptopPrice, laptop);
    double desktopTotal = calculateTotal(desktopPrice, desktop);
    double smartphoneTotal = calculateTotal(smartphonePrice, smartphone);
    double tabletTotal = calculateTotal(tabletPrice, tablet);
    double keyboardTotal = calculateTotal(keyboardPrice, keyboard);
    double mouseTotal = calculateTotal(mousePrice, mouse);
    double headphonesTotal = calculateTotal(headphonesPrice, headphones);
    double speakerTotal = calculateTotal(speakerPrice, speaker);
    double cameraTotal = calculateTotal(cameraPrice, camera);
    double smartwatchTotal = calculateTotal(smartwatchPrice, smartwatch);
    double printerTotal = calculateTotal(printerPrice, printer);
    double televisionTotal = calculateTotal(televisionPrice, television);
    double gamingConsoleTotal = calculateTotal(gamingConsolePrice, gamingConsole);
    double powerBankTotal = calculateTotal(powerBankPrice, powerBank);
    double chargerTotal = calculateTotal(chargerPrice, charger);
    double usbCableTotal = calculateTotal(usbCablePrice, usbCable);
    double routerTotal = calculateTotal(routerPrice, router);
    double microphoneTotal = calculateTotal(microphonePrice, microphone);

    // Total number of items
    int totalItems = laptop + desktop + smartphone + tablet + keyboard + mouse + headphones + speaker + camera + smartwatch + printer + television + gamingConsole + powerBank + charger + usbCable + router + microphone;

    // Subtotal
    double subtotal = laptopTotal + desktopTotal + smartphoneTotal + tabletTotal + keyboardTotal + mouseTotal + headphonesTotal + speakerTotal + cameraTotal + smartwatchTotal + printerTotal + televisionTotal + gamingConsoleTotal + powerBankTotal + chargerTotal + usbCableTotal + routerTotal + microphoneTotal;

    // Discount
    double discount = calculateDiscount(subtotal, totalItems);

    // Taxable amount
    double taxableAmount = subtotal - discount;

    // GST
    double totalGST = calculateGST(taxableAmount);
    double cgst = totalGST / 2;
    double sgst = totalGST / 2;

    // Grand total
    double grandTotal = taxableAmount + totalGST;

    // Date and time
    SimpleDateFormat dateFormat = new SimpleDateFormat("dd-MM-yyyy");
    SimpleDateFormat timeFormat = new SimpleDateFormat("hh:mm:ss a");

    String currentDate = dateFormat.format(new Date());
    String currentTime = timeFormat.format(new Date());

    // Invoice number
    String invoiceNumber = "INV-" + new SimpleDateFormat("yyyyMMddHHmmss").format(new Date());
    DecimalFormat df = new DecimalFormat("0.00");
    boolean invoiceGenerated = request.getParameter("customerName") != null;
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dynamic Online Billing System</title>
    <style>
        * { box-sizing: border-box; }
        body { margin: 0; font-family: Arial, sans-serif; background: #f2f5f9; }
        .container { width: 95%; max-width: 1100px; margin: 30px auto; background: white; padding: 25px; border-radius: 12px; box-shadow: 0 4px 15px rgba(0,0,0,0.15); }
        .header { text-align: center; border-bottom: 2px solid #ddd; padding-bottom: 15px; }
        .logo { font-size: 32px; font-weight: bold; color: #1d4ed8; }
        .header h2 { margin: 8px; }
        .section { margin-top: 25px; padding: 20px; border-radius: 10px; background: #f8fafc; }
        .section h3 { color: #1d4ed8; }
        .form-row { display: flex; gap: 15px; flex-wrap: wrap; }
        .form-group { flex: 1; min-width: 200px; }
        label { font-weight: bold; display: block; margin-bottom: 6px; }
        input, select { width: 100%; padding: 10px; border: 1px solid #bbb; border-radius: 5px; }
        .search { margin-bottom: 15px; }
        table { width: 100%; border-collapse: collapse; background: white; }
        th { background: #1d4ed8; color: white; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        .quantity { width: 80px; }
        .buttons { text-align: center; margin-top: 25px; }
        button { padding: 12px 25px; border: none; border-radius: 6px; margin: 5px; cursor: pointer; font-size: 15px; }
        .generate { background: #1d4ed8; color: white; }
        .reset { background: #777; color: white; }
        .print { background: #16a34a; color: white; }
        .success { margin-top: 25px; padding: 15px; background: #dcfce7; color: #166534; text-align: center; border-radius: 6px; font-weight: bold; }
        .invoice { margin-top: 30px; border: 2px solid #ddd; padding: 20px; }
        .invoice-header { display: flex; justify-content: space-between; flex-wrap: wrap; }
        .summary { width: 350px; margin-left: auto; margin-top: 20px; }
        .summary p { display: flex; justify-content: space-between; }
        .grand-total { font-size: 22px; font-weight: bold; border-top: 2px solid #333; padding-top: 10px; }
        .thankyou { text-align: center; margin-top: 25px; font-size: 20px; font-weight: bold; }
        .footer { text-align: center; margin-top: 25px; font-size: 13px; color: #777; }
        @media print {
            body { background: white; }
            .container { width: 100%; box-shadow: none; margin: 0; }
            .input-section, .buttons, .success { display: none; }
        }
    </style>
    <script>
        function searchProducts() {
            let search = document.getElementById("productSearch").value.toLowerCase();
            let rows = document.querySelectorAll("#productTable tbody tr");
            rows.forEach(function(row) {
                let product = row.cells[1].innerText.toLowerCase();
                if (product.includes(search)) {
                    row.style.display = "";
                } else {
                    row.style.display = "none";
                }
            });
        }
        function printInvoice() {
            window.print();
        }
    </script>
</head>
<body>
<div class="container">
    <div class="header">
        <div class="logo">VaraTech Electronics</div>
        <h2>Dynamic Online Billing System</h2>
        <p>Vignan Foundation of Science, Technology and Research</p>
    </div>

    <div class="section input-section">
        <h3>👤 Customer Details</h3>
        <form method="post" action="index.jsp">
            <div class="form-row">
                <div class="form-group">
                    <label>Customer Name</label>
                    <input type="text" name="customerName" placeholder="Enter customer name" required>
                </div>
                <div class="form-group">
                    <label>Phone Number</label>
                    <input type="tel" name="phone" placeholder="Enter phone number" pattern="[0-9]{10}" maxlength="10" required>
                </div>
                <div class="form-group">
                    <label>Payment Method</label>
                    <select name="paymentMethod" required>
                        <option value="">Select Payment Method</option>
                        <option value="Cash">Cash</option>
                        <option value="UPI">UPI</option>
                        <option value="Credit Card">Credit Card</option>
                        <option value="Debit Card">Debit Card</option>
                        <option value="Net Banking">Net Banking</option>
                    </select>
                </div>
            </div>

            <div class="section">
                <h3>🛒 Product Details</h3>
                <input type="text" id="productSearch" class="search" onkeyup="searchProducts()" placeholder="🔍 Search electronic product...">
                <table id="productTable">
                    <thead>
                    <tr>
                        <th>Select</th>
                        <th>Product</th>
                        <th>Price (₹)</th>
                        <th>Quantity</th>
                    </tr>
                    </thead>
                    <tbody>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Laptop</td>
                        <td>₹<%= df.format(laptopPrice) %></td>
                        <td><input class="quantity" type="number" name="laptop" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Desktop Computer</td>
                        <td>₹<%= df.format(desktopPrice) %></td>
                        <td><input class="quantity" type="number" name="desktop" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Smartphone</td>
                        <td>₹<%= df.format(smartphonePrice) %></td>
                        <td><input class="quantity" type="number" name="smartphone" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Tablet</td>
                        <td>₹<%= df.format(tabletPrice) %></td>
                        <td><input class="quantity" type="number" name="tablet" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Keyboard</td>
                        <td>₹<%= df.format(keyboardPrice) %></td>
                        <td><input class="quantity" type="number" name="keyboard" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Mouse</td>
                        <td>₹<%= df.format(mousePrice) %></td>
                        <td><input class="quantity" type="number" name="mouse" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Headphones</td>
                        <td>₹<%= df.format(headphonesPrice) %></td>
                        <td><input class="quantity" type="number" name="headphones" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Bluetooth Speaker</td>
                        <td>₹<%= df.format(speakerPrice) %></td>
                        <td><input class="quantity" type="number" name="speaker" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Camera</td>
                        <td>₹<%= df.format(cameraPrice) %></td>
                        <td><input class="quantity" type="number" name="camera" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Smart Watch</td>
                        <td>₹<%= df.format(smartwatchPrice) %></td>
                        <td><input class="quantity" type="number" name="smartwatch" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Printer</td>
                        <td>₹<%= df.format(printerPrice) %></td>
                        <td><input class="quantity" type="number" name="printer" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Television</td>
                        <td>₹<%= df.format(televisionPrice) %></td>
                        <td><input class="quantity" type="number" name="television" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Gaming Console</td>
                        <td>₹<%= df.format(gamingConsolePrice) %></td>
                        <td><input class="quantity" type="number" name="gamingConsole" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Power Bank</td>
                        <td>₹<%= df.format(powerBankPrice) %></td>
                        <td><input class="quantity" type="number" name="powerBank" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Charger</td>
                        <td>₹<%= df.format(chargerPrice) %></td>
                        <td><input class="quantity" type="number" name="charger" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>USB Cable</td>
                        <td>₹<%= df.format(usbCablePrice) %></td>
                        <td><input class="quantity" type="number" name="usbCable" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Wi-Fi Router</td>
                        <td>₹<%= df.format(routerPrice) %></td>
                        <td><input class="quantity" type="number" name="router" value="0" min="0"></td>
                    </tr>
                    <tr>
                        <td><input type="checkbox"></td>
                        <td>Microphone</td>
                        <td>₹<%= df.format(microphonePrice) %></td>
                        <td><input class="quantity" type="number" name="microphone" value="0" min="0"></td>
                    </tr>
                    </tbody>
                </table>
            </div>

            <div class="buttons">
                <button type="submit" class="generate">Generate Invoice</button>
                <button type="reset" class="reset">Clear / Reset</button>
            </div>
        </form>
    </div>

    <!-- ================= GENERATED INVOICE ================= -->
    <% if (invoiceGenerated) { %>
        <div class="success">✅ Invoice Generated Successfully!</div>
        <div class="invoice" id="invoice">
            <div class="invoice-header">
                <div>
                    <h2>VaraTech Electronics</h2>
                    <p>Dynamic Online Billing System</p>
                    <p>📍 Vijayawada, Andhra Pradesh</p>
                    <p>📧 support@varatechelectronics.com</p>
                    <p>📞 +91 90000 00000</p>
                </div>
                <div>
                    <p><b>Invoice No:</b> <%= invoiceNumber %></p>
                    <p><b>Date:</b> <%= currentDate %></p>
                    <p><b>Time:</b> <%= currentTime %></p>
                    <p><b>Status:</b> ✅ Confirmed</p>
                </div>
            </div>
            <hr>
            <h3>Customer Information</h3>
            <p><b>Name:</b> <%= customerName %></p>
            <p><b>Phone:</b> <%= phone %></p>
            <p><b>Payment Method:</b> <%= paymentMethod %></p>

            <h3>Purchased Items</h3>
            <table>
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>Unit Price</th>
                    <th>Total</th>
                </tr>
                <% if (laptop > 0) { %>
                <tr>
                    <td>Laptop</td>
                    <td><%= laptop %></td>
                    <td>₹<%= df.format(laptopPrice) %></td>
                    <td>₹<%= df.format(laptopTotal) %></td>
                </tr>
                <% } %>
                <% if (desktop > 0) { %>
                <tr>
                    <td>Desktop Computer</td>
                    <td><%= desktop %></td>
                    <td>₹<%= df.format(desktopPrice) %></td>
                    <td>₹<%= df.format(desktopTotal) %></td>
                </tr>
                <% } %>
                <% if (smartphone > 0) { %>
                <tr>
                    <td>Smartphone</td>
                    <td><%= smartphone %></td>
                    <td>₹<%= df.format(smartphonePrice) %></td>
                    <td>₹<%= df.format(smartphoneTotal) %></td>
                </tr>
                <% } %>
                <% if (tablet > 0) { %>
                <tr>
                    <td>Tablet</td>
                    <td><%= tablet %></td>
                    <td>₹<%= df.format(tabletPrice) %></td>
                    <td>₹<%= df.format(tabletTotal) %></td>
                </tr>
                <% } %>
                <% if (keyboard > 0) { %>
                <tr>
                    <td>Keyboard</td>
                    <td><%= keyboard %></td>
                    <td>₹<%= df.format(keyboardPrice) %></td>
                    <td>₹<%= df.format(keyboardTotal) %></td>
                </tr>
                <% } %>
                <% if (mouse > 0) { %>
                <tr>
                    <td>Mouse</td>
                    <td><%= mouse %></td>
                    <td>₹<%= df.format(mousePrice) %></td>
                    <td>₹<%= df.format(mouseTotal) %></td>
                </tr>
                <% } %>
                <% if (headphones > 0) { %>
                <tr>
                    <td>Headphones</td>
                    <td><%= headphones %></td>
                    <td>₹<%= df.format(headphonesPrice) %></td>
                    <td>₹<%= df.format(headphonesTotal) %></td>
                </tr>
                <% } %>
                <% if (speaker > 0) { %>
                <tr>
                    <td>Bluetooth Speaker</td>
                    <td><%= speaker %></td>
                    <td>₹<%= df.format(speakerPrice) %></td>
                    <td>₹<%= df.format(speakerTotal) %></td>
                </tr>
                <% } %>
                <% if (camera > 0) { %>
                <tr>
                    <td>Camera</td>
                    <td><%= camera %></td>
                    <td>₹<%= df.format(cameraPrice) %></td>
                    <td>₹<%= df.format(cameraTotal) %></td>
                </tr>
                <% } %>
                <% if (smartwatch > 0) { %>
                <tr>
                    <td>Smart Watch</td>
                    <td><%= smartwatch %></td>
                    <td>₹<%= df.format(smartwatchPrice) %></td>
                    <td>₹<%= df.format(smartwatchTotal) %></td>
                </tr>
                <% } %>
                <% if (printer > 0) { %>
                <tr>
                    <td>Printer</td>
                    <td><%= printer %></td>
                    <td>₹<%= df.format(printerPrice) %></td>
                    <td>₹<%= df.format(printerTotal) %></td>
                </tr>
                <% } %>
                <% if (television > 0) { %>
                <tr>
                    <td>Television</td>
                    <td><%= television %></td>
                    <td>₹<%= df.format(televisionPrice) %></td>
                    <td>₹<%= df.format(televisionTotal) %></td>
                </tr>
                <% } %>
                <% if (gamingConsole > 0) { %>
                <tr>
                    <td>Gaming Console</td>
                    <td><%= gamingConsole %></td>
                    <td>₹<%= df.format(gamingConsolePrice) %></td>
                    <td>₹<%= df.format(gamingConsoleTotal) %></td>
                </tr>
                <% } %>
                <% if (powerBank > 0) { %>
                <tr>
                    <td>Power Bank</td>
                    <td><%= powerBank %></td>
                    <td>₹<%= df.format(powerBankPrice) %></td>
                    <td>₹<%= df.format(powerBankTotal) %></td>
                </tr>
                <% } %>
                <% if (charger > 0) { %>
                <tr>
                    <td>Charger</td>
                    <td><%= charger %></td>
                    <td>₹<%= df.format(chargerPrice) %></td>
                    <td>₹<%= df.format(chargerTotal) %></td>
                </tr>
                <% } %>
                <% if (usbCable > 0) { %>
                <tr>
                    <td>USB Cable</td>
                    <td><%= usbCable %></td>
                    <td>₹<%= df.format(usbCablePrice) %></td>
                    <td>₹<%= df.format(usbCableTotal) %></td>
                </tr>
                <% } %>
                <% if (router > 0) { %>
                <tr>
                    <td>Wi-Fi Router</td>
                    <td><%= router %></td>
                    <td>₹<%= df.format(routerPrice) %></td>
                    <td>₹<%= df.format(routerTotal) %></td>
                </tr>
                <% } %>
                <% if (microphone > 0) { %>
                <tr>
                    <td>Microphone</td>
                    <td><%= microphone %></td>
                    <td>₹<%= df.format(microphonePrice) %></td>
                    <td>₹<%= df.format(microphoneTotal) %></td>
                </tr>
                <% } %>
            </table>

            <div class="summary">
                <p><b>Total Items:</b> <span><%= totalItems %></span></p>
                <p><b>Subtotal:</b> <span>₹<%= df.format(subtotal) %></span></p>
                <p><b>Bulk Discount:</b> <span>₹<%= df.format(discount) %></span></p>
                <p><b>Taxable Amount:</b> <span>₹<%= df.format(taxableAmount) %></span></p>
                <p><b>CGST (6%):</b> <span>₹<%= df.format(cgst) %></span></p>
                <p><b>SGST (6%):</b> <span>₹<%= df.format(sgst) %></span></p>
                <p><b>Total GST (12%):</b> <span>₹<%= df.format(totalGST) %></span></p>
                <p class="grand-total"><b>Grand Total:</b> <span>₹<%= df.format(grandTotal) %></span></p>
            </div>

            <div class="thankyou">
                <% if (totalItems >= 10) { %>
                    🎉 10% Bulk Discount Applied!
                <% } else if (totalItems >= 5) { %>
                    🎉 5% Bulk Discount Applied!
                <% } else { %>
                    Add 5 or more items to receive a bulk discount.
                <% } %>
            </div>

            <div class="thankyou">
                Thank you for shopping with VaraTech Electronics! 🙏
            </div>

            <div class="buttons">
                <button class="print" onclick="printInvoice()">🖨️ Print Invoice</button>
            </div>

            <div class="footer">
                This is a computer-generated invoice and does not require a signature.
            </div>
        </div>
    <% } %>
</div>
</body>
</html>