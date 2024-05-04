<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="com.cs336.pkg.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter, javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.time.Instant" %>
<%@ page import="java.sql.Timestamp" %>

<%
if ("POST".equalsIgnoreCase(request.getMethod())) {
  String username = request.getParameter("username");
  String password = request.getParameter("password");

  ApplicationDB db = new ApplicationDB();
  Connection connection = db.getConnection();
  PreparedStatement ps = null;

  PreparedStatement ps05 = connection.prepareStatement("SELECT * FROM CustomerReps");

  ResultSet rs = ps05.executeQuery();
  
  while(rs.next()) {
    out.println("<div>" + rs.getString("customerRepUsername") + "</div>");
  }
  

  try {
    ps = connection.prepareStatement("INSERT INTO CustomerReps (customerRepUsername, customerRepPassword) VALUES (?, ?)");
    ps.setString(1, username);
    ps.setString(2, password);
    
    int result = ps.executeUpdate();

    if (result > 0) {
      response.sendRedirect("homepage.jsp");
      return;
    }
  } catch (Exception e) {
    e.printStackTrace();
  }
}
%>

<!DOCTYPE html>
<html>
  <head>
    <style type="text/css">
      #borderContainer {
        display: flex;
        border: 1px solid black;
        width: 300px;
        padding: 10px;
      }

      #loginContainer {
        display: flex;
        flex-direction: column;
        align-items: center;
        width: 100%;
      }

      input, button {
        width: 100%;
        margin-bottom: 10px;
      }

      button {
        background-color: lightgray;
        border: 1px solid black;
        border-radius: 3px;
      }

      legend {
        font-size: larger;
        font-weight: bold;
      }
    </style>
  </head>

  <body>
    <fieldset id="borderContainer">
      <legend>Create Customer Rep:</legend>
      <form method="post" action="<%=request.getRequestURI()%>" id="loginContainer">
        <input type="text" name="username" id="username" placeholder="Username" required>
        <input type="text" name="password" id="password" placeholder="Password" required>
        <button type="submit">Register</button>
      </form>
    </fieldset>
  </body>
</html>
