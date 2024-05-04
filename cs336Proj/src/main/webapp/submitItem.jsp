<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>
<%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>

<%
ApplicationDB db = new ApplicationDB();
Connection connection = db.getConnection();

String itemName = request.getParameter("itemName");
String itemCategory = request.getParameter("itemCategory");

String reservePriceStr = request.getParameter("reservePrice");
double reservePrice = 0.0;

if (reservePriceStr != null && !reservePriceStr.isEmpty()) {
  try {
    reservePrice = Double.parseDouble(reservePriceStr);
  } catch (NumberFormatException exception) {
    reservePrice = 0.0;
  }
} else {
  reservePrice = 0.0;
}

Double bidIncrement = Double.parseDouble(request.getParameter("bidIncrement"));

String closeDateStr = request.getParameter("closeDate").concat(" 23:59:59");
DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
LocalDateTime closeDateDT = LocalDateTime.parse(closeDateStr, formatter);
Timestamp closeDate = Timestamp.valueOf(closeDateDT);

int sellerID = (int) session.getAttribute("loggedInUserID");

PreparedStatement ps = connection.prepareStatement("INSERT INTO Items (itemName, itemCategory, reservePrice, bidIncrement, closeDate, sellerID) VALUES (?, ?, ?, ?, ?, ?)");
ps.setString(1, itemName);
ps.setString(2, itemCategory);
ps.setDouble(3, reservePrice);
ps.setDouble(4, bidIncrement);
ps.setTimestamp(5, closeDate);
ps.setInt(6, sellerID);

ps.executeUpdate();

ps.close();
connection.close();

response.sendRedirect("homepage.jsp");
%>
