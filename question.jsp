<%@ page contentType="text/html" pageEncoding="UTF-8" import="java.sql.Connection, java.sql.DriverManager, java.sql.Statement, java.sql.ResultSet, java.sql.PreparedStatement" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Insert Questions</title>
    <style>
   
        
        .main-content {
            margin-left: 250px;
            padding: 20px;            
            background-color: #ffffff;
            border-radius: 10px;
        }
        
        input, select {
            height: 35px;
            font-size: 16px;
            width: 100%;
            margin-bottom: 15px;
            padding: 5px;
            border: 1px solid #ccc;
            border-radius: 5px;
        }

        #btn-submiit {
            height: 40px;
            width: 150px;
            border-radius: 5px;
            font-size: 16px;
            background-color: #28a745;
            color: white;
            border: none;
            cursor: pointer;
        }

        #btn-submiit:hover {
            background-color: #218838;
        }

        label {
            font-size: 18px;
            font-family: sans-serif;
            font-weight: bold;
            margin-bottom: 10px;
            display: block;
        }

        h2 {
            color: #333;
        }

        .card-container {
            display: flex;
            justify-content: space-around;
            margin-top: 30px;
        }

        .card {
            background-color: #007bff;
            color: white;
            border-radius: 10px;
            padding: 20px;
            width: 250px;
            text-align: center;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        }

        .card h3 {
            font-size: 40px;
            margin: 0;
        }

        .card p {
            font-size: 18px;
            margin-top: 10px;
        }
        label{
            align-text: left;
        }
    </style>
</head>
<body>
    <jsp:include page="layout.jsp"/>
    <div class="main-content">
        <h2>Insert Question</h2>
        <hr><br>
        <center>
        <form method="POST" action="">
            <label>Category:</label>
            <select name="category_id" required>
                <option value="" disabled selected>Select Category</option>
                <%
                    Connection conn = null;
                    try {
                        Class.forName("com.mysql.cj.jdbc.Driver");
                        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/admin", "root", "root");
                        Statement stmt = conn.createStatement();
                        String sql = "SELECT id, name FROM category";
                        ResultSet rs = stmt.executeQuery(sql);

                        while (rs.next()) {
                            int categoryId = rs.getInt("id");
                            String categoryName = rs.getString("name");
                %>
                            <option value="<%= categoryId %>"><%= categoryName %></option>
                <%
                        }
                    } catch (Exception e) {
                        e.printStackTrace();
                    } finally {
                        if (conn != null) try { conn.close(); } catch (Exception e) { e.printStackTrace(); }
                    }
                %>
            </select>
            <br><br>

            <label>Question ID:</label>
            <input type="number" placeholder="Enter Question ID Must Be Unique" name="question_id" required>
            <br><br>

            <label>Question:</label>
            <input type="text" placeholder="Enter Your Question Here" name="question" required>
            <br><br>

            <label>Option 1:</label>
            <input type="text" placeholder="Enter Option 1" name="option1" required>
            <br><br>

            <label>Option 2:</label>
            <input type="text" placeholder="Enter Option 2" name="option2" required>
            <br><br>

            <label>Option 3:</label>
            <input type="text" placeholder="Enter Option 3" name="option3" required>
            <br><br>

            <label>Option 4:</label>
            <input type="text" placeholder="Enter Option 4" name="option4" required>
            <br><br>

            <label>Answer:</label>
            <input type="text" placeholder="Enter Answer" name="answer" required>
            <br><br>

            <input id="btn-submiit" type="submit" value="Insert Question">
        </form>
        </center>
        <%
            if ("POST".equalsIgnoreCase(request.getMethod())) {
                int categoryId = Integer.parseInt(request.getParameter("category_id"));
                int questionId = Integer.parseInt(request.getParameter("question_id"));
                String question = request.getParameter("question");
                String option1 = request.getParameter("option1");
                String option2 = request.getParameter("option2");
                String option3 = request.getParameter("option3");
                String option4 = request.getParameter("option4");
                String answer = request.getParameter("answer");

                try {
                    conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/admin", "root", "root");
                    String insertSQL = "INSERT INTO generaltable (QNo, Questions, option1, option2, option3, option4, answers , category_id) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
                    PreparedStatement pstmt = conn.prepareStatement(insertSQL);
                    pstmt.setInt(1, questionId);
                    pstmt.setString(2, question);
                    pstmt.setString(3, option1);
                    pstmt.setString(4, option2);
                    pstmt.setString(5, option3);
                    pstmt.setString(6, option4);
                    pstmt.setString(7, answer);
                    pstmt.setInt(8, categoryId);

                    pstmt.executeUpdate();

                    out.println("<p>Question inserted successfully!</p>");
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<p>Error inserting question: " + e.getMessage() + "</p>");
                } 
            }
        %>
    </div>
</body>
</html>
