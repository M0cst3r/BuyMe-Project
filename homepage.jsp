<%@ page import="mypackage.ApplicationDB" %>
<%@ page import="mypackage.Item" %>
<%@ page import="mypackage.Bid" %>
<%@ page import="java.io.*,java.util.*,java.sql.*" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<%@ page import="java.time.Instant" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.util.*" %>

<%
List<Item> allItems = new ArrayList<Item>();

String[] itemCategories = {"Art", "Automotive", "Books", "Clothing", "Electronics", "Jewelry", "Music", "Sports", "Toys", "Accessories", "Furniture", "Kitchen"};
String[] criteriaToSortItemsBy = {"Time: ending soonest", "Time: newly listed", "Price: lowest first", "Price: highest first", "Popularity"};

String searchItemsBy = request.getParameter("searchItemsBy");
String filterItemsBy = request.getParameter("filterItemsBy");
String sortItemsBy = request.getParameter("sortItemsBy");

String sql = "SELECT Items.*, COALESCE(MAX(Bids.bidAmount), 0) AS maxBidAmount, COUNT(Bids.itemID) AS Popularity FROM Items LEFT JOIN Bids ON Items.itemID = Bids.itemID ";

if (filterItemsBy != null && !filterItemsBy.isEmpty()) {
  sql += "WHERE Items.itemCategory = ? ";
} else {
  sql += "WHERE 1=1 ";
}

if (searchItemsBy != null && !searchItemsBy.isEmpty()) {
  sql += "AND Items.itemName LIKE ? ";
}

sql += "GROUP BY Items.itemID, Items.itemName, Items.itemCategory, Items.reservePrice, Items.bidIncrement, Items.openDate, Items.closeDate, Items.sellerID ";

if (sortItemsBy != null) {
  switch (sortItemsBy) {
    case "Time: ending soonest":
      sql += "ORDER BY Items.closeDate ASC ";
      break;
    case "Time: newly listed":
      sql += "ORDER BY Items.openDate DESC ";
      break;
    case "Price: lowest first":
      sql += "ORDER BY maxBidAmount ASC ";
      break;
    case "Price: highest first":
      sql += "ORDER BY maxBidAmount DESC ";
      break;
    case "Popularity":
      sql += " ORDER BY Popularity DESC ";
      break;
    default:
      sql += " ORDER BY Items.itemID "; // default
      break;
  }
}

ApplicationDB db = new ApplicationDB();
Connection connection = db.getConnection();

PreparedStatement ps1 = null;

try {
  ps1 = connection.prepareStatement(sql);
} catch (SQLException exception) {
  exception.printStackTrace();
}

int index = 1;
if (filterItemsBy != null && !filterItemsBy.isEmpty()) {
  ps1.setString(index++, filterItemsBy);
}

if (searchItemsBy != null && !searchItemsBy.isEmpty()) {
  ps1.setString(index++, "%" + searchItemsBy + "%");
}

ResultSet rs1 = ps1.executeQuery();

while (rs1.next()) {
  int itemID = rs1.getInt("itemID");
  String itemName = rs1.getString("itemName");
  String itemCategory = rs1.getString("itemCategory");
  
  double itemReservePrice = rs1.getDouble("reservePrice");
  double itemBidIncrement = rs1.getDouble("bidIncrement");
  
  Timestamp auctionOpenDate = rs1.getTimestamp("openDate");
  Timestamp auctionCloseDate = rs1.getTimestamp("closeDate");

  int sellerID = rs1.getInt("sellerID");

  PreparedStatement ps2 = null;

  try {
    ps2 = connection.prepareStatement("SELECT username FROM Users WHERE userID = ?");
    ps2.setInt(1, sellerID);
  } catch (SQLException exception) {
    exception.printStackTrace();
  }
  
  String sellerUsername = "";

  ResultSet rs2 = ps2.executeQuery();

  if (rs2.next()) {
    sellerUsername = rs2.getString("username");
  }
  
  rs2.close();
  ps2.close();

  List<Bid> bids = new ArrayList<Bid>();

  PreparedStatement ps3 = null;
  
  try {
    ps3 = connection.prepareStatement("SELECT * FROM Bids WHERE itemID = ? ORDER BY bidAmount DESC");
    ps3.setInt(1, itemID);
  } catch (SQLException exception) {
    exception.printStackTrace();
  }
  
  ResultSet rs3 = ps3.executeQuery();

  while (rs3.next()) {
    int bidID = rs3.getInt("bidID");
    double bidAmount = rs3.getDouble("bidAmount");
    int bidderID = rs3.getInt("userID");

    PreparedStatement ps4 = null;

    try {
      ps4 = connection.prepareStatement("SELECT username FROM Users WHERE userID = ?");
      ps4.setInt(1, bidderID);
    } catch (SQLException exception) {
      exception.printStackTrace();
    }
    
    String bidderUsername = "";
    
    ResultSet rs4 = ps4.executeQuery();

    if (rs4.next()) {
      bidderUsername = rs4.getString("username");
    }
    
    rs4.close();
    ps4.close();

    Timestamp bidTimestamp = rs3.getTimestamp("bidTime");
    double autoBiddingLimit = rs3.getDouble("maxBidLimit");
    boolean autoBiddingEnabled = rs3.getBoolean("autoBidEnabled");

    Bid bid = new Bid(bidID, bidAmount, bidTimestamp, autoBiddingEnabled, autoBiddingLimit, bidderID, bidderUsername);
    bids.add(bid);
  }

  rs3.close();
  ps3.close();

  Item item = new Item(itemID, itemName, itemCategory, bids, itemReservePrice, itemBidIncrement, auctionOpenDate, auctionCloseDate, sellerID, sellerUsername);
  allItems.add(item);
}

rs1.close();
ps1.close();
%>

<html>
  <head>
    <style type="text/css">
      body {
        display: flex;
        /* justify-content: space-around; */
        margin: 0px;
        padding: 15px;
      }

      #auctionOffItemForm {
        display: grid;
        grid-template-columns: max-content max-content;
        width: min-content;
        gap: 5px;
      }

      button {
        background-color: #cccccc;
        border: 1px solid black;
        border-radius: 3px;
      }

      .column {
        flex: 1;
        display: flex;
        flex-direction: column;
        height: 100%;
      }

      .itemsContainer {
        flex: 1;
        overflow: scroll;
        background-color: lightgray;
        align-items: center;
        overflow-x: hidden;
      }

      .itemContainer {
        display: flex;
        justify-content: space-between;
        /* width: 100%; */

        margin: 20px 2%;
      }

      .questionsContainer {
        flex: 1;
        overflow: scroll;
        align-items: center;
        overflow-x: hidden;
      }

      .itemContainerColumn {
        /* flex: 1; */
        /* border-bottom: 1px solid black;
        border-top: 1px solid black; */
        /* border: 1px solid black; */
        background-color: white;
        box-sizing: border-box;
        overflow: auto;
        padding: 10px;
        width: 50%;
        height: 30vh;
      }

      .itemContainerRow {
        display: flex;
        justify-content: space-between;
        border-bottom: 1px solid black;
        align-items: center;
        padding: 5px 0;
      }

      .ftable {
        table-layout: fixed;
        border-collapse: collapse;
        width: 100%;
      }

      td, th {
        text-align: left;
        padding: 3px 2px;
      }

      th {
        background-color: #90cce0;
      }

      tr {
        border-bottom: 3px solid white;
        background-color: #add8e6;
      }
    </style>

    <script>
      function toggleMaxBidAmount(checkbox) {
        var itemID = checkbox.id.split('-')[1];
        var maxBidLabel = document.querySelector('#maxBidContainer-' + itemID + ' > label');
        var input = document.getElementById('maxBidAmount-' + itemID);

        if (checkbox.checked) {
          input.disabled = false;
          maxBidLabel.style.color = "black";
        } else {
          input.disabled = true;
          maxBidLabel.style.color = "lightgray";
        }
      };

      window.onload = function() {
        document.querySelectorAll('input[type="checkbox"][id^="autoBidEnabled-"]').forEach(function(checkbox) {
          toggleMaxBidAmount(checkbox);
        });
      };

      document.addEventListener('DOMContentLoaded', function () {
        var toggles = document.querySelectorAll('.toggleBidHistory');
        toggles.forEach(function(toggle) {
          toggle.onclick = function() {
            var itemId = this.getAttribute('data-item-id');
            var bidHistory = document.querySelector('#bidHistoryContainer-' + itemId);
            var itemContainer = document.getElementById('itemContainer-' + itemId);
            var label = this.querySelector('.showHideBidHistoryLabel');

            if (bidHistory.style.display === "none") {
              // itemContainer.style.width = "100%";
              bidHistory.style.display = "block";
              label.textContent = "[hide ";
            } else {
              // itemContainer.style.width = "50%";
              bidHistory.style.display = "none";
              label.textContent = "[show ";
            }
          };
        });
      });
    </script>
  </head>

  <body>
    <div class="column">
      <div style="font-size: 200%;">
        <strong>Welcome, <%= session.getAttribute("loggedInUsername") %></strong>
        <span style="font-size: 55%;">
          <a href="MyAlerts.jsp">My alerts</a>
          <%
          if("admin".equals(session.getAttribute("loggedInUsername"))) {
            out.println("<a href='createCustomerReps.jsp'>Create Customer Reps</a>");
          }
          %>
          <a href="Login.jsp">Log out</a>
        </span>
      </div>
      
      <div>
        <h2>Submit an item for auction</h2>
        
        <form action="submitItem.jsp" method="post" id="auctionOffItemForm">
          <label for="itemName">Item name:</label>
          <input type="text" name="itemName" id="itemName" placeholder="Item name" required>
          
          <label for="itemCategory">Item category:</label>
          <select name="itemCategory" id="itemCategory" required>
            <option value="na">Select category</option>
            <%
            for (String category : itemCategories) {
              out.print("<option value=\"" + category + "\">");
              out.print(category);
              out.println("</option>");
            }
            %>
          </select>
          
          <label for="reservePrice">Reserve price ($):</label>
          <input type="number" id="reservePrice" name="reservePrice" placeholder="Reserve price" step="0.01" min="0">

          <label for="bidIncrement">Bid increment:</label>
          <input type="number" id="bidIncrement" name="bidIncrement" placeholder="Bid increment" required step="0.01" min="0.01">

          <label for="closeDate">Close date:</label>
          <input type="date" id="closeDate" name="closeDate" required>

          <button type="submit">Submit</button>
        </form>
      </div>

      <%
      String msg = (String) session.getAttribute("submitBidMessage");
      if (msg != null) out.println("<big><strong><div style='color: green;'>" + msg + "</div></strong></big>");
      session.removeAttribute("submitBidMessage");
      %>

      <div>
        <h2>Items up for auction</h2>

        <form action="<%=request.getRequestURI()%>" method="get" id="searchItemsForm">
          <input type="text" name="searchItemsBy" id="searchItemsBy" placeholder="Search by keyword..." value="<%= (searchItemsBy != null) ? searchItemsBy : "" %>">

          <select name="sortItemsBy" id="sortItemsBy">
            <option value="">Sort by</option>
            <%
            for (String criteria : criteriaToSortItemsBy) {
              boolean isSelected = criteria.equals(sortItemsBy);
              out.print("<option value=\"" + criteria + "\" " + (isSelected ? "selected" : "") + ">");
              out.print(criteria);
              out.println("</option>");
            }
            %>
          </select>

          <select name="filterItemsBy" id="filterItemsBy">
            <option value="">Select category</option>
            <%
            for (String category : itemCategories) {
              boolean isSelected = category.equals(filterItemsBy);
              out.print("<option value=\"" + category + "\" " + (isSelected ? "selected" : "") + ">");
              out.print(category);
              out.println("</option>");
            }
            %>
          </select>
          <button type="submit">Search</button>
        </form>
      </div>
      
      <div class="itemsContainer">
        <%
        for (Item item : allItems) {
        %>
          <div class="itemContainer" id="itemContainer-<%= item.ID %>"}>
            <div class="itemContainerColumn">
              <div class="itemContainerRow">
                <big><strong><%= item.name %></strong></big>
                <div class="toggleBidHistory" style="color: blue; cursor: pointer; user-select: none;" data-item-id="<%= item.ID %>">
                  <span class="showHideBidHistoryLabel">[hide </span><%= item.bids.size() %> bids]
                </div>
              </div>
              <div class="itemContainerRow">
                <div>Category:</div>
                <div><%= item.category %></div>
              </div>
              <div class="itemContainerRow">
                <div>Posted by:</div>
                <a href="viewAccount.jsp?userID=<%= item.sellerID %>"><%= item.sellerUsername %></a>
              </div>
              <div class="itemContainerRow">
                <div>Date posted:</div>
                <div><%= item.openDate %></div>
              </div>

              <div class="itemContainerRow">
                <%
                if (Timestamp.from(Instant.now()).compareTo(item.closeDate) > 0) {
                %>
                  <div>Bidding closed on:</div>
                <%
                } else {
                %>
                  <div>Bidding closes on:</div>
                <%
                }
                %>
                <div><%= item.closeDate %></div>
              </div>

              <div class="itemContainerRow">
                <%
                if (!item.bids.isEmpty()) {
                %>
                  <%
                  if (Timestamp.from(Instant.now()).compareTo(item.closeDate) > 0 && item.bids.get(0).amount < item.reservePrice) {
                  %>
                    <div style="color: red;">Item never sold.</div>
                  <%
                  } else if (Timestamp.from(Instant.now()).compareTo(item.closeDate) > 0 && item.bids.get(0).amount <= item.reservePrice) {
                  %>
                    <div style="color: green">Auction winner:</div>
                    <div><%= item.bids.get(0).bidderUsername %></div>
                    <%
                    PreparedStatement ps4 = null;
                    
                    try {
                      ps4 = connection.prepareStatement("INSERT INTO Alerts (userID, alertMessage) VALUES (?, ?)");
                      ps4.setInt(1, item.bids.get(0).bidderID);
                      ps4.setString(2, "Congratulations! Your bid of $" + item.bids.get(0).amount + " won the auction for item: " + item.name);
                      ps4.executeUpdate();
                    } catch (SQLException exception) {
                      exception.printStackTrace();
                    }
                    
                    ps4.close();
                    %>
                  <%
                  }
                  %>

                  <%
                  if (Timestamp.from(Instant.now()).compareTo(item.closeDate) <= 0) {
                  %>
                    <div>Current bid:</div>
                    <div>$<%= String.format("%.2f", item.bids.get(0).amount) %></div>
                  <%
                  }
                  %>
                <%
                }
                %>
              </div>

              <%
              if (Timestamp.from(Instant.now()).compareTo(item.closeDate) <= 0) {
              %>
                <div class="itemContainerRow">
                  <big><strong>Make Bid</strong></big>
                </div>

                <form action="submitBid.jsp" method="post" id="submitBidForm">
                  <input type="hidden" name="itemID" value="<%= item.ID %>">
                  <input type="hidden" name="itemName" value="<%= item.name %>">
                  <input type="hidden" name="bidIncrement" value="<%= item.bidIncrement %>">

                  <div class="itemContainerRow">
                    <label for "bidAmount">Bid amount: (Enter <strong>$<%= String.format("%.2f", item.bids.isEmpty() ? item.bidIncrement : item.bids.get(0).amount + item.bidIncrement) %></strong> or more)</label>
                    <input min="<%= (item.bids.isEmpty() ? item.bidIncrement : item.bids.get(0).amount + item.bidIncrement) %>" type="number" id="bidAmount" name="bidAmount" step="<%= item.bidIncrement %>">
                  </div>

                  <div class="itemContainerRow">
                    <div>
                      <label for="autoBidEnabled-<%= item.ID %>">Enable auto bidding:</label>
                      <input type="checkbox" id="autoBidEnabled-<%= item.ID %>" name="autoBidEnabled" value="true" onclick="toggleMaxBidAmount(this)">
                    </div>

                    <div id="maxBidContainer-<%= item.ID %>">
                      <label for "maxBidAmount">Max bid limit ($):</label>
                      <input min="<%= (item.bids.isEmpty() ? item.bidIncrement : item.bids.get(0).amount + item.bidIncrement) %>" type="number" id="maxBidAmount-<%= item.ID %>" name="maxBidAmount" step="<%= item.bidIncrement %>">
                    </div>
                  </div>
                  <button type="submit">Place bid</button>
                </form>
              <%
              }
              %>
            </div>

            <div id="bidHistoryContainer-<%= item.ID %>" class="itemContainerColumn">
              <div class="itemContainerRow">
                <big><strong>Bid History</strong></big>
              </div>

              <table class="ftable">
                <tr>
                  <th>Bid amount ($)</th>
                  <th>User</th>
                  <th>Date</th>
                </tr>
                <%
                for (Bid bid : item.bids) {
                %>
                <tr>
                  <td>$<%= String.format("%.2f", bid.amount) %></td>
                  <td><a href="viewAccount.jsp?userID=<%= bid.bidderID %>"><%= bid.bidderUsername %></a></td>
                  <td><%= bid.timestamp %></td>
                </tr>
                <%
                }
                %>
              </table>
            </div>
          </div>
        <%
        }
        %>
      </div>
    </div>

    <div class="column">
      <div style="font-size: 200%;">
        <strong>Customer Service</strong>
      </div>

      <div>
        <h2>Submit a question</h2>
        <form action="<%=request.getRequestURI()%>" method="post">
          <textarea id="inquiry" name="inquiry" rows="4" cols="50" required></textarea>
          <input type="hidden" name="submitType" value="postQuestion">
          <br><br>
          <button type="submit">Submit</button>
        </form>
      </div>

      <div class="questionsContainer">
        <%
        if ("postQuestion".equals(request.getParameter("submitType"))) {
          String questionText = request.getParameter("inquiry");
          int userID = (Integer) session.getAttribute("loggedInUserID");

          PreparedStatement pst = connection.prepareStatement("INSERT INTO Questions (questionText, userID, postedOn) VALUES (?, ?, NOW())", Statement.RETURN_GENERATED_KEYS);
          pst.setString(1, questionText);
          pst.setInt(2, userID);
          pst.executeUpdate();
          pst.close();
        }
        %>

        <%PreparedStatement ps99 = connection.prepareStatement("SELECT Questions.*, Users.username AS user_name, CustomerReps.customerRepUsername AS rep_name FROM Questions JOIN Users ON Questions.userID = Users.userID LEFT JOIN CustomerReps ON Questions.customerRepID = CustomerReps.customerRepID");

        ResultSet rs99 = ps99.executeQuery();

        out.println("<table>");
          out.println("<tr>");
            out.println("<th>Question</th>");
            out.println("<th>Answer</th>");
            out.println("<th>Posted on</th>");
          out.println("</tr>");

          while (rs99.next()) {
            out.println("<tr>");
              out.println("<td>");
                out.println(rs99.getString("questionText"));
                out.println("<div>by:" + rs99.getString("user_name") + "</div>");
              out.println("</td>");

              out.println("<td>");
                out.println(rs99.getString("answerText"));
                out.println("<div>by:" + rs99.getString("rep_name") + "</div>");
              out.println("</td>");
              
              out.println("<td>" + rs99.getTimestamp("postedOn").toString().split(" ")[0] + "</td>");
            out.println("</tr>");
          }
        out.println("</table>");
        
        rs99.close();
        ps99.close();
        %>
      </div>
    </div>
  </body>
</html>
