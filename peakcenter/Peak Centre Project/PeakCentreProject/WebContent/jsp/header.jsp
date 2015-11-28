<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>

	<!--- HEADER -->

	<div class="header">
		<img src="../image/logo.png" alt="Logo" height="50" />
	<div class="styler">
			<ul class="styler-show">
				<li><div id="colorSelector-top-bar"></div></li>
				<li><div id="colorSelector-box-head"></div></li>
			</ul>
		</div>  
	</div>

	<div class="top-bar">
		<ul id="nav">
			<li id="user-panel"><img
				src="http://localhost:8080/pic/<%=session.getAttribute("username").hashCode()%>.jpg"
				id="usr-avatar" alt="" />
				<div id="usr-info">
					<p id="usr-name">
						Welcome back,
						<%=session.getAttribute("fname")%>.
					</p>
					<form method="post" action="LogoutServlet">
						<p>
							<a href="#" onclick="$(this).closest('form').submit()">Logout</a>
						</p>
					</form>
				</div></li>
			<li>
				<ul id="top-nav">
					<li class="nav-item"><a href="dashboard.jsp"><img
							src="../image/nav/dash.png" id="mainPage" alt="" />
							<p>Main Page</p></a></li>

					<li class="nav-item"><a><img src="../image/nav/anlt.png"
							id="testResult" alt="" />
							<p>Test Result</p></a>
						<ul class="sub-nav">
							<%
								String usertype = session.getAttribute("usertype").toString();
								if ("administrator".equals(usertype) || "coach".equals(usertype)) {
							%>
							<li><a href="testresultAddTestResult.jsp">Add</a></li>
							<li><a href="testresultModifyTestResult.jsp">Modify</a></li>
							<li><a href="testresultViewTestResult.jsp">View</a></li>
							<%
								} else if ("athlete".equals(usertype)) {
							%>
							<li><a href="testresultViewTestResultForAthlete.jsp">View</a></li>
							<%
								}
							%>
						</ul></li>
					<li class="nav-item"><a><img src="../image/nav/cal.png"
							id="trainingPlan" alt="" />
							<p>Training Plan</p></a>
						<ul class="sub-nav">
							<%
								if ("administrator".equals(usertype) || "coach".equals(usertype)) {
							%>
							<li><a href="trainingplanAddTrainingPlan.jsp">Add</a></li>
							<li><a href="trainingplanModifyTrainingPlan.jsp">Modify</a></li>
							<li><a href="trainingplanViewTrainingPlan.jsp">View</a></li>
							<%
								} else if ("athlete".equals(usertype)) {
							%>
							<li><a href="trainingplanViewTrainingPlan.jsp">View</a></li>
							<%
								}
							%>
						</ul></li>
					<li class="nav-item"><a><img
							src="../image/nav/tb.png" id="workout" alt="" />
							<p>Workout</p></a>
						<ul class="sub-nav">
							<%
								if ("administrator".equals(usertype) || "coach".equals(usertype)) {
							%>
							<li><a href="workoutViewWorkout.jsp">View</a></li>
							<%
								} else if ("athlete".equals(usertype)) {
							%>
							<li><a href="workoutAddWorkout.jsp">Add</a></li>
							<li><a href="workoutViewWorkout.jsp">View</a></li>
							<%
								}
							%>
						</ul></li>
					<li class="nav-item"><a><img src="../image/nav/dash.png"
							id="userAccount" alt="" />
							<p>User Account</p></a>
						<ul class="sub-nav">
							<%
								if ("administrator".equals(usertype)) {
							%>
							<li><a href="useraccountCreateUser.jsp">Create</a></li>
							<li><a href="useraccountModifyUser.jsp">Modify</a></li>
							<li><a href="useraccountDeleteUser.jsp">Delete</a></li>
							<%
								} else if ("coach".equals(usertype)) {
							%>
							<li><a href="useraccountCreateUser.jsp">Create</a></li>
							<li><a href="useraccountModifyUser.jsp">Modify</a></li>
							<li><a href="useraccountManageAthlete.jsp">Manage</a></li>
							<%
								} else if ("athlete".equals(usertype)) {
							%>
							<li><a href="useraccountModifyUserForAthlete.jsp">Modify</a></li>
							<%
								}
							%>
						</ul></li>
					<%
						if ("administrator".equals(usertype)) {
					%>
					<li class="nav-item"><a><img src="../image/nav/icn.png"
							alt="" />
							<p>TR Template</p></a>
						<ul class="sub-nav">
							<li><a href="templateCreateTestResultTemp.jsp">Create</a></li>
							<li><a href="templateDeleteTestResultTemp.jsp">Delete</a></li>
						</ul></li>
					<%
						} else if ("coach".equals(usertype)) {
					%>
					<li class="nav-item"><a><img src="../image/nav/icn.png"
							alt="" />
							<p>TR Template</p></a>
						<ul class="sub-nav">
							<li><a href="templateCreateTestResultTemp.jsp">Create</a></li>
						</ul></li>
					<%
						}
					%>
				</ul>
			</li>
		</ul>
	</div>


	<script type="text/javascript">
		window.onload = function() {
			var currentLocation = window.location.toString();
			var ifMatch = currentLocation.indexOf("workout") >= 0;
			if (currentLocation.indexOf("dashboard") >= 0) {
				document.getElementById("mainPage").src = "../image/nav/dash-active.png";
				document.getElementById("testResult").src = "../image/nav/anlt.png";
				document.getElementById("workout").src = "../image/nav/tb.png";
				document.getElementById("trainingPlan").src = "../image/nav/cal.png";
				document.getElementById("userAccount").src = "../image/nav/dash.png";
			}else if (currentLocation.indexOf("useraccount") >= 0) {
				document.getElementById("mainPage").src = "../image/nav/dash.png";
				document.getElementById("testResult").src = "../image/nav/anlt.png";
				document.getElementById("workout").src = "../image/nav/tb.png";
				document.getElementById("trainingPlan").src = "../image/nav/cal.png";
				document.getElementById("userAccount").src = "../image/nav/dash-active.png";
			}else if (currentLocation.indexOf("testresult") >= 0) {
				document.getElementById("mainPage").src = "../image/nav/dash.png";
				document.getElementById("testResult").src = "../image/nav/anlt-active.png";
				document.getElementById("workout").src = "../image/nav/tb.png";
				document.getElementById("trainingPlan").src = "../image/nav/cal.png";
				document.getElementById("userAccount").src = "../image/nav/dash.png";
			}else if (currentLocation.indexOf("trainingplan") >= 0) {
				document.getElementById("mainPage").src = "../image/nav/dash.png";
				document.getElementById("testResult").src = "../image/nav/anlt.png";
				document.getElementById("workout").src = "../image/nav/tb.png";
				document.getElementById("trainingPlan").src = "../image/nav/cal-active.png";
				document.getElementById("userAccount").src = "../image/nav/dash.png";
			}else if (currentLocation.indexOf("workout") >= 0) {
				document.getElementById("mainPage").src = "../image/nav/dash.png";
				document.getElementById("testResult").src = "../image/nav/anlt.png";
				document.getElementById("workout").src = "../image/nav/tb-active.png";
				document.getElementById("trainingPlan").src = "../image/nav/cal.png";
				document.getElementById("userAccount").src = "../image/nav/dash.png";
			}

		}
	</script>

</body>
</html>