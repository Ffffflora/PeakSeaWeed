package com.peakcentre.web.function;

import java.net.URI;
import java.util.*;

import javax.ws.rs.client.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;

import org.glassfish.jersey.client.ClientConfig;

import com.google.gson.Gson;
import com.peakcentre.web.dao.CoachAthletesDao;
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.*;

public class ClientTeset {

	/*
	 * private String usertype; private String city; private String username;
	 * private String password; private String fname; private String lname;
	 * private String level; private String gender; private String dob; private
	 * String picpath;
	 * 
	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
//		UserinfoDao doDao = new UserinfoDao();
//		Userinfo ui = new Userinfo();
//		 ui.setCity("Ottawa");
//		 ui.setUsertype("Athlete");
//		 ui.setUsername("a5");
//		 ui.setPassword("123");
//		 ui.setFname("a5");
//		 ui.setLname("a5");
//		 ui.setLevel("level");
//		 ui.setGender("female");
//		 doDao.insertUser(ui);
		CoachAthletesDao coachAthletesDao = new CoachAthletesDao();
		coachAthletesDao.insertAthlete("563d72056541710d568fda17", "563c15216541710acf0d8a97");
		coachAthletesDao.insertAthlete("563c15486541710ad129db69", "563c15216541710acf0d8a97");
		coachAthletesDao.insertAthlete("563c15526541710ad217c1ee", "563c15216541710acf0d8a97");
		coachAthletesDao.insertAthlete("563c15636541710ad30c56c7", "563c15216541710acf0d8a97");
		coachAthletesDao.insertAthlete("563c159b6541710ad48674b3", "563c15216541710acf0d8a97");
		coachAthletesDao.insertAthlete("563c159b6541710ad48674b5", "563c15216541710acf0d8a97");
		
	
		////
		// doDao.getUserinfoById("563aa2b9654171076124a2dc");
		// System.out.println("user is " +
		//// doDao.getUserinfoById("563aa2b9654171076124a2dc").getUsername());
//		CoachAthletesDao coachAthletesDao = new CoachAthletesDao();
//		ArrayList<Userinfo> test = coachAthletesDao.getAllathByPage("563c15216541710acf0d8a97", 3, 1);
//		for (Userinfo userinfo : test) {
//			System.out.println("user is " + userinfo.getUsername());
//		}
	}

}
