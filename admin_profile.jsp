<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.SQLException, java.sql.PreparedStatement"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Profile</title>
    <style>
        /* Your existing styles here... */
        body {
            margin: 0;
            font-family: Arial, sans-serif;
            background-color: #f4f4f4; /* Light background */
        }
        .main-content {
            margin-left: 250px;
            padding: 20px;
        }
        .header {
            border-radius: 5px;
            text-align: center;
            padding: 20px;
            background-color: darkcyan;
            color: #fff;
            font-size: 24px;
            font-weight: bold;
            margin-bottom: 50px;
        }
        .strip {
            margin-bottom: 20px;
            text-align: center; /* Centered text */
        }
        .update-form {
            display: none; /* Hidden by default */
            margin-top: 20px;
            background: #fff; /* White background for form */
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }
        .details_edit {
            padding-left: 34%;
            text-align: center; /* Center content */
            background: #ffffff; /* White background */
            padding: 20px;
            border-radius: 8px; /* Rounded corners */
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1); /* Subtle shadow */
        }
        .update-details-form input {
            font-size: 18px;
            border-radius: 5px;
            border: 1px solid #ccc; /* Light border */
            padding: 10px; /* Padding inside input */
            width: 100%; /* Full width */
            margin: 10px 0; /* Space between inputs */
        }
        #btn-update {
            border: none;
            border-radius: 90%;
            background-color: transparent; /* Transparent background */
            cursor: pointer; /* Pointer cursor */
        }
        #btn-update img {
            transition: transform 0.3s; /* Smooth hover effect */
        }
        #btn-update:hover img {
            transform: scale(1.1); /* Slightly enlarge on hover */
        }
        h2 {
            color: #333; /* Darker text color */
        }
        h3 {
            color: #555; /* Medium color for subheading */
        }
        .profile-img {
            border-radius: 50%; /* Circular image */
            margin-bottom: 15px; /* Space below the image */
        }
    </style>
    <script>
        function toggleUpdateForm() {
            var form = document.getElementById('updateForm');
            form.style.display = (form.style.display === 'none' || form.style.display === '') ? 'block' : 'none';
        }
        function togglePasswordUpdate() {
            var form = document.getElementById('updatePasswordForm');
            form.style.display = (form.style.display === 'none' || form.style.display === '') ? 'block' : 'none';
        }
        function togglePasswordVisibility() {
            var passwordField = document.getElementById('passwordDisplay');
            var passwordInput = document.getElementById('passwordInput');
            var checkbox = document.getElementById('showPassword');
            if (checkbox.checked) {
                passwordField.textContent = passwordInput.value; // Show password
            } else {
                passwordField.textContent = '**********'; // Hide password
            }
        }
    </script>
</head>
<body>

<jsp:include page="layout.jsp" />
<jsp:include page="databasedetails.jsp"/>

<%
    if (session == null || session.getAttribute("username") == null) {
        // If session is not available or user is not logged in, redirect to login
        response.sendRedirect("login.jsp");
        return;
    }

    String username = (String) session.getAttribute("username"); // Get the logged-in username
    String url = "jdbc:mysql://localhost:3306/admin";  // Replace with your database name
    String dbUsername = "root";  // Replace with your database username
    String dbPassword = "root";  // Replace with your database password
    String name_admin = ""; 
    String user_email = "";
    String user_password = "";
    Connection conn = null; // Declare connection outside try block

    // Fetch current admin details based on session username
    try {
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url, dbUsername, dbPassword);
        String sql = "SELECT * FROM regtable WHERE username = ?";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, username); // Use the session username for query
        ResultSet rs = stmt.executeQuery();

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

    // Update admin details
    if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("name") != null) {
        String newName = request.getParameter("name");
        String newEmail = request.getParameter("email");
        
        try {
            String updateSql = "UPDATE regtable SET username=?, useremail=? WHERE username=?";
            PreparedStatement pstmt = conn.prepareStatement(updateSql);
            pstmt.setString(1, newName);
            pstmt.setString(2, newEmail);
            pstmt.setString(3, name_admin); // Update based on existing username
            pstmt.executeUpdate();
            name_admin = newName; // Update the displayed name
            user_email = newEmail; // Update the displayed email
            out.println("<p>Profile updated successfully!</p>");
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("<p>Error updating profile: " + e.getMessage() + "</p>");
        }
    }

    // Update password
    if (request.getMethod().equalsIgnoreCase("POST") && request.getParameter("password") != null) {
        String newPassword = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        
        if (newPassword.equals(confirmPassword)) {
            try {
                String updatePasswordSql = "UPDATE regtable SET password=? WHERE username=?";
                PreparedStatement pstmt = conn.prepareStatement(updatePasswordSql);
                pstmt.setString(1, newPassword);
                pstmt.setString(2, name_admin); // Update based on existing username
                pstmt.executeUpdate();
                out.println("<p>Password updated successfully!</p>");
            } catch (SQLException e) {
                e.printStackTrace();
            }
        } else {
            out.println("<p>Passwords do not match.</p>");
        }
    }
%>

<div class="main-content">
    <div class="header">
        View Profile
    </div><hr><br>
    <center>
        <img src="https://img.freepik.com/free-vector/blue-circle-with-white-user_78370-4707.jpg" class="profile-img" height="140px" width="140px">
    </center>
    <div class="details_edit">
        <button id="btn-update" onclick="toggleUpdateForm()"> 
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYply4AnrjVcPJRRwyjUGENn_h8I61NBNAHA&s" height="40px" width="40px">
        </button>
        <h2>Name: <%= name_admin %></h2>
        <h2>Email ID: <%= user_email %></h2>
        <h2>Password: <span id="passwordDisplay">**********</span></h2> <!-- Hide the password -->
        <input type="hidden" id="passwordInput" value="<%= user_password %>"> <!-- Hidden password input -->
        <label>
            <input type="checkbox" id="showPassword" onclick="togglePasswordVisibility()"> Show Password
        </label>
    </div>
    <br><br>
    <!-- Update Form -->
    <div id="updateForm" class="update-form">
        <h3>Update Profile</h3>
        <form method="POST" action="" class="update-details-form">
            <input type="text" name="name" value="<%= name_admin %>" placeholder="Enter your name">
            <input type="email" name="email" value="<%= user_email %>" placeholder="Enter your email">
            <input type="submit" value="Update">
        </form>
    </div>

    <!-- Password Update Form -->
    <br><br>
    <h3>Change Password</h3>
    <button id="btn-update" onclick="togglePasswordUpdate()">
        <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYply4AnrjVcPJRRwyjUGENn_h8I61NBNAHA&s" height="40px" width="40px">
    </button>
    <div id="updatePasswordForm" class="update-form">
        <form method="POST" action="">
            <input type="password" name="password" placeholder="New Password">
            <input type="password" name="confirmPassword" placeholder="Confirm Password">
            <input type="submit" value="Update Password">
        </form>
    </div>
</div>

</body>
</html>
