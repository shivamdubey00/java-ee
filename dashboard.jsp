<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
    </style>
</head>
<body>

<jsp:include page="layout.jsp" />
<jsp:include page="databasedetails.jsp"/>

<%
    String url = "jdbc:mysql://localhost:3306/admin";  // Replace with your database name
    String dbUsername = "root";  // Replace with your database username
    String dbPassword = "root";  // Replace with your database password
    String name_admin =""; // Initialize the variable

    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url, dbUsername, dbPassword);
        Statement stmt = conn.createStatement();
        String sql = "SELECT * FROM regtable";  // Replace with your table name
        ResultSet rs = stmt.executeQuery(sql);

        // Check if there are results and process
        if (rs.next()) { // Check if there's at least one record
            name_admin = rs.getString("username"); 
        } else {
            name_admin = "No admin found."; // Default message if no results
        }
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        out.println("<p>Error connecting to database: " + e.getMessage() + "</p>");
    }
%>

<div class="main-content">
    <h1> Howdy <%= name_admin %>!!!</h1> <!-- Output the variable safely -->
    <p>Your profile information will be displayed here.</p>
</div>

</body>
</html>
