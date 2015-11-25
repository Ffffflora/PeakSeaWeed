package com.peakcentre.web.ajax;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.json.JSONArray;
import org.json.JSONObject;
import org.w3c.dom.Document;
import org.w3c.dom.Element;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;

import com.google.gson.Gson;
import com.peakcentre.web.dao.TestResultDao;
import com.peakcentre.web.dao.TestResultTemplateDao;
import com.peakcentre.web.dao.UserinfoDao;
import com.peakcentre.web.entity.TestResult;
import com.peakcentre.web.entity.Userinfo;


/**
 * Servlet implementation class AjaxGetTestResult
 */
@WebServlet("/jsp/AjaxGetTestResult")
public class AjaxGetTestResult extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AjaxGetTestResult() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		if(request.getSession(false) != null && request.getSession(false).getAttribute("id") != null) {
			response.sendRedirect("dashboard.jsp");
		} else {
			response.sendRedirect(request.getContextPath() + "/index.jsp");
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Locale locale = (Locale) request.getSession(true).getAttribute("locale");
		ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);

		//TestResultDao trdao = new TestResultDao();
		TestResultDao trdao = new TestResultDao();
		TestResult tr = new TestResult();
		
		TestResultTemplateDao tdao = new TestResultTemplateDao();

		String username = request.getParameter("username");
		String tempName = request.getParameter("tempName");
		String date = request.getParameter("date");


		String messageGetTestResult = "";
		
		int tempId = tdao.getTempIdByName(tempName);

		String html = "";
		
		int x = 1;

		try {
			//check if test result name and date exist of one user
			//boolean flag = trdao.checkNameDate(username, tempName, date);
			boolean flag = true;
			
			tr = trdao.getTestResult(username, tempId, date);
			
			Map<String, String> hm = tr.getData();
			
			//String allJson="{\"1\":'[{\"C1\":\"1\",\"C2\":\"12\",\"C3\":\"1\"},{\"C1\":\"12341\",\"C2\":\"12341\",\"C3\":\"sadf\"},{\"C1\":\"123\",\"C2\":\"qewrq\",\"C3\":\"afs\"}]',\"2\":'[{\"R1\":\"1\",\"R2\":\"11\",\"R3\":\"3\",\"R4\":\"1231\",\"R5\":\"23\"},{\"R1\":\"afd\",\"R2\":\"r2r\",\"R3\":\"1241\",\"R4\":\"gga\",\"R5\":\"sf\"}]'}";
			//JSONObject allJsonObject = new JSONObject(allJson);

			if (flag) {
				//get template xml file
				String tempPath = tdao.getTempPathByName(tempName);
				File f = new File(tempPath);

				Element element = null;
				int tableSequence = 1;
				DocumentBuilder db = null;
				DocumentBuilderFactory dbf = null;

				dbf = DocumentBuilderFactory.newInstance();
				db = dbf.newDocumentBuilder();
				Document dt = db.parse(f);
				element = dt.getDocumentElement();
				NodeList childNodes = element.getChildNodes();

				//read template xml file
				for (int n = 0; n < childNodes.getLength(); n++) {
					Node node1 = childNodes.item(n);
					//print textarea
					if ("textarea".equals(node1.getNodeName())) {
						String textarea = node1.getTextContent();
						html += "<textarea readonly class='display' rows='6'>";
						html += textarea;
						html += "</textarea>";
						html += "<br><br>";
					//print table
					} else if ("table".equals(node1.getNodeName())) {
						int row = 0;
						int column = 0;
						int numberInTotal = 0;
						String tableName = "tableName";
						ArrayList<String> th = new ArrayList<String>();

						NodeList nodeDetail = node1.getChildNodes();
						for (int j = 0; j < nodeDetail.getLength(); j++) {
							Node detail = nodeDetail.item(j);
							if ("row".equals(detail.getNodeName())) {
								row = Integer.parseInt(detail.getTextContent());
							} else if ("column".equals(detail.getNodeName())) {
								column = Integer.parseInt(detail
										.getTextContent());
							} else if ("numberInTotal".equals(detail
									.getNodeName())) {
								numberInTotal = Integer.parseInt(detail
										.getTextContent());
							} else if ("th".equals(detail.getNodeName())) {
								th.add(detail.getTextContent());
							} else if ("tableName".equals(detail.getNodeName())) {
								tableName = detail.getTextContent();
							}
						}
						html += "<p>" + tableName + "</p>";
						html += "<table class='display'>";
						html += "<thead>" + "<tr>";
						for (int c = 0; c < column; c++) {
							html += "<th>" + th.get(c) + "</th>";

						}
						html += "</tr>" + "</thead>" + "<tbody>";

						//get test result data from database
						//String s = ModelApplier.getTestResult(tempName, username, date, numberInTotal);
						//Get the JSONArray for specific table
						
						JSONArray resultArray = new JSONArray(hm.get(""+numberInTotal));
						for(int i = 0; i < resultArray.length(); i++) {
							html += "<tr>";
							JSONObject item = resultArray.getJSONObject(i);
							for(int c = 0; c < column; c++) {
								html += "<td>" + item.get(th.get(c)) +"</td>";
							}
							html += "</tr>";
						}

						html += "</tbody>";
						html += "</table>";
						html += "<br><br>";
						tableSequence++;
						
					//print graph
					} else if ("img".equals(node1.getNodeName())) {
						int tableNumber = 1;
						String imgHTML = "";
						String graphName = "graphName";

						NodeList nodeDetail = node1.getChildNodes();

						for (int j = 0; j < nodeDetail.getLength(); j++) {
							Node detail = nodeDetail.item(j);
							if ("col1".equals(detail.getNodeName())) {
								imgHTML += "<input type='hidden' id='col1_"
										+ tableNumber + "' value='"
										+ detail.getTextContent() + "'>";
							} else if ("col2".equals(detail.getNodeName())) {
								imgHTML += "<input type='hidden' id='col2_"
										+ tableNumber + "' value='"
										+ detail.getTextContent() + "'>";
							} else if ("tableNumber".equals(detail
									.getNodeName())) {
								tableNumber = Integer.parseInt(detail
										.getTextContent());
							} else if ("graphName".equals(detail.getNodeName())) {
								graphName = detail.getTextContent();
							}
						}
						html += "<p>" + graphName + "</p>";
						html += "<div id='flot-lines" + tableNumber + "'>";
						html += "</div>";
						html += imgHTML;
						html += "<br><br>";
						html += "<input type='hidden' id='tn" + x + "' value='"
								+ tableNumber + "'>";
						x++;

					}

				}
			//test result not exists
			} else {
				messageGetTestResult = resb.getString("TEST_RESULT_DOES_NOT_EXIST");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		String messageJson = new Gson().toJson(messageGetTestResult); 
		String htmlJson = new Gson().toJson(html); 
		response.setContentType("application/json"); 
		response.setCharacterEncoding("utf-8"); 
		String bothJson = "["+messageJson+","+htmlJson+"]"; //Put both objects in an array of 2 elements
		response.getWriter().write(bothJson);

	}
	
	
	/*
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Locale locale = (Locale) request.getSession(true)
				.getAttribute("locale");
		ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);

		TestResultDao trdao = new TestResultDao();
		TestResultTemplateDao tdao = new TestResultTemplateDao();

		String username = request.getParameter("username");
		String tempName = request.getParameter("tempName");
		String date = request.getParameter("date");

		String messageGetTestResult = "";

		//String fname = request.getParameter("fname");
		//String lname = request.getParameter("lname");
		//ArrayList<Userinfo> list = new ArrayList<Userinfo>();
		//UserinfoDao uidao = new UserinfoDao();
		//list = uidao.getUserinfo(fname, lname);
		//request.setAttribute("list", list);

		ArrayList<String> nameList = trdao.getTemplateNames(username);
		ArrayList<String> dateList = trdao.getDates(username);
		request.setAttribute("nameList", nameList);
		request.setAttribute("dateList", dateList);

		request.setAttribute("username", username);

		String html = "";
		int x = 1;

		try {
			//check if test result name and date exist of one user
			boolean flag = trdao.checkNameDate(username, tempName, date);

			if (flag) {
				//get template xml file
				String tempPath = tdao.getTempPathByName(tempName);
				File f = new File("/Users/sunmingyang/Documents/temp/" + tempPath);

				Element element = null;
				int tableSequence = 1;
				DocumentBuilder db = null;
				DocumentBuilderFactory dbf = null;

				dbf = DocumentBuilderFactory.newInstance();
				db = dbf.newDocumentBuilder();
				Document dt = db.parse(f);
				element = dt.getDocumentElement();
				NodeList childNodes = element.getChildNodes();

				//read template xml file
				for (int n = 0; n < childNodes.getLength(); n++) {
					Node node1 = childNodes.item(n);
					//print textarea
					if ("textarea".equals(node1.getNodeName())) {
						String textarea = node1.getTextContent();
						html += "<textarea readonly class='display' rows='6'>";
						html += textarea;
						html += "</textarea>";
						html += "<br><br>";
					//print table
					} else if ("table".equals(node1.getNodeName())) {
						int row = 0;
						int column = 0;
						int numberInTotal = 0;
						String tableName = "tableName";
						ArrayList<String> th = new ArrayList<String>();

						NodeList nodeDetail = node1.getChildNodes();
						for (int j = 0; j < nodeDetail.getLength(); j++) {
							Node detail = nodeDetail.item(j);
							if ("row".equals(detail.getNodeName())) {
								row = Integer.parseInt(detail.getTextContent());
							} else if ("column".equals(detail.getNodeName())) {
								column = Integer.parseInt(detail
										.getTextContent());
							} else if ("numberInTotal".equals(detail
									.getNodeName())) {
								numberInTotal = Integer.parseInt(detail
										.getTextContent());
							} else if ("th".equals(detail.getNodeName())) {
								th.add(detail.getTextContent());
							} else if ("tableName".equals(detail.getNodeName())) {
								tableName = detail.getTextContent();
							}
						}
						html += "<p>" + tableName + "</p>";
						html += "<table class='display'>";
						html += "<thead>" + "<tr>";
						for (int c = 0; c < column; c++) {
							html += "<th>" + th.get(c) + "</th>";

						}
						html += "</tr>" + "</thead>" + "<tbody>";

						//get test result data from database
						ArrayList<ArrayList<String>> trList = trdao.getTestResult(tempName + "Table" + tableSequence, username, date, th);

						for (int r = 0; r < row; r++) {
							html += "<tr>";
							for (int c = 0; c < column; c++) {
								html += "<td id='table" + numberInTotal + "_"
										+ th.get(c) + "_" + r + "'>"
										+ trList.get(r).get(c) + "</td>";
							}
							html += "</tr>";
						}

						html += "</tbody>";
						html += "</table>";
						html += "<br><br>";
						tableSequence++;
					//print graph
					} else if ("img".equals(node1.getNodeName())) {
						int tableNumber = 1;
						String imgHTML = "";
						String graphName = "graphName";

						NodeList nodeDetail = node1.getChildNodes();

						for (int j = 0; j < nodeDetail.getLength(); j++) {
							Node detail = nodeDetail.item(j);
							if ("col1".equals(detail.getNodeName())) {
								imgHTML += "<input type='hidden' id='col1_"
										+ tableNumber + "' value='"
										+ detail.getTextContent() + "'>";
							} else if ("col2".equals(detail.getNodeName())) {
								imgHTML += "<input type='hidden' id='col2_"
										+ tableNumber + "' value='"
										+ detail.getTextContent() + "'>";
							} else if ("tableNumber".equals(detail
									.getNodeName())) {
								tableNumber = Integer.parseInt(detail
										.getTextContent());
							} else if ("graphName".equals(detail.getNodeName())) {
								graphName = detail.getTextContent();
							}
						}
						html += "<p>" + graphName + "</p>";
						html += "<div id='flot-lines" + tableNumber + "'>";
						html += "</div>";
						html += imgHTML;
						html += "<br><br>";
						html += "<input type='hidden' id='tn" + x + "' value='"
								+ tableNumber + "'>";
						x++;

					}

				}
			//test result not exists
			} else {
				messageGetTestResult = resb.getString("TEST_RESULT_DOES_NOT_EXIST");
				//request.setAttribute("messageGetTestResult", messageGetTestResult);
				//rd = request.getRequestDispatcher("viewTestResult.jsp");
				//rd.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String messageJson = new Gson().toJson(messageGetTestResult); 
		String htmlJson = new Gson().toJson(html); 
		response.setContentType("application/json"); 
		response.setCharacterEncoding("utf-8"); 
		String bothJson = "["+messageJson+","+htmlJson+"]"; //Put both objects in an array of 2 elements
		response.getWriter().write(bothJson);
		//return printed test result html.
		//request.setAttribute("html", html);
	}
	
	*/
//-------------------------Use Mongodb----------------------------//
/*
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		Locale locale = (Locale) request.getSession(true).getAttribute("locale");
		ResourceBundle resb = ResourceBundle.getBundle("peakcentre", locale);

		TestResultDao trdao = new TestResultDao();
		TestResultTemplateDao tdao = new TestResultTemplateDao();

		String username = request.getParameter("username");
		String tempName = request.getParameter("tempName");
		String date = request.getParameter("date");

		String messageGetTestResult = "";


		String html = "";
		int x = 1;

		try {
			//check if test result name and date exist of one user
			boolean flag = trdao.checkNameDate(username, tempName, date);

			if (flag) {
				//get template xml file
				String tempPath = tdao.getTempPathByName(tempName);
				File f = new File("/Users/sunmingyang/Documents/temp/" + tempPath);

				Element element = null;
				int tableSequence = 1;
				DocumentBuilder db = null;
				DocumentBuilderFactory dbf = null;

				dbf = DocumentBuilderFactory.newInstance();
				db = dbf.newDocumentBuilder();
				Document dt = db.parse(f);
				element = dt.getDocumentElement();
				NodeList childNodes = element.getChildNodes();

				//read template xml file
				for (int n = 0; n < childNodes.getLength(); n++) {
					Node node1 = childNodes.item(n);
					//print textarea
					if ("textarea".equals(node1.getNodeName())) {
						String textarea = node1.getTextContent();
						html += "<textarea readonly class='display' rows='6'>";
						html += textarea;
						html += "</textarea>";
						html += "<br><br>";
					//print table
					} else if ("table".equals(node1.getNodeName())) {
						int row = 0;
						int column = 0;
						int numberInTotal = 0;
						String tableName = "tableName";
						ArrayList<String> th = new ArrayList<String>();

						NodeList nodeDetail = node1.getChildNodes();
						for (int j = 0; j < nodeDetail.getLength(); j++) {
							Node detail = nodeDetail.item(j);
							if ("row".equals(detail.getNodeName())) {
								row = Integer.parseInt(detail.getTextContent());
							} else if ("column".equals(detail.getNodeName())) {
								column = Integer.parseInt(detail
										.getTextContent());
							} else if ("numberInTotal".equals(detail
									.getNodeName())) {
								numberInTotal = Integer.parseInt(detail
										.getTextContent());
							} else if ("th".equals(detail.getNodeName())) {
								th.add(detail.getTextContent());
							} else if ("tableName".equals(detail.getNodeName())) {
								tableName = detail.getTextContent();
							}
						}
						html += "<p>" + tableName + "</p>";
						html += "<table class='display'>";
						html += "<thead>" + "<tr>";
						for (int c = 0; c < column; c++) {
							html += "<th>" + th.get(c) + "</th>";

						}
						html += "</tr>" + "</thead>" + "<tbody>";

						//get test result data from database
						ArrayList<ArrayList<String>> trList = trdao
								.getTestResult(tempName + "Table"
										+ tableSequence, username, date, th);

						for (int r = 0; r < row; r++) {
							html += "<tr>";
							for (int c = 0; c < column; c++) {
								html += "<td id='table" + numberInTotal + "_"
										+ th.get(c) + "_" + r + "'>"
										+ trList.get(r).get(c) + "</td>";
							}
							html += "</tr>";
						}

						html += "</tbody>";
						html += "</table>";
						html += "<br><br>";
						tableSequence++;
					//print graph
					} else if ("img".equals(node1.getNodeName())) {
						int tableNumber = 1;
						String imgHTML = "";
						String graphName = "graphName";

						NodeList nodeDetail = node1.getChildNodes();

						for (int j = 0; j < nodeDetail.getLength(); j++) {
							Node detail = nodeDetail.item(j);
							if ("col1".equals(detail.getNodeName())) {
								imgHTML += "<input type='hidden' id='col1_"
										+ tableNumber + "' value='"
										+ detail.getTextContent() + "'>";
							} else if ("col2".equals(detail.getNodeName())) {
								imgHTML += "<input type='hidden' id='col2_"
										+ tableNumber + "' value='"
										+ detail.getTextContent() + "'>";
							} else if ("tableNumber".equals(detail
									.getNodeName())) {
								tableNumber = Integer.parseInt(detail
										.getTextContent());
							} else if ("graphName".equals(detail.getNodeName())) {
								graphName = detail.getTextContent();
							}
						}
						html += "<p>" + graphName + "</p>";
						html += "<div id='flot-lines" + tableNumber + "'>";
						html += "</div>";
						html += imgHTML;
						html += "<br><br>";
						html += "<input type='hidden' id='tn" + x + "' value='"
								+ tableNumber + "'>";
						x++;

					}

				}
			//test result not exists
			} else {
				messageGetTestResult = resb.getString("TEST_RESULT_DOES_NOT_EXIST");
				//request.setAttribute("messageGetTestResult", messageGetTestResult);
				//rd = request.getRequestDispatcher("viewTestResult.jsp");
				//rd.forward(request, response);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		String messageJson = new Gson().toJson(messageGetTestResult); 
		String htmlJson = new Gson().toJson(html); 
		response.setContentType("application/json"); 
		response.setCharacterEncoding("utf-8"); 
		String bothJson = "["+messageJson+","+htmlJson+"]"; //Put both objects in an array of 2 elements
		response.getWriter().write(bothJson);
		//return printed test result html.
		//request.setAttribute("html", html);
	}
 */
//-------------------------Use Mongodb----------------------------//
}
