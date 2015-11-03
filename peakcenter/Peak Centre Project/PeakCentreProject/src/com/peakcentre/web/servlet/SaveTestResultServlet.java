package com.peakcentre.web.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Iterator;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.*;

import com.peakcentre.web.dao.TestResultDao;
import com.peakcentre.web.entity.TestResult;
import com.peakcentre.web.mongo.TRDao;
import com.google.gson.*;

/**
 * Servlet implementation class SaveTestResultServlet
 */
@WebServlet("/jsp/SaveTestResultServlet")
public class SaveTestResultServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SaveTestResultServlet() {
		super();
	}
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getSession(false) != null && request.getSession(false).getAttribute("id") != null) {
			response.sendRedirect("dashboard.jsp");
		} else {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}
	}
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//TestResult tr = new TestResult();
		TestResult tr = new TestResult();
		TestResultDao trd = new TestResultDao();
		
		String username = request.getParameter("username");
		String tempId = request.getParameter("tempId");
		String templateName = request.getParameter("templateName");
		String date = request.getParameter("date");
		String data = request.getParameter("data");
		
		tr.setUsername(username);
		tr.setTempId(Integer.parseInt(tempId));
		tr.setDate(date);
		
		JSONObject dataJson;
		try {
			dataJson = new JSONObject(data);
			// this parses the json
			Iterator it = dataJson.keys(); //gets all the keys

			while(it.hasNext())
			{
				String key = (String)it.next();
				String value = (String)dataJson.get(key);
				System.out.println(key+"<------->"+value);
				tr.setData(key,value);
			}
			
			
		} catch (JSONException e) {
			e.printStackTrace();
		}

		//ModelApplier.insertTestResultTable(tr);
		trd.insertTestResult(tr);

		response.sendRedirect("dashboard.jsp");
	}

	
	/*
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		HttpSession session = request.getSession(true);
		RequestDispatcher rd = null;
		TestResultDao trdao = new TestResultDao();
		TestResult tr = new TestResult();

		String username = request.getParameter("username");
		String tempId = request.getParameter("tempId");
		String templateName = request.getParameter("templateName");
		String date = request.getParameter("date");
		tr.setUsername(username);
		tr.setTempId(Integer.parseInt(tempId));
		tr.setDate(date);

		int totalTable = Integer.parseInt(request.getParameter("totalTable"));

		//insert data into table TestResult
		trdao.insertTestResult(tr);

		JSONObject jObj;
		try {
			System.out.println(request.getParameter("data"));
			jObj = new JSONObject(request.getParameter("data"));
		  // this parses the json
		Iterator it = jObj.keys(); //gets all the keys

		while(it.hasNext())
		{
			String key = (String)it.next();
			String o = (String)jObj.get(key);
			System.out.println(""+key+"---"+o);
		    //String key = it.next(); // get key
		    //Object o = jObj.get(key); // get value
		    //session.putValue(key, o); // store in session
		}
		} catch (JSONException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		
		for (int i = 0; i < totalTable; i++) {
			ArrayList<ArrayList<String>> data = new ArrayList<ArrayList<String>>();
			//get column names
			ArrayList<String> ths = (ArrayList<String>) session.getAttribute("ths" + String.valueOf(i + 1));
			data.add(ths);
			String tableName = templateName + "Table" + String.valueOf(i + 1);
			int rows = Integer.parseInt(request.getParameter("table"
					+ String.valueOf(i + 1) + "Row"));
			int columns = Integer.parseInt(request.getParameter("table"
					+ String.valueOf(i + 1) + "Column"));
			//get user input test result data
			for (int r = 0; r < rows; r++) {
				ArrayList<String> s0 = new ArrayList<String>();
				for (int c = 0; c < columns; c++) {

					s0.add(request.getParameter("table" + (i + 1) + "row" + r
							+ "column" + c));

				}
				data.add(s0);
			}

			//insert data into template table
			//trdao.insertTestResultTable(username, tableName, date, data);

		}
		response.sendRedirect("dashboard.jsp");
	}
	*/
}
