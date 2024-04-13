<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Ebay Bid</title>
		
				<style>
			/* Add CSS styles here */
			
			body{
				margin: auto;
				text-align: center;
				font-family: 'Roboto', sans-serif; 
			}
			table {
				margin: auto; /* Center the table horizontally */
				font-family: 'Roboto', sans-serif; /* Change font family */
				margin-bottom: 20px;
				margin-top: 20px;
			}
			td{
				text-align: center; /* Center align content inside table cells */
			}
			input[type="text"] {
				font-family: 'Roboto', sans-serif; 
				padding: 5px;
				margin: 5px, 0;
			}
			input[type="submit"] {
				text-align: center;
				font-family: 'Roboto', sans-serif; 
				padding: 8px 15px;
			}
		</style>
	</head>
	
	<body>
	
		Login  <!-- the usual HTML way -->
		<% out.println("Here:"); %> 
							 
	<br>
	
	
	
		<form method="post" action="loginCheck.jsp">
			<table>
				<tr>    
					<td>Username:</td><td><input type="text" name="username"></td>
				</tr>
				<tr>
					<td>Password:</td><td><input type="text" name="password"></td>
				</tr>
			</table>
			<input type="submit" value="Enter">
		</form>
	<br>
</body>
</html>