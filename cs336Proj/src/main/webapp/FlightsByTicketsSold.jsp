<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%

		try {

			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();	
			
			Statement stmt = con.createStatement();
			//Make a SELECT query from the sells table with the price range specified by the 'price' parameter at the index.jsp
			String select = "SELECT Item_name, Count(*) as quantity_sold FROM bids group by Item_name order by quantity_sold DESC; ";

			PreparedStatement ps = con.prepareStatement(select);
			
			ResultSet result = ps.executeQuery();

			
			//Make an HTML table to show the results in:
		if(result.next()) {
%>
		<h1>Flights By Tickets Sold</h1>

	</table>
		<table border="1">
        <tr>
            <th>Flight Number</th>
            <th>Tickets Sold</th>
            
        </tr>
    
    <% 
    
    out.println("<tr>");
	
	out.println("<td>" + result.getString(1) + "</td>");
	out.println("<td>" + result.getString(2) + "</td>");
    		
	while(result.next()) {
			String flight = result.getString(1);
			String ticket = result.getString(2);

    		
    		out.println("<tr>");
    		
    		out.println("<td>" + flight + "</td>");
    		out.println("<td>" + ticket + "</td>");

    		out.println("</tr>");
		}
		out.println("</tbody>");
		out.println("</table>");
		}


		else{
	out.print("There are no flights with ticket sales!");
}
			//close the connection.
			con.close();

		} catch (Exception e) {
		}
	%>
</body>
</html>
