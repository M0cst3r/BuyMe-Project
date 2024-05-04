<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@ page import="java.io.*, java.util.*, java.sql.*" %>
<%@ page import="javax.servlet.http.*, javax.servlet.*" %>

<!DOCTYPE html>
<html>
  <head>
    <style type="text/css">
      #borderContainer {
        display: flex;
        border: 1px solid black;
        width: 10vw;
      }

      #loginContainer {
        justify-content: space-around;
        align-items: center;
      }

      input {
        flex: 1;
        width: 10vw;
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
      <legend>Login</legend>

      <form method="post" action="loginCheck.jsp" id="loginContainer">
        <input type="text" name="username" id="username" placeholder="Username" required>
        <input type="text" name="password" id="password" placeholder="Password" required>

        <button type="submit">Log In</button>
      </form>
    </fieldset>
  </body>
</html>
