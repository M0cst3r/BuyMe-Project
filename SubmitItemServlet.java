package mypackage;

import java.io.*;
import java.sql.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class SubmitItemServlet extends HttpServlet {
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        String title = request.getParameter("title");
        String description = request.getParameter("description");
        double reservePrice = Double.parseDouble(request.getParameter("reservePrice"));
        String closingDate = request.getParameter("closingDate") + " " + request.getParameter("closingTime");

        try {
            Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/thecoolproject", "root", "tempario9191");
            PreparedStatement ps = con.prepareStatement(
                "INSERT INTO Items (seller_id, title, description, reserve_price, start_date, end_date) VALUES (?, ?, ?, ?, NOW(), ?)");

            
            ps.setInt(1, 1);
            ps.setString(2, title);
            ps.setString(3, description);
            ps.setDouble(4, reservePrice);
            ps.setString(5, closingDate);
            ps.executeUpdate();

            out.println("<p>Item listed successfully!</p>");
        } catch (SQLException e) {
            out.println("<p>Error listing item: " + e.getMessage() + "</p>");
            e.printStackTrace();
        } finally {
            out.close();
        }
    }
}

// javac -cp "WEB-INF\lib\servlet-api.jar" SubmitItemServlet.java