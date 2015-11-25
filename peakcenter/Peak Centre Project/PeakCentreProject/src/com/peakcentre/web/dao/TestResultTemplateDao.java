package com.peakcentre.web.dao;

import java.util.ArrayList;

import org.bson.Document;

import com.peakcentre.web.entity.*;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;

import com.peakcentre.web.mongo.*;

//Used for Test Result Template related database manipulation
public class TestResultTemplateDao {
	MongoDBConnection connec = new MongoDBConnection();
	MongoCollection<Document> tempCollection;

	//Check if template name exists
	public boolean checkTempName(String name) {
		tempCollection = connec.getRequiredCollection("TestResultTemplate");

		boolean flag = true;
		
		Document doc = new Document("name", name);
		FindIterable<Document> tempList = tempCollection.find(doc);
		if (tempList.first() != null) {
			flag = true;
		}

		connec.closeConnection();
		return flag;
	}

	//Get next id of table TestResultTemplate
	public String getNextId() {
		return null;
	}

	//insert date into table TestResultTemplate
	public boolean insertTemplate(TestResultTemplate trt) {
		tempCollection = connec.getRequiredCollection("TestResultTemplate");
		final long previousCount = tempCollection.count();
		
		int id = (int)tempCollection.count()+1;
		Document doc = new Document("name", trt.getName()).append("temppath", trt.getTemppath()).append("id", id);
		
		tempCollection.insertOne(doc);
		boolean a = tempCollection.count() > previousCount;
		connec.closeConnection();
		return a;

	}

	//Create Template table in db
	public boolean createTemplateTable(String templateName, int tableNumber,
			ArrayList<ArrayList<String>> columns) {
		return false;

	}

	//Delete a template
	public boolean deleteTemplate(String name) {
		tempCollection = connec.getRequiredCollection("TestResultTemplate");
		final long previousCount = tempCollection.count();
		
		
		Document doc = new Document("name", name);
		tempCollection.deleteOne(doc);
		boolean a = previousCount > tempCollection.count();
		connec.closeConnection();
		return a;
	}

	//Delete template table from db
	public boolean deleteTemplateTable(String name) {
		return false;
	}

	//Get template path from table TestResultTemplate by template name
	public String getTempPathByName(String name) {
		tempCollection = connec.getRequiredCollection("TestResultTemplate");
		String tempPath = null;
		
		Document doc = new Document("name", name);
		FindIterable<Document> tempList = tempCollection.find(doc);
		if (tempList.first() != null) {
			tempPath = tempList.first().get("temppath").toString();
		}
		
		connec.closeConnection();
		return tempPath;

	}

	//Get template id from table TestResultTemplate by template name
	public int getTempIdByName(String name) {
		tempCollection = connec.getRequiredCollection("TestResultTemplate");
		int id = 0;
		
		Document doc = new Document("name", name);
		FindIterable<Document> tempList = tempCollection.find(doc);
		if (tempList.first() != null) {
			id = (int) tempList.first().get("id");
		}
		
		connec.closeConnection();
		return id;

	}
	public ArrayList<String> getAllTempName(){
		ArrayList<String> allNames = new ArrayList<String>();
		
		FindIterable<Document> list = connec.getRequiredCollection("TestResultTemplate").find();
		for(Document doc: list){
			allNames.add(doc.get("name").toString());
		}
		
		connec.closeConnection();
		return allNames;
		
	}
}

/*
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

import com.peakcentre.web.entity.*;
import com.peakcentre.web.dbc.DatabaseConnection;

//Used for Test Result Template related database manipulation
public class TestResultTemplateDao {
	private DatabaseConnection dbc;
	private Connection conn;

	//Check if template name exists
	public boolean checkTempName(String name) {
		dbc = new DatabaseConnection();
		conn = dbc.getConnection();
		PreparedStatement pstmt = null;

		boolean flag = true;

		try {
			boolean autoCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);

			String sql = "SELECT id FROM TestResultTemplate WHERE name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				flag = false;
			}
			conn.commit();
			conn.setAutoCommit(autoCommit);

		} catch (Exception e) {
			try {
				conn.rollback();
			} catch (Exception e1) {
				e1.printStackTrace();
			}
		} finally {
			try {
				pstmt.close();
				conn.close();
				dbc.closeConnection(conn);
			} catch (SQLException e) {
				e.printStackTrace();
			}

		}

		return flag;
	}

	//Get next id of table TestResultTemplate
	public String getNextId() {
		dbc = new DatabaseConnection();
		conn = dbc.getConnection();
		PreparedStatement pstmt = null;

		String nextId = "0";

		String sql = "SELECT AUTO_INCREMENT FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'peakcentredb' AND TABLE_NAME = 'TestResultTemplate'";
		try {
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				nextId = rs.getString(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
				dbc.closeConnection(conn);
			} catch (Exception e) {
				try {
					throw e;
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		}
		return nextId;

	}

	//insert date into table TestResultTemplate
	public boolean insertTemplate(TestResultTemplate trt) {
		dbc = new DatabaseConnection();
		conn = dbc.getConnection();
		PreparedStatement pstmt = null;

		boolean flag = false;

		try {
			boolean autoCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);

			String sql = "INSERT INTO TestResultTemplate(name,temppath) VALUES(?,?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, trt.getName());
			pstmt.setString(2, trt.getTemppath());

			int rs = pstmt.executeUpdate();
			if (rs > 0) {
				flag = true;
			}
			conn.commit();
			conn.setAutoCommit(autoCommit);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
				dbc.closeConnection(conn);
			} catch (Exception e) {
				try {
					throw e;
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		}

		return flag;

	}

	//Create Template table in db
	public boolean createTemplateTable(String templateName, int tableNumber,
			ArrayList<ArrayList<String>> columns) {
		dbc = new DatabaseConnection();
		conn = dbc.getConnection();
		Statement pstmt = null;

		boolean flag = true;

		try {
			boolean autoCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);

			for (int t = 0; t < tableNumber; t++) {
				String c = "";

				ArrayList<String> currentList = columns.get(t);
				for (int j = 0; j < currentList.size(); j++) {
					c += "," + currentList.get(j) + " varchar(255) not null";
				}
				String dropSql = "drop table if exists " + templateName
						+ "Table" + Integer.toString(t + 1);
				String createSql = "create table "
						+ templateName
						+ "Table"
						+ Integer.toString(t + 1)
						+ "(id int(8) primary key auto_increment,username varchar(255) not null,date varchar(20) not null"
						+ c + ");";
				pstmt = conn.createStatement();

				pstmt.executeUpdate(dropSql);
				pstmt.executeUpdate(createSql);

			}

			conn.commit();
			conn.setAutoCommit(autoCommit);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
				dbc.closeConnection(conn);
			} catch (Exception e) {
				try {
					throw e;
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		}
		return flag;

	}

	//Delete a template
	public boolean deleteTemplate(String name) {
		dbc = new DatabaseConnection();
		conn = dbc.getConnection();
		PreparedStatement pstmt = null;

		boolean flag = false;

		try {
			boolean autoCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);

			String sql = "DELETE from TestResultTemplate where name=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);

			int rs = pstmt.executeUpdate();
			if (rs > 0) {
				flag = true;
			}
			conn.commit();
			conn.setAutoCommit(autoCommit);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
				dbc.closeConnection(conn);
			} catch (Exception e) {
				try {
					throw e;
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		}

		return flag;
	}

	//Delete template table from db
	public boolean deleteTemplateTable(String name) {
		dbc = new DatabaseConnection();
		conn = dbc.getConnection();
		Statement pstmt = null;

		boolean flag = true;

		try {
			boolean autoCommit = conn.getAutoCommit();
			conn.setAutoCommit(false);

			for (int t = 0; t < 21; t++) {
				String c = "";

				String dropSql = "drop table if exists " + name + "Table"
						+ Integer.toString(t + 1);

				pstmt = conn.createStatement();

				pstmt.executeUpdate(dropSql);

			}

			conn.commit();
			conn.setAutoCommit(autoCommit);

		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
				dbc.closeConnection(conn);
			} catch (Exception e) {
				try {
					throw e;
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		}
		return flag;

	}

	//Get template path from table TestResultTemplate by template name
	public String getTempPathByName(String name) {
		dbc = new DatabaseConnection();
		conn = dbc.getConnection();
		PreparedStatement pstmt = null;

		String tempPath = null;
		
		String sql = "SELECT temppath FROM TestResultTemplate WHERE name = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				tempPath = rs.getString(1);
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
				dbc.closeConnection(conn);
			} catch (Exception e) {
				try {
					throw e;
				} catch (Exception e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
			}
		}
		return tempPath;

	}

	//Get template id from table TestResultTemplate by template name
	public int getTempIdByName(String name) {
		dbc = new DatabaseConnection();
		conn = dbc.getConnection();
		PreparedStatement pstmt = null;

		int id = 0;
		
		String sql = "SELECT id FROM TestResultTemplate WHERE name = ?";
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, name);
			ResultSet rs = pstmt.executeQuery();
			if (rs.next()) {
				id = rs.getInt(1);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			try {
				pstmt.close();
				conn.close();
				dbc.closeConnection(conn);
			} catch (Exception e) {
				try {
					throw e;
				} catch (Exception e1) {
					e1.printStackTrace();
				}
			}
		}
		return id;

	}
}
*/