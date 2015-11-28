package com.peakcentre.web.dao;

import java.util.ArrayList;
import org.bson.Document;
import com.peakcentre.web.entity.*;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.mongodb.client.result.UpdateResult;
import com.peakcentre.web.mongo.*;

import Util.peakcentreUtil;

//Used for User Account related database manipulation
public class UserinfoDao {

	MongoDBConnection connec = new MongoDBConnection();

	MongoCollection<Document> userCollection;

	// insert data into table Userinfo updated
	public boolean insertUser(final Userinfo userinfo) {
		System.out.println("haha");
		Boolean flag = false;
		// connect to database
		userCollection = connec.getRequiredCollection("Userinfo");
		final long previousCount = userCollection.count();
		
		Document doc = new Document("usertype", userinfo.getUsertype()).append("city", userinfo.getCity())
				.append("username", userinfo.getUsername()).append("password", userinfo.getPassword())
				.append("fname", userinfo.getFname()).append("lname", userinfo.getLname())
				.append("level", userinfo.getLevel()).append("gender", userinfo.getGender())
				.append("dob", userinfo.getDob()).append("picpath", userinfo.getPicpath());

		System.out.print(doc.toString());
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

	// Check if user is correct by comparing userinfo
	public boolean checkLogin(final Userinfo userinfo) {
		try {
			return this.checkLogin(userinfo.getUsername(), userinfo.getPassword(), userinfo.getUsertype());
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return false;
	}

	// Check if user is correct by comparing username, password and usertype.
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

	// Get a user's one attribute.
	private String getAttribute(final Userinfo userinfo, final String attribute) {
		userCollection = connec.getRequiredCollection("Userinfo");
		final String username = userinfo.getUsername();
		final String usertype = userinfo.getUsertype();

		String fname = "user";

		FindIterable<Document> userList = userCollection
				.find(new Document("username", username).append("usertype", usertype));
		if (userList.first() != null) {
			fname = userList.first().get(attribute).toString();
		}

		// close connection.
		connec.closeConnection();

		return fname != null ? fname : "NA";

	}

	// check user exists by using given attribute.
	private boolean checkIfUserExist(final Document doc) {
		userCollection = connec.getRequiredCollection("Userinfo");
		FindIterable<Document> userList = userCollection.find(doc);

		// close connection.
		boolean userExist = (userList.first() != null);
		connec.closeConnection();
		return userExist;
	}

	// Get a user's first name
	public String getFirstName(final Userinfo user) {
		return getAttribute(user, "fname");
	}

	// Get a user's city
	public String getCity(final Userinfo user) {
		return getAttribute(user, "city");

	}

	// Get a user's id
	public String getUserId(Userinfo user) {
		// do we really need a method to get user id??
		return getAttribute(user, "id");
	}

	// Check if username already exists
	public boolean checkExistByUsername(final String username) {
		return checkIfUserExist(new Document("username", username));
	}

	// Check if user exists by user id
	public boolean checkExistByUserId(final String userId) {
		return checkIfUserExist(new Document("id", userId));
	}

	// Check if user exists by fname, lname and city
	public boolean checkExistsByFnameAndLnameAndCity(String fname, String lname, String city) {
		return checkIfUserExist(new Document("fname", fname).append("lname", lname).append("city", city));
	}

	// Check if user exists by username and usertype
	public boolean checkExistsByUsernameAndType(final String username, final String userType) {
		return checkIfUserExist(new Document("username", username).append("usertype", userType));
	}

	// Check if user exists by fname and lname
	public boolean checkExistsByFnameAndLname(String fname, String lname) {
		return checkIfUserExist(new Document("fname", fname).append("lname", lname));
	}

	// get userinfo according to Document
	private ArrayList<Userinfo> getUserinfoByDoc(final Document doc) {
		userCollection = connec.getRequiredCollection("Userinfo");

		ArrayList<Userinfo> list = new ArrayList<Userinfo>();

		FindIterable<Document> userList = userCollection.find(doc);

		if (userList != null) {

			for (Document user : userList) {
				// convert to userinfo with values in user(Document).
				list.add(peakcentreUtil.setValuesForUserByDoc(user));
			}
		}
		connec.closeConnection();
		return list;
	}

	// Get userinfo according to userId
	public Userinfo getUserinfoById(final String userid) {
		return getUserinfoByDoc(new Document("id", userid)).get(0);
	}

	// get userinfo according to fname and lname
	public ArrayList<Userinfo> getUserinfoByFnameAndLname(String fname, String lname) {
		return getUserinfoByDoc(new Document("fname", fname).append("lname", lname));
	}

	// get userinfo according to username
	public ArrayList<Userinfo> getUserinfoByUsername(final String username) {
		return getUserinfoByDoc(new Document("username", username));
	}
	
	//get userinfo according to username and usertype
	public Userinfo getUserinfoByUsernameAndType(final String username, final String type){
		return getUserinfoByDoc(new Document("username", username).append("usertype", type)).get(0);
	}

	// Update table userinfo
	public boolean updateUserinfo(final Userinfo newUser, final String username, final String usertype) {
		userCollection = connec.getRequiredCollection("Userinfo");
		boolean flag = false;

		ArrayList<String> values = new ArrayList<String>();
		values.add(newUser.getUsertype());
		values.add(newUser.getCity());
		values.add(newUser.getUsername());
		values.add(newUser.getPassword());
		values.add(newUser.getFname());
		values.add(newUser.getLname());
		values.add(newUser.getLevel());
		values.add(newUser.getGender());
		values.add(newUser.getDob());
		values.add(newUser.getPicpath());

		Document newDoc = new Document();

		// add all new input attributes into a new document.
		for (int i = 0; i < Userinfo.getPropertities().size(); i++) {
			newDoc.append(Userinfo.getPropertities().get(i), values.get(i));
		}

		UpdateResult result = userCollection.updateMany(new Document("username", username).append("usertype", usertype),
				new Document("$set", newDoc));
		flag = result.getModifiedCount() > 0;

		connec.closeConnection();
		return flag;
	}

	// get arraylist<usertype> according to username
	public ArrayList<String> getUsertypeListByUsername(final String username){
		ArrayList<Userinfo> userList = getUserinfoByDoc(new Document("username", username));
		ArrayList<String> typeList = new ArrayList<>();
		for (Userinfo user : userList) {
			typeList.add(user.getUsertype());
		}
		return typeList;
	}
	
	// Delete user from table userinfo
	public boolean deleteUser(final String username, final String usertype) {
		boolean flag = false;
		userCollection = connec.getRequiredCollection("Userinfo");
		final long previousCount = userCollection.count();
		userCollection.deleteOne(new Document("username", username).append("usertype", usertype));
		if (userCollection.count() < previousCount) {
			flag = true;
		}
		connec.closeConnection();
		return flag;
	}
}