<%-- 
    Document   : databasedetails
    Created on : Sep 23, 2024, 7:12:48 PM
    Author     : SHIVAM DUBEY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException"%>
<%
    String url = "jdbc:mysql://localhost:3306/admin";  // Replace with your database name
    String dbUsername = "root";  // Replace with your database username
    String dbPassword = "root";  // Replace with your database password
    String name_admin = ""; 
    String user_email = "";
    String user_password = "";
    Connection conn = null; // Declare connection outside try block



%>