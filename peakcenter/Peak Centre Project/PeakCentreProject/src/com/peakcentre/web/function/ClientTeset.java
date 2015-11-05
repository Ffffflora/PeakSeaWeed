package com.peakcentre.web.function;

import java.net.URI;
import java.util.*;

import javax.ws.rs.client.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;

import org.glassfish.jersey.client.ClientConfig;

import com.google.gson.Gson;
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.*;


public class ClientTeset {

	/*
	 * private String usertype;
	private String city;
	private String username;
	private String password;
	private String fname;
	private String lname;
	private String level;
	private String gender;
	private String dob;
	private String picpath;

	 */
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		UserinfoDao doDao = new UserinfoDao();
		Userinfo ui = new Userinfo();
		ui.setCity("Ottawa");
		ui.setUsertype("Athlete");
		ui.setUsername("ath2");
		ui.setPassword("123");
		ui.setFname("ath2");
		ui.setLname("ath2");
		ui.setLevel("level");
		ui.setGender("female");
		doDao.insertUser(ui);
//	
		System.out.println("id is " + doDao.getUserId(ui));
	}

}
