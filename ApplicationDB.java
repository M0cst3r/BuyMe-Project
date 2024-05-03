package mypackage;
import java.lang.reflect.InvocationTargetException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class ApplicationDB {
	public Connection getConnection() {
		String connectionUrl = "jdbc:mysql://localhost:3306/onlinemarket";
		// mysql -u root -p  < thecoolscript.sql

		try {
			Class.forName("com.mysql.cj.jdbc.Driver").getDeclaredConstructor().newInstance();
		} catch (InstantiationException | IllegalAccessException | IllegalArgumentException | InvocationTargetException | NoSuchMethodException | SecurityException | ClassNotFoundException e) {
			e.printStackTrace();
		}

		Connection connection = null;
		
		try {
			connection = DriverManager.getConnection(connectionUrl, "root", "tempario9191");
		} catch (SQLException e) {
			e.printStackTrace();
		}

		return connection;
	}

	public void closeConnection(Connection connection) {
		try {
			connection.close();
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}

	public static void main(String[] args) {
		ApplicationDB dao = new ApplicationDB();
		Connection connection = dao.getConnection();

		System.out.println(connection);
	}
}
