package com.peakcentre.web.dao;

import java.util.ArrayList;

import org.bson.Document;

import com.peakcentre.web.entity.*;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.result.UpdateResult;
import com.peakcentre.web.mongo.*;

import sun.swing.UIAction;

//Used for User Account related database manipulation

public class UserinfoDao {

	MongoDBConnection connec = new MongoDBConnection();

	MongoCollection<Document> userCollection;

	// insert data into table Userinfo updated

	public boolean insertUser(final Userinfo userinfo) {
		Boolean flag = false;
		// connect to database
		userCollection = connec.getRequiredCollection("Userinfo");
		final long previousCount = userCollection.count();

		Document doc = new Document("usertype", userinfo.getUsertype()).append("city", userinfo.getCity())
				.append("username", userinfo.getUsername()).append("password", userinfo.getPassword())
				.append("fname", userinfo.getFname()).append("lname", userinfo.getLname())
				.append("level", userinfo.getLevel()).append("gender", userinfo.getGender())
				.append("dob", userinfo.getDob()).append("picpath", userinfo.getPicpath());

		userCollection.insertOne(doc);
		// 在insert之后，就会有独一的id，所以从collection中找到之前插入的user，然后update他的id。

		userCollection.findOneAndUpdate(userCollection.find(doc).first(),
				new Document("$set", new Document("id", userCollection.find(doc).first().get("_id").toString())));
		// how to check if the insert operation works? I compared the count of
		// collection.
		if (userCollection.count() > previousCount) {
			flag = true;
		}

		// close connection.
		connec.closeConnection();

		return flag;

	}

	public boolean checkLogin(Userinfo ui) {
		try {
			return this.checkLogin(ui.getUsername(), ui.getPassword(), ui.getUsertype());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	// Check if login information correct

	public boolean checkLogin(final String username, final String password, final String usertype) throws Exception {

		userCollection = connec.getRequiredCollection("Userinfo");

		boolean flag = false;

		Document doc = new Document("username", username).append("usertype", usertype);

		// get collections according to username and type, then compare psw.

		FindIterable<Document> userList = userCollection.find(doc);

		if (userList != null) {

			for (Document user : userList) {

				boolean match = user.get("password").equals(password);

				flag = flag || match;

			}

		}

		connec.closeConnection();

		return flag;

	}

	// Get a user's first name

	public String getFirstName(Userinfo user) {

		userCollection = connec.getRequiredCollection("Userinfo");

		String username = user.getUsername();

		String fname = "user";

		FindIterable<Document> userList = userCollection.find(new Document("username", username));

		if (userList.first() != null) {

			fname = userList.first().get("fname").toString();

		}

		// close connection.

		connec.closeConnection();

		return fname;

	}

	// Get a user's city

	public String getCity(Userinfo user) {

		userCollection = connec.getRequiredCollection("Userinfo");

		String username = user.getUsername();

		String city = "Ottawa";

		FindIterable<Document> userList = userCollection.find(new Document("username", username));

		if (userList.first() != null) {

			city = userList.first().get("city").toString();

		}

		// close connection.

		connec.closeConnection();

		return city;

	}

	// Get a user's id

	public String getUserId(Userinfo user) {

		userCollection = connec.getRequiredCollection("Userinfo");

		String username = user.getUsername();

		String id = "id";

		FindIterable<Document> userList = userCollection.find(new Document("username", username));

		if (userList.first() != null) {

			id = userList.first().get("id").toString();

		}

		// close connection.

		connec.closeConnection();

		return id;

	}

	// Check if username already exists

	public boolean checkUsername(String username) {

		userCollection = connec.getRequiredCollection("Userinfo");

		FindIterable<Document> userList = userCollection.find(new Document("username", username));

		// close connection.
		boolean a = (userList.first() != null);
		connec.closeConnection();

		return !a;

	}

	// Check if username already exists

	public boolean checkUserExistsWithUsertype(String fname, String lname, String city) {

		userCollection = connec.getRequiredCollection("Userinfo");

		FindIterable<Document> userList = userCollection.find(new Document("fname", fname)

				.append("lname", lname).append("city", city));

		boolean a = (userList.first() != null);

		// close connection.

		connec.closeConnection();

		return a;

	}

	// Check if username already exists

	public boolean checkUserExists(String fname, String lname) {

		userCollection = connec.getRequiredCollection("Userinfo");

		FindIterable<Document> userList = userCollection.find(new Document("fname", fname).append("lname", lname));

		// close connection.

		boolean a = (userList.first() != null);
		connec.closeConnection();

		return a;

	}

	// get user infomation accordind to fname and lname

	public ArrayList<Userinfo> getUserinfo(String fname, String lname) {

		userCollection = connec.getRequiredCollection("Userinfo");

		ArrayList<Userinfo> list = new ArrayList<Userinfo>();

		Document doc = new Document("fname", fname).append("lname", lname);

		FindIterable<Document> userList = userCollection.find(doc);

		if (userList != null) {

			for (Document user : userList) {
				String itemUserId = user.get("id").toString();
				String itemUsertype = user.get("usertype").toString();
				String itemCity = user.get("city").toString();
				String itemUsername = user.get("username").toString();
				String itemPassword = user.get("password").toString();
				String itemFname = user.get("fname").toString();
				String itemLname = user.get("lname").toString();
				String itemLevel = user.get("level").toString();
				String itemGender = user.get("gender").toString();
				String itemDob = user.get("dob").toString();
				String itemPicpath = "";
				if (user.get("picpath") == null || user.get("picpath").equals("")) {
					itemPicpath = "1";
				} else {
					itemPicpath = user.get("picpath").toString();
				}
				Userinfo temp = new Userinfo();
				temp.setId(itemUserId);
				temp.setCity(itemCity);
				temp.setFname(itemFname);
				temp.setGender(itemGender);
				temp.setPassword(itemPassword);
				temp.setLevel(itemLevel);
				temp.setLname(itemLname);
				temp.setDob(itemDob);
				temp.setPicpath(itemPicpath);
				temp.setUsertype(itemUsertype);
				temp.setUsername(itemUsername);

				list.add(temp);
				// list.add(new Userinfo(itemId, itemUsertype, itemCity,
				// itemUsername,

				// itemPassword, itemFname, itemLname, itemLevel, itemGender,
				// itemDob, itemPicpath));

			}

		}

		connec.closeConnection();

		return list;

	}

	// Update table userinfo
	public boolean updateUserinfo(Userinfo user, final String userId) {
		userCollection = connec.getRequiredCollection("Userinfo");
		boolean flag = false;

		ArrayList values = new ArrayList<String>();
		values.add(user.getUsertype());
		values.add(user.getCity());
		values.add(user.getUsername());
		values.add(user.getPassword());
		values.add(user.getFname());
		values.add(user.getLname());
		values.add(user.getLevel());
		values.add(user.getGender());
		values.add(user.getDob());
		values.add(user.getPicpath());

		Document newDoc = new Document();

		for (int i = 0; i < Userinfo.getPropertities().size(); i++) {
			newDoc.append(Userinfo.getPropertities().get(i), values.get(i));
		}
		

		UpdateResult result = userCollection.updateMany(new Document("id", userId), new Document("$set", newDoc));
		flag = result.getModifiedCount() > 0;

		connec.closeConnection();
		return flag;
	}

	// Delete user from table userinfo

	public boolean deleteUser(String id) {
		System.out.println("D:" + id);
		boolean flag = false;

		userCollection = connec.getRequiredCollection("Userinfo");

		final long previousCount = userCollection.count();

		userCollection.deleteOne(new Document("id", id));

		if (userCollection.count() < previousCount) {

			flag = true;

		}

		connec.closeConnection();

		return flag;

	}

}

/*
 * 
 * 
 * 
 * 
 * 
 * 
 * 
 * temp.setId(itemId); temp.setCity(itemCity); temp.setFname(itemFname);
 * temp.setGender(itemGender); temp.setPassword(itemPassword);
 * temp.setLevel(itemLevel); temp.setLname(itemLname); temp.setDob(itemDob);
 * temp.setPicpath(itemPicpath); temp.setUsertype(itemUsertype);
 * temp.setUsername(itemUsername);
 * 
 * list.add(temp);
 * 
 * 
 * import java.sql.Connection; import java.sql.PreparedStatement; import
 * java.sql.ResultSet; import java.sql.SQLException; import java.util.ArrayList;
 * import java.util.List;
 * 
 * import com.peakcentre.web.entity.*; import
 * com.peakcentre.web.dbc.DatabaseConnection;
 * 
 * //Used for User Account related database manipulation public class
 * UserinfoDao { private DatabaseConnection dbc; private Connection conn;
 * 
 * //Check if login information correct public boolean checkLogin(Userinfo user)
 * throws Exception { dbc = new DatabaseConnection(); conn =
 * dbc.getConnection(); boolean flag = false; PreparedStatement pstmt = null;
 * try { boolean autoCommit = conn.getAutoCommit(); conn.setAutoCommit(false);
 * 
 * String sql =
 * "SELECT id FROM userinfo WHERE username=? AND password=? AND usertype=?";
 * pstmt = conn.prepareStatement(sql); String username = user.getUsername();
 * String password = user.getPassword(); String usertype = user.getUsertype();
 * pstmt.setString(1, username); pstmt.setString(2, password);
 * pstmt.setString(3, usertype); ResultSet rs = pstmt.executeQuery(); if
 * (rs.next()) { flag = true; user.setId(rs.getInt(1)); } conn.commit();
 * conn.setAutoCommit(autoCommit);
 * 
 * } catch (Exception e) { try { conn.rollback(); } catch (Exception e1) {
 * e1.printStackTrace(); } } finally { try { pstmt.close(); conn.close();
 * dbc.closeConnection(conn); } catch (Exception e) { throw e; } } return flag;
 * }
 * 
 * //Get a user's first name public String getFirstName(Userinfo user) { dbc =
 * new DatabaseConnection(); conn = dbc.getConnection(); PreparedStatement pstmt
 * = null; String fname = "user"; try { boolean autoCommit =
 * conn.getAutoCommit(); conn.setAutoCommit(false);
 * 
 * String sql = "SELECT fname FROM userinfo WHERE username=?"; pstmt =
 * conn.prepareStatement(sql); String username = user.getUsername();
 * pstmt.setString(1, username); ResultSet rs = pstmt.executeQuery(); if
 * (rs.next()) { // user.setId(rs.getInt(1)); fname = rs.getString(1); }
 * conn.commit(); conn.setAutoCommit(autoCommit);
 * 
 * } catch (Exception e) { try { conn.rollback(); } catch (Exception e1) {
 * e1.printStackTrace(); } } finally { try { pstmt.close(); conn.close();
 * dbc.closeConnection(conn); } catch (Exception e) { try { throw e; } catch
 * (Exception e1) { // TODO Auto-generated catch block e1.printStackTrace(); } }
 * } return fname; }
 * 
 * //Get a user's city public String getCity(Userinfo user) { dbc = new
 * DatabaseConnection(); conn = dbc.getConnection(); PreparedStatement pstmt =
 * null; String city = "Ottawa"; try { boolean autoCommit =
 * conn.getAutoCommit(); conn.setAutoCommit(false);
 * 
 * String sql = "SELECT city FROM userinfo WHERE username=?"; pstmt =
 * conn.prepareStatement(sql); String username = user.getUsername();
 * pstmt.setString(1, username); ResultSet rs = pstmt.executeQuery(); if
 * (rs.next()) { city = rs.getString(1); } conn.commit();
 * conn.setAutoCommit(autoCommit);
 * 
 * } catch (Exception e) { try { conn.rollback(); } catch (Exception e1) {
 * e1.printStackTrace(); } } finally { try { pstmt.close(); conn.close();
 * dbc.closeConnection(conn); } catch (Exception e) { try { throw e; } catch
 * (Exception e1) { // TODO Auto-generated catch block e1.printStackTrace(); } }
 * } return city; }
 * 
 * //Get a user's id public String getUserId(Userinfo user) { dbc = new
 * DatabaseConnection(); conn = dbc.getConnection(); PreparedStatement pstmt =
 * null; String id = "id"; try { boolean autoCommit = conn.getAutoCommit();
 * conn.setAutoCommit(false);
 * 
 * String sql = "SELECT id FROM userinfo WHERE username=?"; pstmt =
 * conn.prepareStatement(sql); String username = user.getUsername();
 * pstmt.setString(1, username); ResultSet rs = pstmt.executeQuery(); if
 * (rs.next()) { // user.setId(rs.getInt(1)); id = rs.getString(1); }
 * conn.commit(); conn.setAutoCommit(autoCommit);
 * 
 * } catch (Exception e) { try { conn.rollback(); } catch (Exception e1) {
 * e1.printStackTrace(); } } finally { try { pstmt.close(); conn.close();
 * dbc.closeConnection(conn); } catch (Exception e) { try { throw e; } catch
 * (Exception e1) { e1.printStackTrace(); } } } return id; }
 * 
 * //Check if username already exists public boolean checkUsername(String
 * username) { dbc = new DatabaseConnection(); conn = dbc.getConnection();
 * PreparedStatement pstmt = null;
 * 
 * boolean flag = true;
 * 
 * try { boolean autoCommit = conn.getAutoCommit(); conn.setAutoCommit(false);
 * 
 * String sql = "SELECT id FROM userinfo WHERE username=?"; pstmt =
 * conn.prepareStatement(sql); pstmt.setString(1, username); ResultSet rs =
 * pstmt.executeQuery(); if (rs.next()) { flag = false; } conn.commit();
 * conn.setAutoCommit(autoCommit);
 * 
 * } catch (SQLException e) { // TODO Auto-generated catch block
 * e.printStackTrace(); } finally { try { pstmt.close(); conn.close();
 * dbc.closeConnection(conn); } catch (Exception e) { try { throw e; } catch
 * (Exception e1) { // TODO Auto-generated catch block e1.printStackTrace(); } }
 * }
 * 
 * return flag;
 * 
 * }
 * 
 * //insert data into table Userinfo public boolean insertUser(Userinfo user) {
 * dbc = new DatabaseConnection(); conn = dbc.getConnection(); PreparedStatement
 * pstmt = null;
 * 
 * boolean flag = false;
 * 
 * try { boolean autoCommit = conn.getAutoCommit(); conn.setAutoCommit(false);
 * 
 * String sql =
 * "INSERT INTO userinfo(usertype,username,password,fname,lname,picpath,gender,level,dob,city) VALUES(?,?,?,?,?,?,?,?,?,?)"
 * ; pstmt = conn.prepareStatement(sql);
 * 
 * pstmt.setString(1, user.getUsertype()); pstmt.setString(2,
 * user.getUsername()); pstmt.setString(3, user.getPassword());
 * pstmt.setString(4, user.getFname()); pstmt.setString(5, user.getLname());
 * pstmt.setString(6, user.getPicpath()); pstmt.setString(7, user.getGender());
 * pstmt.setString(8, user.getLevel()); pstmt.setString(9, user.getDob());
 * pstmt.setString(10, user.getCity());
 * 
 * int rs = pstmt.executeUpdate(); if (rs > 0) { flag = true; } conn.commit();
 * conn.setAutoCommit(autoCommit);
 * 
 * } catch (SQLException e) { // TODO Auto-generated catch block
 * e.printStackTrace(); } finally { try { pstmt.close(); conn.close();
 * dbc.closeConnection(conn); } catch (Exception e) { try { throw e; } catch
 * (Exception e1) { // TODO Auto-generated catch block e1.printStackTrace(); } }
 * }
 * 
 * return flag;
 * 
 * }
 * 
 * //Get next id from table Userinfo public String getNextId() { dbc = new
 * DatabaseConnection(); conn = dbc.getConnection(); PreparedStatement pstmt =
 * null;
 * 
 * String nextId = "0";
 * 
 * String sql =
 * "SELECT AUTO_INCREMENT FROM  INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'peakcentredb' AND TABLE_NAME = 'userinfo'"
 * ; try { pstmt = conn.prepareStatement(sql); ResultSet rs =
 * pstmt.executeQuery(); if (rs.next()) { nextId = rs.getString(1); } } catch
 * (SQLException e) { // TODO Auto-generated catch block e.printStackTrace(); }
 * finally { try { pstmt.close(); conn.close(); dbc.closeConnection(conn); }
 * catch (Exception e) { try { throw e; } catch (Exception e1) { // TODO
 * Auto-generated catch block e1.printStackTrace(); } } } return nextId;
 * 
 * }
 * 
 * //Check if first name and last name exists in table userinfo public boolean
 * checkUserExists(String fname, String lname) { dbc = new DatabaseConnection();
 * conn = dbc.getConnection(); PreparedStatement pstmt = null;
 * 
 * boolean flag = false; try { boolean autoCommit = conn.getAutoCommit();
 * conn.setAutoCommit(false);
 * 
 * String sql = "SELECT id FROM userinfo WHERE fname=? AND lname=?"; pstmt =
 * conn.prepareStatement(sql); pstmt.setString(1, fname); pstmt.setString(2,
 * lname); ResultSet rs = pstmt.executeQuery(); if (rs.next()) { flag = true; }
 * conn.commit(); conn.setAutoCommit(autoCommit);
 * 
 * } catch (SQLException e) { e.printStackTrace(); } finally { try {
 * pstmt.close(); conn.close(); dbc.closeConnection(conn); } catch (Exception e)
 * { try { throw e; } catch (Exception e1) { e1.printStackTrace(); } } }
 * 
 * return flag;
 * 
 * }
 * 
 * //Check if user exist from one city public boolean
 * checkUserExistsWithUsertype(String fname, String lname, String city) { dbc =
 * new DatabaseConnection(); conn = dbc.getConnection(); PreparedStatement pstmt
 * = null;
 * 
 * boolean flag = false; try { boolean autoCommit = conn.getAutoCommit();
 * conn.setAutoCommit(false);
 * 
 * String sql = "SELECT id FROM userinfo WHERE fname=? AND lname=? AND city=?";
 * pstmt = conn.prepareStatement(sql); pstmt.setString(1, fname);
 * pstmt.setString(2, lname); pstmt.setString(3, city); ResultSet rs =
 * pstmt.executeQuery(); if (rs.next()) { flag = true; } conn.commit();
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
 * //Get User information from table userinfo public ArrayList<Userinfo>
 * getUserinfo(String fname, String lname) { dbc = new DatabaseConnection();
 * conn = dbc.getConnection(); PreparedStatement pstmt = null;
 * 
 * ArrayList<Userinfo> list = new ArrayList<Userinfo>(); try { boolean
 * autoCommit = conn.getAutoCommit(); conn.setAutoCommit(false);
 * 
 * String sql =
 * "SELECT usertype,username,fname,lname,picpath,gender,level,dob,city,password,id FROM userinfo WHERE fname=? AND lname=?"
 * ; pstmt = conn.prepareStatement(sql); pstmt.setString(1, fname);
 * pstmt.setString(2, lname); ResultSet rs = pstmt.executeQuery(); while
 * (rs.next()) { Userinfo ui = new Userinfo(); ui.setUsertype(rs.getString(1));
 * ui.setUsername(rs.getString(2)); ui.setFname(rs.getString(3));
 * ui.setLname(rs.getString(4)); ui.setPicpath(rs.getString(5));
 * ui.setGender(rs.getString(6)); ui.setLevel(rs.getString(7));
 * ui.setDob(rs.getString(8)); ui.setCity(rs.getString(9));
 * ui.setPassword(rs.getString(10)); ui.setId(rs.getInt(11)); list.add(ui); }
 * conn.commit(); conn.setAutoCommit(autoCommit);
 * 
 * } catch (SQLException e) { e.printStackTrace(); } finally { try {
 * pstmt.close(); conn.close(); dbc.closeConnection(conn); } catch (Exception e)
 * { try { throw e; } catch (Exception e1) { e1.printStackTrace(); } } } return
 * list; }
 * 
 * //Update table userinfo public boolean updateUserinfo(Userinfo user) { dbc =
 * new DatabaseConnection(); conn = dbc.getConnection(); PreparedStatement pstmt
 * = null;
 * 
 * boolean flag = false;
 * 
 * try { boolean autoCommit = conn.getAutoCommit(); conn.setAutoCommit(false);
 * 
 * String sql =
 * "UPDATE userinfo SET usertype=?,username=?,password=?,fname=?,lname=?,gender=?,level=?,dob=?,city=? WHERE id=?"
 * ; pstmt = conn.prepareStatement(sql);
 * 
 * pstmt.setString(1, user.getUsertype()); pstmt.setString(2,
 * user.getUsername()); pstmt.setString(3, user.getPassword());
 * pstmt.setString(4, user.getFname()); pstmt.setString(5, user.getLname());
 * pstmt.setString(6, user.getGender()); pstmt.setString(7, user.getLevel());
 * pstmt.setString(8, user.getDob()); pstmt.setString(9, user.getCity());
 * pstmt.setInt(10, user.getId());
 * 
 * int rs = pstmt.executeUpdate(); if (rs > 0) { flag = true; } conn.commit();
 * conn.setAutoCommit(autoCommit);
 * 
 * } catch (SQLException e) { e.printStackTrace(); } finally { try {
 * pstmt.close(); conn.close(); dbc.closeConnection(conn); } catch (Exception e)
 * { try { throw e; } catch (Exception e1) { e1.printStackTrace(); } } }
 * 
 * return flag; }
 * 
 * //Delete user from table userinfo public boolean deleteUser(int id) { dbc =
 * new DatabaseConnection(); conn = dbc.getConnection(); PreparedStatement pstmt
 * = null;
 * 
 * boolean flag = false;
 * 
 * try { boolean autoCommit = conn.getAutoCommit(); conn.setAutoCommit(false);
 * 
 * String sql = "DELETE from userinfo where id=?"; pstmt =
 * conn.prepareStatement(sql); pstmt.setInt(1, id);
 * 
 * int rs = pstmt.executeUpdate(); if (rs > 0) { flag = true; } conn.commit();
 * conn.setAutoCommit(autoCommit);
 * 
 * } catch (SQLException e) { e.printStackTrace(); } finally { try {
 * pstmt.close(); conn.close(); dbc.closeConnection(conn); } catch (Exception e)
 * { try { throw e; } catch (Exception e1) { e1.printStackTrace(); } } }
 * 
 * return flag; }
 * 
 * }
 */
