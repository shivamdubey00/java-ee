<%-- 
    Document   : add_category
    Created on : Sep 23, 2024, 10:10:52 PM
    Author     : SHIVAM DUBEY
--%>
<%@ page import="java.sql.*" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Add Category</title>
        <style>
             .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .header {
            text-align: center;
            padding: 20px;
            background-color:  black;
            color: #fff;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 50px;
            border-radius: 5px;
        }
            
            
            
            </style>
    </head>
    
    <body>
        <jsp:include page="layout.jsp"/> 
        <div class="main-content">
            <div class="header">
        Add Category
            </div>
            <center>
        <form method="post" action="">
            <label for="categoryId">Category ID:</label>
            <input type="number" id="categoryId" name="categoryId" placeholder="Enter Category ID" required>
            <br><br>
            
            <label for="categoryName">Enter The Category:</label>
            <input type="text" id="categoryName" name="categoryName" placeholder="Enter Category Name" required>
            <br><br>
            
            <input type="submit" value="Submit">
        </form>
            </center>
        <jsp:include page="databasedetails.jsp"/>
        
        <%
            // Database connection details
            String url = "jdbc:mysql://localhost:3306/admin";  // Replace with your database name
            String dbUsername = "root";  // Replace with your database username
            String dbPassword = "root";  // Replace with your database password
            
            Connection conn = null; // Declare connection
            PreparedStatement pstmt = null; // Declare prepared statement
            
            // Process the form submission
            if (request.getMethod().equalsIgnoreCase("POST")) {
                String categoryId = request.getParameter("categoryId");
                String categoryName = request.getParameter("categoryName");

                try {
                    Class.forName("com.mysql.cj.jdbc.Driver");
                    conn = DriverManager.getConnection(url, dbUsername, dbPassword);
                    
                    // Insert new category into the table
                    String sql = "INSERT INTO category (id, name) VALUES (?, ?)";
                    pstmt = conn.prepareStatement(sql);
                    pstmt.setInt(1, Integer.parseInt(categoryId)); // Set the category ID
                    pstmt.setString(2, categoryName); // Set the category name
                    
                    int rowsAffected = pstmt.executeUpdate();
                    if (rowsAffected > 0) {
                        out.println("<p>Category added successfully!</p>");
                    } else {
                        out.println("<p>Error adding category!</p>");
                    }
                    
                } catch (SQLException | ClassNotFoundException e) {
                    e.printStackTrace();
                    out.println("<p>Error: " + e.getMessage() + "</p>");
                } finally {
                    // Close resources
                    if (pstmt != null) try { pstmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                    if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                }
            }
        %>
        </div>
    </body>
</html>
