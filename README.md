## 🌐 Live Application
# VaraTech - JSP E-Commerce Billing System

A dynamic, session-secured web-based billing and invoice generation system built using Java Server Pages (JSP) and deployed on Apache Tomcat.

## Features
* **Secure Admin Authentication**: Protects the application with session-based login credentials.
* **Interactive Billing Portal**: Browse product catalogs, adjust item quantities, and automatically calculate subtotals, bulk discounts (5% to 10%), and 12% GST (CGST/SGST).
* **Live Invoice Generation**: Instant calculation and rendering of professional itemized tax invoices with print capabilities.
* **Session Management & Logout**: Secure session destruction and a clean logout confirmation portal.

## Default Admin Credentials
* **Username**: `Vara'
* **Password**: `varatech`

## Technology Stack
* **Frontend**: HTML5, CSS3, JavaScript
* **Backend**: Java Server Pages (JSP), Servlets
* **Server**: Apache Tomcat 10.1.59

## Project File Structure
* `Login.jsp` - Admin authentication entry point
* `admin.jsp` - Secure post-login control panel dashboard
* `index.jsp` - Interactive product selection and billing calculation interface
* `logout.jsp` - Session termination and exit confirmation portal

## Setup & Deployment Instructions
1. Download and configure **Apache Tomcat 10.1.59**.
2. Create a folder named `Billing` inside your Tomcat `webapps/` directory (`tomcat/webapps/Billing/`).
3. Place all project files (`Login.jsp`, `admin.jsp`, `index.jsp`, `logout.jsp`) directly inside the `Billing` folder.
4. Start your Apache Tomcat server.
5. Open your web browser and access the application via the local links provided above.

   
- [🔐 Login Page](https://varatech-billing-system.onrender.com/Login.jsp)
- [📊 Admin Dashboard](https://varatech-billing-system.onrender.com/admin.jsp)
- [🧾 Billing System](https://varatech-billing-system.onrender.com/index.jsp)
-  [🚪 Logout Page](https://varatech-billing-system.onrender.com/logout.jsp)

-  ## 🌐 Local Application

- [🔐 Login Page](http://localhost:8080/Billing/Login.jsp)
- [📊 Admin Dashboard](http://localhost:8080/Billing/admin.jsp)
- [🧾 Billing System](http://localhost:8080/Billing/index.jsp)
- [🚪 Logout Page](http://localhost:8080/Billing/logout.jsp)

> These links work when Apache Tomcat is running locally.

## 🚀 Online Application

[🌐 Open VaraTech Billing System](https://varatech-billing-system.onrender.com)

> The online version requires the Render deployment to be running correctly.
