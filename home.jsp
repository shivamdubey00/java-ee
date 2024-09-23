<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style>
        
        
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .container {
            width: 80%;
            margin: auto;
            padding-top: 50px;
        }
        .header {
            text-align: center;
            padding: 20px;
            background-color: #343a40;
            color: #fff;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 50px;
        }
        .card-container {
            display: flex;
            justify-content: space-around;
            margin-top: 20px;
        }
        .card {
            background-color: #fff;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 30%;
            padding: 20px;
            text-align: center;
        }
        .card h3 {
            font-size: 36px;
            margin: 0;
        }
        .card p {
            font-size: 20px;
            color: #777;
        }
        .card-icon {
            width: 80px;
            margin-bottom: 20px;
        }
        footer {
            text-align: center;
            padding: 20px;
            background-color: #343a40;
            color: #fff;
            margin-top: 50px;
        }
    </style>
</head>
<body>
    <jsp:include page="layout.jsp"/>
   <div class="main-content">

<div class="header">
    Admin Dashboard
</div>

<div class="container">
    <div class="card-container">
        <!-- Registered Users -->
        <div class="card">
            <img class="card-icon" src="https://img.icons8.com/bubbles/100/000000/user.png" alt="Users Icon">
            <h3>
                <%
                    Connection conn = null;
                    int userCount = 0;
                    int questionCount = 0;
                    int categoryCount = 0;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/admin", "root", "root");
                        Statement stmt = conn.createStatement();

                        // Query for user count
                        ResultSet rsUsers = stmt.executeQuery("SELECT COUNT(*) AS userCount FROM regtable");
                        if (rsUsers.next()) {
                            userCount = rsUsers.getInt("userCount");
                        }
                        out.print(userCount);
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
                    }
                %>
            </h3>
            <p>Registered Users</p>
        </div>

        <!-- Categories -->
        <div class="card">
            <img class="card-icon" src="https://img.icons8.com/color/100/000000/tags.png" alt="Categories Icon">
            <h3>
                <%
                    try {
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/admin", "root", "root");
                        Statement stmt = conn.createStatement();

                        // Query for category count
                        ResultSet rsCategories = stmt.executeQuery("SELECT COUNT(*) AS categoryCount FROM category");
                        if (rsCategories.next()) {
                            categoryCount = rsCategories.getInt("categoryCount");
                        }
                        out.print(categoryCount);
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
                    }
                %>
            </h3>
            <p>Total Categories</p>
        </div>

        <!-- Questions -->
        <div class="card">
            <img class="card-icon" src="https://img.icons8.com/bubbles/100/000000/question-mark.png" alt="Questions Icon">
            <h3>
                <%
                    try {
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/admin", "root", "root");
                        Statement stmt = conn.createStatement();

                        // Query for question count
                        ResultSet rsQuestions = stmt.executeQuery("SELECT COUNT(*) AS questionCount FROM generaltable");
                        if (rsQuestions.next()) {
                            questionCount = rsQuestions.getInt("questionCount");
                        }
                        out.print(questionCount);
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
                    }
                %>
            </h3>
            <p>Total Questions</p>
        </div>
    </div>
</div>
   </div>
            <br><br> <br><br><br> <br><br><br> 


</body>
</html>
