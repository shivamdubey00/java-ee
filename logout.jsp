<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%
    // Check if the session exists
    if (session != null) {
        session.invalidate();  // Destroy the session
    }
    response.sendRedirect("login.jsp");  // Redirect to login page
%>
