package com.peakcentre.web.mongo;


import com.peakcentre.web.entity.Userinfo;
import com.peakcentre.web.dao.UserinfoDao;

public class TestMongo {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Userinfo ui = new Userinfo();
		UserinfoDao ud = new UserinfoDao();
		
		ui.setCity("ottawa");
		ui.setDob("01/01/2015");
		ui.setFname("my");
		ui.setGender("male");
		ui.setLevel("Entry");
		ui.setLname("s");
		ui.setPassword("222");
		ui.setPicpath("1");
		ui.setUsername("222@a.com");
		ui.setUsertype("Administrator");
		
		System.out.println("Result : " + ud.checkUsername("t"));
	}

}
