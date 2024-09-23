<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%
    // Get the session, but don't create a new one if it doesn't exist
    HttpSession sessions = request.getSession(false); 
    if (sessions == null || sessions.getAttribute("username") == null) {
        // Redirect to login page if session does not exist or user is not logged in
        response.sendRedirect("login.jsp");
    }
%>

<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard</title>
    <style>
        body {
            margin: 0;
            font-family: Arial, sans-serif;
        }
        .sidebar1 {
            width: 250px;
            height: 100vh;
            position: fixed;
            background-color: black;
            color: white;
            padding: 20px;
            box-sizing: border-box;
        }
        .sidebar1 a {
            color: white;
            display: block;
            padding: 10px;
            text-decoration: none;
        }
        .sidebar1 a:hover {
            background-color: #575757;
        }
        .main-content1 {
            margin-left: 250px;
            padding: 20px;
            height: 100vh;
            overflow: auto;
        }
        #h1-mai-lay {
            color: white;
        }
        
    </style>
</head>
<body>

<div class="sidebar1">
    <div class="div-he-ss">
        <center> Howdy, <strong><jsp:include page="myname.jsp" /></strong></center>
    </div><hr>
    <br>
    <h2 id="h1-mai-lay">Dashboard</h2>
    <a href="home.jsp">Home</a>
    <a href="admin_profile.jsp">Profile</a>
    <a href="add_category.jsp">Add Category</a>
    <a href="question.jsp">Add Questions</a>
    <a href="logout.jsp">Logout</a>
</div>

</body>
</html>
