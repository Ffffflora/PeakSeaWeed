package com.peakcentre.web.dbc;

import java.sql.Connection;
import java.sql.SQLException;
import java.util.ResourceBundle;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;

public class DatabaseConnection {

	// Database connection
	public static Connection getConnection() {
		DataSource datasource = null;
		Connection conn = null;
		Context context = null;
		try {
			context = new InitialContext();
			datasource = (DataSource) context
					.lookup("java:comp/env/jdbc/peakcentredb");
			conn = datasource.getConnection();
		} catch (SQLException e) {
			System.out.println("SQL Exception");
			e.printStackTrace();
		} catch (NamingException e) {
			System.out.println("Naming Exception");
			e.printStackTrace();
		}
		return conn;
	}

	// Database Disconnection
	public void closeConnection(Connection conn) {
		if (conn != null) {
			try {
				conn.close();
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}

}
