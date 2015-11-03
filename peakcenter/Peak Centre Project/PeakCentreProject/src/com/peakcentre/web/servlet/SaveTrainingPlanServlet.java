package com.peakcentre.web.servlet;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.peakcentre.web.dao.TrainingPlanDao;
import com.peakcentre.web.entity.TrainingPlan;

/**
 * Servlet implementation class SaveTrainingPlanServlet
 */
@WebServlet("/jsp/SaveTrainingPlanServlet")
public class SaveTrainingPlanServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public SaveTrainingPlanServlet() {
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
	protected void doPost(HttpServletRequest request,
			HttpServletResponse response) throws ServletException, IOException {
		String username = request.getParameter("userlist");
		String startdate = request.getParameter("startdate");
		String enddate = request.getParameter("enddate");
		
		TrainingPlanDao tpdao = new TrainingPlanDao();
		TrainingPlan tp = new TrainingPlan();
		tp.setUsername(username);
		tp.setStartdate(startdate);
		tp.setEnddate(enddate);
		
		
		int tpid = tpdao.getCurrentTrainingPlanId();
		
		int weeks = Integer.parseInt(request.getParameter("weeks"));
		
		
		
		
	}

}
