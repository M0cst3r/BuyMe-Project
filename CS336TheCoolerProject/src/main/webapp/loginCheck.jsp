<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<!--Import some libraries that have classes that we need -->
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Login check code</title>

<style type="text/css">

/* CSS Stylee*/
			body{
				margin: auto;
				text-align: center;
				font-family: 'Roboto', sans-serif; 
				margin-top: 20px
			}
			
			input[type="submit"] {
				text-align: center;
				font-family: 'Roboto', sans-serif; 
				padding: 8px 15px;
			}

</style>
</head>
<body>
	<%
	try {

		//Connecting to the database (MYSQL) and using the java class 
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();

		//Create a SQL statement
		Statement stmt = con.createStatement();

		//Get parameters from the HTML form at the Login.jsp
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		

		//Wording
		String insert = "SELECT username, password FROM login WHERE username=? AND password=?";
						
		//Create a Prepared SQL statement allowing you to introduce the parameters of the query
		PreparedStatement ps = con.prepareStatement(insert);

		//Add parameters of the query. Start with 1, the 0-parameter is the INSERT statement itself
		ps.setString(1, username);
		ps.setString(2, password);
		//Run the query against the DB
		ResultSet result = ps.executeQuery();
		
		//If anything's been returned then there's a pair existing for the login so it should log in
		if(result.next()) { %>
			<form method="post" action="Login.jsp">
				<input type="submit" value="log out" />
			</form>	
		<% }
		else {
			out.print("nope, try again");
		}

		//Close the connection. This is a must, otherwise you're keeping the resources of the server allocated.
		con.close();

		
	} catch (Exception ex) {
		out.print(ex);
		out.print(". Login failed :()");
	}
%>
</body>
</html>