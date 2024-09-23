<%-- 
    Document   : myname
    Created on : Sep 24, 2024, 12:22:27 AM
    Author     : SHIVAM DUBEY
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <%
             String url = "jdbc:mysql://localhost:3306/admin";  // Replace with your database name
    String dbUsername = "root";  // Replace with your database username
    String dbPassword = "root";  // Replace with your database password
    String name_admin = ""; 
    String user_email = "";
    String user_password = "";
    Connection conn = null; // Declare connection outside try block
             
             try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);
        Statement stmt = conn.createStatement();
        String sql = "SELECT * FROM regtable";  // Replace with your table name
        ResultSet rs = stmt.executeQuery(sql);

        // Check if there are results and process
        if (rs.next()) {
            name_admin = rs.getString("username"); 
            user_email = rs.getString("useremail");
            user_password = rs.getString("password");
        } else {
            name_admin = "No admin found."; // Default message if no results
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>Error connecting to database: " + e.getMessage() + "</p>");
    }
            
            %>
        <%= name_admin%>
        
    </body>
</html>
