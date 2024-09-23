<%@ page import="java.sql.*, javax.servlet.http.*, javax.servlet.*" %>
<%
    String usernamew = request.getParameter("username");
    String password = request.getParameter("password");

    Connection conn = null;
    PreparedStatement stmt = null;
    ResultSet rs = null;

    try {
        // Database connection
        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/admin", "root", "root");

        String sql = "SELECT * FROM regtable WHERE username = ? AND password = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, usernamew);
        stmt.setString(2, password);
        rs = stmt.executeQuery();

        if (rs.next()) {
            // Login successful, create session
            session.setAttribute("username", usernamew);
            response.sendRedirect("home.jsp");  // Redirect to home or dashboard page
        } else {
            out.println("Invalid username or password.");
        }
    } catch (Exception e) {
        e.printStackTrace();
    } finally {
        if (rs != null) rs.close();
        if (stmt != null) stmt.close();
        if (conn != null) conn.close();
    }
%>
