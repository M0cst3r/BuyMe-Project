<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>

<%
ApplicationDB db = new ApplicationDB();
Connection connection = db.getConnection();

String username = request.getParameter("username");
String password = request.getParameter("password");

PreparedStatement ps = connection.prepareStatement("SELECT * FROM Users WHERE username = ? AND userPassword = ?");
ps.setString(1, username);
ps.setString(2, password);

ResultSet rs = ps.executeQuery();

if (rs.next()) {
  int loggedInUserID = rs.getInt("userID");
  String loggedInUsername = rs.getString("username");

  session.setAttribute("loggedInUserID", loggedInUserID);
  session.setAttribute("loggedInUsername", loggedInUsername);
  
  response.sendRedirect("homepage.jsp");
} else {
  PreparedStatement ps2 = connection.prepareStatement("SELECT * FROM CustomerReps WHERE customerRepUsername = ? AND customerRepPassword = ?");
  ps2.setString(1, username);
  ps2.setString(2, password);
  
  ResultSet rs2 = ps2.executeQuery();

  if (rs2.next()) {
    session.setAttribute("loggedInUserID", rs2.getInt("customerRepID"));
    session.setAttribute("loggedInUsername", rs2.getString("customerRepUsername"));
    
    response.sendRedirect("homepage.jsp");
  } else {
    session.setAttribute("loginMessage", "Nope, try again");
    response.sendRedirect("Login.jsp");
  }
}

rs.close();
ps.close();
connection.close();
%>
