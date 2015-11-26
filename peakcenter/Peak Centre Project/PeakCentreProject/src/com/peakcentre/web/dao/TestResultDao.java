package com.peakcentre.web.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.HashSet;

import org.bson.Document;

import com.mongodb.Block;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.peakcentre.web.dbc.DatabaseConnection;
import com.peakcentre.web.entity.TestResult;
import com.peakcentre.web.entity.TestResultTemplate;
import com.peakcentre.web.entity.Userinfo;
import com.sun.research.ws.wadl.Doc;
import com.peakcentre.web.mongo.*;

//Used for Test Result related database manipulation
public class TestResultDao {
	MongoDBConnection connec = new MongoDBConnection();
	MongoCollection<Document> testResultCollection;

	// insert data into TestResult Table
	public void insertTestResult(TestResult tr) {
		Map<String, String> hm = tr.getData();
		// Connect to the Collection(Table)
		testResultCollection = connec.getRequiredCollection("TestResult");
		List<Document> list = new ArrayList<Document>();

		Iterator it = hm.entrySet().iterator();
		while (it.hasNext()) {
			Map.Entry<String, String> e = (Map.Entry<String, String>) it.next();
			Document doc = new Document("username", tr.getUsername()).append("date", tr.getDate())
					.append("tempId", tr.getTempId()).append("table", e.getKey()).append("data", e.getValue());
			list.add(doc);
		}
		// insert to mongodb
		testResultCollection.insertMany(list);

		// Close the Connection
		connec.closeConnection();
	}

	/*
	 * //insert data into Test Result Table public boolean
	 * insertTestResultTable(String username, String tableName, String date,
	 * ArrayList<ArrayList<String>> data) { testResultCollection =
	 * connec.getRequiredCollection("TestResult");
	 * 
	 * Document doc = new Document("username", username).append("tablename",
	 * tableName) .append("date", date); Document docForNewData = new
	 * Document("map", data);
	 * 
	 * testResultCollection.findOneAndUpdate(doc, docForNewData); return
	 * (testResultCollection.find(doc).first().get("map").equals(data)); }
	 */

	// Get Template Names of one user
	public ArrayList<String> getTemplateNames(String username) {

		testResultCollection = connec.getRequiredCollection("TestResult");

		FindIterable<Document> tempList = testResultCollection.find(new Document("username", username));
		HashSet<Integer> tempIdList = new HashSet<Integer>();

		for (Document doc : tempList) {
			if (doc != null) {
				tempIdList.add(Integer.parseInt(doc.get("tempId") + ""));
			}
		}
		connec.closeConnection();

		ArrayList<String> tempNameList = new ArrayList<String>();

		for (int id : tempIdList) {
			testResultCollection = connec.getRequiredCollection("TestResultTemplate");
			FindIterable<Document> l = testResultCollection.find(new Document("id", id));
			for (Document doc : l) {
				if (doc != null) {
					tempNameList.add(doc.get("name").toString());
				}
			}
			connec.closeConnection();
		}

		return tempNameList;
	}

	// Get test result dates of one user
	public ArrayList<String> getDates(String username) {
		testResultCollection = connec.getRequiredCollection("TestResult");

		FindIterable<Document> tempList = testResultCollection.find(new Document("username", username));
		HashSet<String> tempDateList = new HashSet<String>();

		for (Document doc : tempList) {
			if (doc != null) {
				tempDateList.add(doc.get("date").toString());
			}
		}

		connec.closeConnection();

		ArrayList<String> result = new ArrayList<String>();
		for (String s : tempDateList) {
			result.add(s);
		}
		return result;

	}

	// Check if template name and date exists of one user
	public boolean checkNameDate(String username, String tempName, String date) throws Exception {
		testResultCollection = connec.getRequiredCollection("TestResultTemplate");
		int id = 0;
		Document doc1 = new Document("name", tempName);
		FindIterable<Document> tempList1 = testResultCollection.find(doc1);
		if (tempList1.first() != null) {
			id = (int) tempList1.first().get("id");
		}

		connec.closeConnection();

		testResultCollection = connec.getRequiredCollection("TestResult");
		boolean flag = false;

		if (id == 0)
			System.out.println("********Error**********");

		Document doc = new Document("username", username).append("date", date).append("tempId", id);

		FindIterable<Document> tempList = testResultCollection.find(doc);
		if (tempList.first() != null) {
			flag = true;
		}

		connec.closeConnection();
		return flag;
	}

	// Get test result
	public TestResult getTestResult(String username, int tempId, String date) {
		final TestResult result = new TestResult();
		// Connect to the Collection(Table)
		testResultCollection = connec.getRequiredCollection("TestResult");

		result.setDate(date);
		result.setTempId(tempId);
		result.setUsername(username);
		FindIterable<Document> iterable = testResultCollection
				.find(new Document("username", username).append("tempId", tempId).append("date", date));

		iterable.forEach(new Block<Document>() {
			@Override
			public void apply(Document document) {
				System.out.println("Document: " + document);
				result.setData((String) document.get("table"), (String) document.get("data"));
			}
		});

		// Close the Connection
		connec.closeConnection();

		return result;
	}

	public void updateTestResult(TestResult tr) {
		// Connect to the Collection(Table)
		testResultCollection = connec.getRequiredCollection("TestResult");

		String username = tr.getUsername();
		int tempId = tr.getTempId();
		String date = tr.getDate();
		Map<String, String> hm = tr.getData();

		Iterator it = hm.entrySet().iterator();

		while (it.hasNext()) {
			Map.Entry<String, String> e = (Map.Entry<String, String>) it.next();
			testResultCollection.updateOne(new Document("username", username).append("date", date)
					.append("tempId", tempId).append("table", e.getKey()),
					new Document("$set", new Document("data", e.getValue())));
		}

		// Close the Connection
		connec.closeConnection();

	}
}

/*
 * import java.sql.Connection; import java.sql.PreparedStatement; import
 * java.sql.ResultSet; import java.sql.SQLException; import java.sql.Statement;
 * import java.util.ArrayList;
 * 
 * import com.peakcentre.web.dbc.DatabaseConnection; import
 * com.peakcentre.web.entity.TestResult; import
 * com.peakcentre.web.entity.TestResultTemplate; import
 * com.peakcentre.web.entity.Userinfo;
 * 
 * //Used for Test Result related database manipulation public class
 * TestResultDao { private DatabaseConnection dbc; private Connection conn;
 * 
 * //insert data into TestResult Table public boolean
 * insertTestResult(TestResult tr) { dbc = new DatabaseConnection(); conn =
 * dbc.getConnection(); PreparedStatement pstmt = null;
 * 
 * boolean flag = false;
 * 
 * try { boolean autoCommit = conn.getAutoCommit(); conn.setAutoCommit(false);
 * 
 * String sql = "INSERT INTO TestResult(username,tempId,date) VALUES(?,?,?)";
 * pstmt = conn.prepareStatement(sql);
 * 
 * pstmt.setString(1, tr.getUsername()); pstmt.setInt(2, tr.getTempId());
 * pstmt.setString(3, tr.getDate());
 * 
 * int rs = pstmt.executeUpdate(); if (rs > 0) { flag = true; } conn.commit();
 * conn.setAutoCommit(autoCommit);
 * 
 * } catch (SQLException e) { e.printStackTrace(); } finally { try {
 * pstmt.close(); conn.close(); dbc.closeConnection(conn); } catch (Exception e)
 * { try { throw e; } catch (Exception e1) { e1.printStackTrace(); } } }
 * 
 * return flag;
 * 
 * }
 * 
 * //insert data into Test Result Table public boolean
 * insertTestResultTable(String username, String tableName, String date,
 * ArrayList<ArrayList<String>> data) { dbc = new DatabaseConnection(); conn =
 * dbc.getConnection(); Statement pstmt = null;
 * 
 * boolean flag = true;
 * 
 * try { boolean autoCommit = conn.getAutoCommit(); conn.setAutoCommit(false);
 * 
 * String th = "";
 * 
 * for (int t = 0; t < data.get(0).size(); t++) { th += "," +
 * data.get(0).get(t); }
 * 
 * for (int d = 1; d < data.size(); d++) { String c = ""; ArrayList<String>
 * currentList = data.get(d);
 * 
 * for (int j = 0; j < currentList.size(); j++) { c += ",'" + currentList.get(j)
 * + "'";
 * 
 * } String insertSql = "insert into " + tableName + "(username,date" + th + ")"
 * + " values('" + username + "','" + date + "'" + c + ");"; pstmt =
 * conn.createStatement(); pstmt.executeUpdate(insertSql);
 * 
 * }
 * 
 * conn.commit(); conn.setAutoCommit(autoCommit);
 * 
 * } catch (SQLException e) { e.printStackTrace(); } finally { try {
 * pstmt.close(); conn.close(); dbc.closeConnection(conn); } catch (Exception e)
 * { try { throw e; } catch (Exception e1) { e1.printStackTrace(); } } } return
 * flag;
 * 
 * }
 * 
 * //Get Template Names of one user public ArrayList<String>
 * getTemplateNames(String username) { dbc = new DatabaseConnection(); conn =
 * dbc.getConnection(); PreparedStatement pstmt = null; ArrayList<String> list =
 * new ArrayList<String>(); try { boolean autoCommit = conn.getAutoCommit();
 * conn.setAutoCommit(false);
 * 
 * String sql =
 * "SELECT name from TestResultTemplate where id in (select distinct tempid from TestResult where username=?)"
 * ; pstmt = conn.prepareStatement(sql); pstmt.setString(1, username); ResultSet
 * rs = pstmt.executeQuery(); while (rs.next()) { list.add(rs.getString(1)); }
 * conn.commit(); conn.setAutoCommit(autoCommit);
 * 
 * } catch (Exception e) { try { conn.rollback(); } catch (Exception e1) {
 * e1.printStackTrace(); } } finally { try { pstmt.close(); conn.close();
 * dbc.closeConnection(conn); } catch (Exception e) { try { throw e; } catch
 * (Exception e1) { e1.printStackTrace(); } } } return list; }
 * 
 * //Get test result dates of one user public ArrayList<String> getDates(String
 * username) { dbc = new DatabaseConnection(); conn = dbc.getConnection();
 * PreparedStatement pstmt = null; ArrayList<String> list = new
 * ArrayList<String>(); try { boolean autoCommit = conn.getAutoCommit();
 * conn.setAutoCommit(false);
 * 
 * String sql = "select distinct date from TestResult where username=?"; pstmt =
 * conn.prepareStatement(sql); pstmt.setString(1, username); ResultSet rs =
 * pstmt.executeQuery(); while (rs.next()) { list.add(rs.getString(1)); }
 * conn.commit(); conn.setAutoCommit(autoCommit);
 * 
 * } catch (Exception e) { try { conn.rollback(); } catch (Exception e1) {
 * e1.printStackTrace(); } } finally { try { pstmt.close(); conn.close();
 * dbc.closeConnection(conn); } catch (Exception e) { try { throw e; } catch
 * (Exception e1) { e1.printStackTrace(); } } } return list; }
 * 
 * //Check if template name and date exists of one user public boolean
 * checkNameDate(String username, String tempName, String date) throws Exception
 * { dbc = new DatabaseConnection(); conn = dbc.getConnection(); boolean flag =
 * false; PreparedStatement pstmt = null; try { boolean autoCommit =
 * conn.getAutoCommit(); conn.setAutoCommit(false);
 * 
 * String sql =
 * "SELECT id FROM TestResult WHERE username=? AND date=? AND tempid=(SELECT id from TestResultTemplate WHERE name=?)"
 * ; pstmt = conn.prepareStatement(sql); pstmt.setString(1, username);
 * pstmt.setString(2, date); pstmt.setString(3, tempName); ResultSet rs =
 * pstmt.executeQuery(); if (rs.next()) { flag = true; } conn.commit();
 * conn.setAutoCommit(autoCommit);
 * 
 * } catch (Exception e) { try { conn.rollback(); } catch (Exception e1) {
 * e1.printStackTrace(); } } finally { try { pstmt.close(); conn.close();
 * dbc.closeConnection(conn); } catch (Exception e) { throw e; } } return flag;
 * }
 * 
 * //Get test result public ArrayList<ArrayList<String>> getTestResult(String
 * tableName, String username, String date, ArrayList<String> ths) {
 * ArrayList<ArrayList<String>> list = new ArrayList<ArrayList<String>>();
 * 
 * dbc = new DatabaseConnection(); conn = dbc.getConnection(); Statement pstmt =
 * null;
 * 
 * String th = "";
 * 
 * try { boolean autoCommit = conn.getAutoCommit(); conn.setAutoCommit(false);
 * 
 * for (int t = 0; t < ths.size(); t++) { th += ths.get(t) + ","; } th =
 * th.substring(0, th.length() - 1);
 * 
 * String sql = "select " + th + " from " + tableName + " where username='" +
 * username + "' and date='" + date + "'"; pstmt = conn.createStatement();
 * ResultSet rs = pstmt.executeQuery(sql); while (rs.next()) { ArrayList<String>
 * l = new ArrayList<String>(); for (int i = 1; i <=
 * rs.getMetaData().getColumnCount(); i++) { l.add(rs.getString(i));
 * 
 * } list.add(l); }
 * 
 * conn.commit(); conn.setAutoCommit(autoCommit);
 * 
 * } catch (SQLException e) { e.printStackTrace(); } finally { try {
 * pstmt.close(); conn.close(); dbc.closeConnection(conn); } catch (Exception e)
 * { try { throw e; } catch (Exception e1) { e1.printStackTrace(); } } }
 * 
 * return list;
 * 
 * } }
 */
