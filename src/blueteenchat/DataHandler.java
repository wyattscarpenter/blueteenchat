package blueteenchat;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.DriverManager;
import java.sql.PreparedStatement;

public class DataHandler {
	//All my code for this section is based on the provided sample code
	private Connection conn;
	// Azure SQL connection credentials
	private String server = "carp-4200-sql-server.database.windows.net";
	private String database = "cs-dsa-4513-sql-db";
	private String username = "carp4200";
	private String password = "Jocker 2 Taras";
	// Resulting connection string
	final private String url = String.format(
			"jdbc:sqlserver://%s:1433;database=%s;user=%s;password=%s;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;loginTimeout=30;",
			server, database, username, password);
	// Initialize and save the database connection
	private void getDBConnection() throws SQLException {
		if (conn != null) {return;}
		this.conn = DriverManager.getConnection(url);
	}

	//"CREATE TABLE msgs (id INT NOT NULL IDENTITY(1,1) PRIMARY KEY, name VARCHAR(100), hashcode VARCHAR(100), message VARCHAR(8000));"
	
	public ResultSet getAllCustomers() throws SQLException {
		return getAllCustomers("0","10");
	}
	// Return the result of selecting everything from the movie_night table
	public ResultSet getAllCustomers(String lower, String upper) throws SQLException {
		getDBConnection();
		final String sqlQuery = "SELECT * FROM msgs;";
		final PreparedStatement stmt = conn.prepareStatement(sqlQuery);
		return stmt.executeQuery();
	}

	// Inserts a record into the movie_night table with the given attribute values
	public boolean addCustomer(String name, String address, String duration) throws SQLException {
		getDBConnection(); // Prepare the database connection
		// Prepare the SQL statement
		final String sqlQuery = "INSERT INTO msgs VALUES (?, ?, ?)";
		final PreparedStatement stmt = conn.prepareStatement(sqlQuery);
		// Replace the '?' in the above statement with the given attribute values
		try {
			MessageDigest md;
			md = MessageDigest.getInstance("SHA-256");
			byte[] digest = md.digest((address+"salty string right here").getBytes());
			int digestint = digest[0]*0x100 + digest[1];
			stmt.setString(2, new String(digest));
			stmt.setString(1, name+"#"+ Integer.toHexString(digestint).toUpperCase());
		} catch (NoSuchAlgorithmException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} 
		stmt.setString(3, duration);
		// Execute the query, if only one record is updated, then we indicate success by returning true
		return stmt.executeUpdate() == 1;
	}
}