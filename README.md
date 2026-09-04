Project Title: VaraTech Electronics - Dynamic Online Billing System

Tech Stack: Java Server Pages (JSP), Apache Tomcat, MySQL JDBC, HTML/CSS, JavaScript, Git/GitHub

GitHub Repository: [https://github.com/sreevaraprasad16/VaraTech-Billing-System](https://github.com/sreevaraprasad16/VaraTech-Billing-System)

Admin Login Credentials:

Username: admin

Password: varatech

Application Access URLs:

Login Page: http://localhost:8080/Billing/Login.jsp

Main Billing System: http://localhost:8080/Billing/index.jsp

Admin Sales History Dashboard: http://localhost:8080/Billing/admin.jsp
# 🛒 VaraTech Electronics - Dynamic Online Billing System

A full-stack web-based billing and invoice generation system developed as part of MCA coursework. The application features dynamic price fetching, automated bulk discounts, tax calculations, live sales reporting, and admin authentication backed by a relational database.

## 🚀 Key Features

* **Dynamic Product Pricing**: Connects to a MySQL database to fetch live product catalogs and pricing.
* **Automated Discounts & Taxes**: Automatically calculates multi-tier bulk discounts and splits taxes into CGST and SGST.
* **Invoice Generation**: Generates clean, formatted invoices complete with custom invoice numbers, timestamps, and print capabilities.
* **Secure Admin Dashboard**: Restricted sales history panel protected by an authentication login session.
* **Sales Tracking**: Automatically logs every completed transaction into a MySQL database for administrative tracking.
* **Version Control**: Fully managed via Git and hosted on GitHub.

## 🛠️ Technologies Used

* **Frontend**: HTML5, CSS3, JavaScript (AJAX/DOM search filtering)
* **Backend**: Java Server Pages (JSP), Servlets
* **Database**: MySQL, JDBC (Java Database Connectivity)
* **Server**: Apache Tomcat (v10.1)
* **Version Control**: Git & GitHub

## 📂 Project Structure

* `Login.jsp` - Secure authentication portal for administrators.
* `admin.jsp` - Administrative dashboard displaying live sales history from the database.
* `index.jsp` - Main interactive billing page and invoice receipt generator.
* `logout.jsp` - Session termination and security redirect.
* `varatech_db.sql` - Complete database backup file containing product inventories and sales schemas.

## 🔐 Default Admin Credentials

* **Username**: `admin`
* **Password**: `varatech`

## ⚙️ Local Deployment Guide

If you want to run or evaluate this project locally, follow these steps:

1. **Clone or Download**: Download this repository as a ZIP file or clone it using Git.
2. **Setup Server**: Place the project folder inside your Apache Tomcat `webapps` directory.
3. **Configure Database**: 
   - Open MySQL (via phpMyAdmin or command line).
   - Create a database named `varatech_db`.
   - Import the included `varatech_db.sql` file to populate tables and initial product data.
4. **Run Application**: 
   - Start your Apache Tomcat server.
   - Open your browser and navigate to: `http://localhost:8080/VaraTech-Billing-System/Login.jsp`
