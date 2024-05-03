<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" import="mypackage.*" %>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.time.LocalDateTime, java.time.format.DateTimeFormatter, javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.time.Instant" %>
<%@ page import="java.sql.Timestamp" %>

<%
try {
  ApplicationDB db = new ApplicationDB();
  Connection connection = db.getConnection();

  int userID = (int) session.getAttribute("loggedInUserID");
  String username = (String) session.getAttribute("loggedInUsername");

  String itemName = request.getParameter("itemName");
  int itemID = Integer.parseInt(request.getParameter("itemID"));

  double bidAmount = Double.parseDouble(request.getParameter("bidAmount"));
  double bidIncrement = Double.parseDouble(request.getParameter("bidIncrement"));
  boolean autoBidEnabled = request.getParameter("autoBidEnabled") != null && request.getParameter("autoBidEnabled").equals("true");
  double maxBidLimit = autoBidEnabled ? Double.parseDouble(request.getParameter("maxBidAmount")) : 0;

  // Initial bid submission
  PreparedStatement ps1 = connection.prepareStatement("INSERT INTO Bids (userID, itemID, bidAmount, bidTime, maxBidLimit, autoBidEnabled) VALUES (?, ?, ?, ?, ?, ?)");
  ps1.setInt(1, userID);
  ps1.setInt(2, itemID);
  ps1.setDouble(3, bidAmount);
  ps1.setTimestamp(4, Timestamp.from(Instant.now()));
  ps1.setDouble(5, maxBidLimit);
  ps1.setBoolean(6, autoBidEnabled);
  ps1.executeUpdate();

  boolean bidsUpdated;
  do {
    bidsUpdated = false;

    PreparedStatement ps2 = connection.prepareStatement("SELECT userID, MAX(bidAmount) AS highestBid, maxBidLimit FROM Bids WHERE itemID = ? AND autoBidEnabled = true GROUP BY userID, maxBidLimit ORDER BY highestBid DESC");
    ps2.setInt(1, itemID);
    ResultSet rs2 = ps2.executeQuery();

    while (rs2.next()) {
      int userId = rs2.getInt("userID");
      double highestBid = rs2.getDouble("highestBid");
      double maxBidLim = rs2.getDouble("maxBidLimit");

      // Check if the user can place another bid
      if (highestBid + bidIncrement <= maxBidLim) {
        PreparedStatement ps3 = connection.prepareStatement("SELECT MAX(bidAmount) AS maxBid FROM Bids WHERE itemID = ? AND userID != ?");
        ps3.setInt(1, itemID);
        ps3.setInt(2, userId);
        ResultSet rs3 = ps3.executeQuery();

        if (rs3.next()) {
          if (highestBid < rs3.getDouble("maxBid")) {
            double newBidAmount = rs3.getDouble("maxBid") + bidIncrement;

            if (newBidAmount <= maxBidLim) {
              PreparedStatement ps4 = connection.prepareStatement("INSERT INTO Bids (userID, itemID, bidAmount, bidTime, maxBidLimit, autoBidEnabled) VALUES (?, ?, ?, ?, ?, true)");
              ps4.setInt(1, userId);
              ps4.setInt(2, itemID);
              ps4.setDouble(3, newBidAmount);
    
              ps4.setTimestamp(4, Timestamp.from(Instant.now()));
              ps4.setDouble(5, maxBidLim);
              ps4.executeUpdate();

              bidsUpdated = true;

              PreparedStatement ps5 = connection.prepareStatement("INSERT INTO Alerts (userID, alertMessage) VALUES (?, ?)");
              ps5.setInt(1, userId);
              ps5.setString(2, "Your automatic bid has been increased to $" + String.format("%.2f", newBidAmount) + " for: " + itemName + ".");
              ps5.executeUpdate();
            } else {
              PreparedStatement ps6 = connection.prepareStatement("INSERT INTO Alerts (userID, alertMessage) VALUES (?, ?)");
              ps6.setInt(1, userId);
              ps6.setString(2, "Unable to automatically bid on item: " + itemName + ", limit reached. Please place another bid to stay in the auction.");
              ps6.executeUpdate();
            }
          }
        }
      }
    }
  } while (bidsUpdated);

  session.setAttribute("submitBidMessage", "Bid successfully submitted on " + itemName);
  response.sendRedirect("homepage.jsp");
  connection.close();
} catch (Exception e) {
  out.println("Error processing bids: " + e.getMessage());
}
%>
