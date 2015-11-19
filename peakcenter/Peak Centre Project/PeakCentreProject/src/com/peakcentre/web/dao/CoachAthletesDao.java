package com.peakcentre.web.dao;

import java.util.ArrayList;
import org.bson.Document;
import com.mongodb.BasicDBObject;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.peakcentre.web.entity.Userinfo;
import com.peakcentre.web.mongo.MongoDBConnection;


public class CoachAthletesDao {
	MongoDBConnection connec = new MongoDBConnection();
	MongoCollection<Document> athletesCollection;
	UserinfoDao uiDao = new UserinfoDao();

	// insert data into TestResult Table
	public void insertAthlete(String athId, String coachId) {
		boolean userExist = uiDao.checkUserExistsWithUserId(athId) && uiDao.checkUserExistsWithUserId(coachId);
		if (!userExist) {
			return;
		}
		UserinfoDao userinfoDao = new UserinfoDao();
		final String athName = userinfoDao.getUserinfoById(athId).getUsername();
		final String coaName = userinfoDao.getUserinfoById(coachId).getUsername();
		// Connect to the Collection(Table)
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		// insert to mongodb
		athletesCollection.insertOne(new Document("athId", athId)
				.append("coachId", coachId)
				.append("coachName", athName)
				.append("athName", athName));
		// Close the Connection
		connec.closeConnection();
	}

	public ArrayList<String> getAtheltesNames(String coachId) {
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		FindIterable<Document> athIdList = athletesCollection.find(new Document("coachId", coachId));

		ArrayList<String> nameList = new ArrayList<>();
		if (athIdList != null) {
			for (Document document : athIdList) {
				String athName = uiDao.getUserinfoById(document.get("id").toString()).getUsername();
				nameList.add(athName);
			}
		}

		connec.closeConnection();
		return nameList;
	}

	public ArrayList<Userinfo> getAtheltes(String coachId) {
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		FindIterable<Document> athIdList = athletesCollection.find(new Document("coachId", coachId));

		ArrayList<Userinfo> athList = new ArrayList<>();
		if (athIdList != null) {
			for (Document document : athIdList) {
				Userinfo athlete = uiDao.getUserinfoById(document.get("id").toString());
				athList.add(athlete);
			}
		}

		connec.closeConnection();
		return athList;
	}

	public boolean deleteRelationship(final String coachId, final String athId) {
		boolean flag = false;
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		final long previousCount = athletesCollection.count();
		Document doc = new Document("coachId", coachId).append("athId", athId);
		athletesCollection.deleteOne(doc);
		if (athletesCollection.count() < previousCount) {
			flag = true;
		}
		connec.closeConnection();
		return flag;
	}

	public boolean checkRelationshipExists(final String coachId, final String athId) {
		boolean flag = false;
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		Document doc = new Document("coachId", coachId).append("athId", athId);
		FindIterable<Document> relationshipList = athletesCollection.find(doc);
		flag = (relationshipList.first() != null);
		connec.closeConnection();
		return flag;
	}
	
	public ArrayList<Userinfo> getAllathByPage(final String coachId, int pageSize, int pageIndex) {
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		UserinfoDao uiDao = new UserinfoDao();
		BasicDBObject sort = new BasicDBObject();
		sort.put("athName", 1);
		FindIterable<Document> cursor = athletesCollection.find(new Document("coachId", coachId))
				.sort(sort).skip(pageIndex * pageSize).limit(pageSize);
		ArrayList<Userinfo> athListByPage = new ArrayList<>();
		for (Document doc : cursor) {
			if (doc != null) {
				UserinfoDao userinfoDao = new UserinfoDao();
				athListByPage.add(userinfoDao.getUserinfoById(doc.get("athId").toString()));
			}
		}
		return athListByPage;
	}
	
	public int getTotalPage(final int pageSize, final String coachId){
		athletesCollection = connec.getRequiredCollection("CoachAthletes");
		FindIterable<Document> athList = athletesCollection.find(new Document("coachId", coachId));
		int totalPage = 0;
		for (Document document : athList) {
			totalPage++;
		}
		return (totalPage%pageSize==0)?(totalPage/pageSize):(totalPage/pageSize+1);  
	}

}
