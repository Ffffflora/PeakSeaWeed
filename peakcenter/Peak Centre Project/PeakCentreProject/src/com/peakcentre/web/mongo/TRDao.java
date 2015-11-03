package com.peakcentre.web.mongo;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.Map;
import java.util.List;

import org.bson.Document;

import com.mongodb.Block;
import com.mongodb.client.FindIterable;
import com.mongodb.client.MongoCollection;
import com.peakcentre.web.entity.TestResult;

public class TRDao {
	/*
	MongoDBConnection conn = new MongoDBConnection();
	MongoCollection<Document> trCollection;
	
	//insertTestResult
	public void insertTestResult(TREntity tr) {
		Map<String, String> hm = tr.getData();
		//Connect to the Collection(Table)
		trCollection = conn.getRequiredCollection("TestResult");
		List<Document> l = new ArrayList<Document>();
		
		Iterator it = hm.entrySet().iterator();
		while(it.hasNext()) {
			Map.Entry<String, String> e = (Map.Entry<String, String>)it.next();
			Document doc = new Document("username",tr.getUsername())
			.append("date", tr.getDate())
			.append("tempId", tr.getTempId())
			.append("table", e.getKey())
			.append("data", e.getValue());
			l.add(doc);
		}
		//insert to mongodb
		trCollection.insertMany(l);
		
		//Close the Connection
		conn.closeConnection();
	}
	
	public TestResult getTestResult(String username, int tempId, String date) {
		final TestResult result = new TestResult();
		//Connect to the Collection(Table)
		trCollection = conn.getRequiredCollection("TestResult");
		
		result.setDate(date);
		result.setTempId(tempId);
		result.setUsername(username);
		FindIterable<Document> iterable = trCollection.find(new Document("username",username).append("tempId", tempId).append("date", date));
		
		iterable.forEach(new Block<Document>() {
			@Override
			public void apply(Document document) {
				System.out.println("Document: " + document);
				result.setData((String)document.get("table"), (String)document.get("data"));
			}
		});
		
		//Close the Connection
		conn.closeConnection();
		
		return result;
	}
	
	public void updateTestResult(TREntity tr) {
		//Connect to the Collection(Table)
		trCollection = conn.getRequiredCollection("TestResult");
		
		String username = tr.getUsername();
		int tempId = tr.getTempId();
		String date = tr.getDate();
		Map<String, String> hm = tr.getData();
		
		Iterator it = hm.entrySet().iterator();
		
		while(it.hasNext()) {
			Map.Entry<String, String> e = (Map.Entry<String, String>)it.next();
			trCollection.updateOne(new Document("username", username).append("date", date).append("tempId", tempId).append("table", e.getKey()), new Document("$set", new Document("data", e.getValue())));
		}
		
		//Close the Connection
		conn.closeConnection();
		
	}
	*/
	
}
