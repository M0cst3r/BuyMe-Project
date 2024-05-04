<%@ page import="java.sql.*" %>
<%@ page import="com.cs336.pkg.ApplicationDB" %>
<%
String userID = request.getParameter("userID");
ApplicationDB db = new ApplicationDB();
Connection con = null;
PreparedStatement ps = null;
ResultSet rs = null;

try {
    con = db.getConnection();

    // Prepare SQL to join Items and Bids tables on itemID, filter by userID, and group by itemID
    String sql = "SELECT Items.itemID, Items.itemName, MAX(Bids.bidAmount) AS maxBidAmount FROM Items " +
                 "JOIN Bids ON Items.itemID = Bids.itemID " +
                 "WHERE Bids.userID = ? " +
                 "GROUP BY Items.itemID, Items.itemName";

    ps = con.prepareStatement(sql);
    ps.setInt(1, Integer.parseInt(userID));
    rs = ps.executeQuery();

    out.println("<div>Items placed bids on:</div>");
    while (rs.next()) {
        int itemID = rs.getInt("itemID");
        String itemName = rs.getString("itemName");
        double maxBidAmount = rs.getDouble("maxBidAmount");
        out.println("<p>Item ID: " + itemID + ", Item Name: " + itemName + ", Max Bid Amount: $" + maxBidAmount + "</p>");
    }

    out.println("<div>Items submitted for auction:</div>");
    PreparedStatement ps2 = con.prepareStatement("SELECT itemName FROM Items WHERE Items.sellerID = ?");
    ps2.setInt(1, Integer.parseInt(userID));
    ResultSet rs2 = ps2.executeQuery();

    while (rs2.next()) {
        out.println("<p>" + rs2.getString("itemName") + "</p>");
    }
} catch (SQLException e) {
    out.println("SQL Exception: " + e.getMessage());
} finally {
    try {
        if (rs != null) rs.close();
        if (ps != null) ps.close();
        if (con != null) con.close();
    } catch (SQLException ex) {
        out.println("SQL Exception on close: " + ex.getMessage());
    }
}
%>
