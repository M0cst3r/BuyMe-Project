<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<% try {
  ApplicationDB db = new ApplicationDB();
  Connection connection = db.getConnection();
  
  int userID = (int) session.getAttribute("loggedInUserID");
  
  PreparedStatement ps = connection.prepareStatement("SELECT DISTINCT userID, alertMessage FROM Alerts WHERE userID = ?");
  ps.setInt(1, userID);

  ResultSet rs = ps.executeQuery();

  while (rs.next())
    out.println("<div style='color: red;'>" + rs.getString("alertMessage") + "</div>");

  connection.close();
} catch (SQLException exception) {
  exception.printStackTrace();
}
%>
