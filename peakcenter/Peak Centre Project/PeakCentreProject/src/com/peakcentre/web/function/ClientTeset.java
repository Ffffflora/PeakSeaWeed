package com.peakcentre.web.function;

import java.net.URI;
import java.util.*;

import javax.ws.rs.client.*;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;

import org.glassfish.jersey.client.ClientConfig;

import com.google.gson.Gson;

import com.peakcentre.web.entity.*;


public class ClientTeset {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		Userinfo ui = new Userinfo();
		ui.setUsertype("Administrator");
		ui.setUsername("222@a.com");
		ui.setPassword("2223");
		System.out.println("Test login : " + ModelApplier.checkLogin(ui));
	}

}
