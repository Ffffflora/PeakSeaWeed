<!doctype html>
<html lang="en">
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.peakcentre.web.entity.Userinfo"%>
<head>
<meta charset="utf-8">
<title>PeakCentre - Delete User Account</title>
<link rel="shortcut icon" href="../image/favicon.png">
<!---CSS Files-->
<link rel="stylesheet" href="../css/master.css">
<link rel="stylesheet" href="../css/tables.css">
<!---jQuery Files-->
<script src="../js/jquery-1.7.1.min.js"></script>
<script src="../js/jquery-ui-1.8.17.min.js"></script>
<script src="../js/styler.js"></script>
<script src="../js/jquery.tipTip.js"></script>
<script src="../js/colorpicker.js"></script>
<script src="../js/sticky.full.js"></script>
<script src="../js/global.js"></script>
<script src="../js/flot/jquery.flot.min.js"></script>
<script src="../js/flot/jquery.flot.resize.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<!---Fonts-->
<%
	HttpSession session2 = request.getSession(false); 
	if(session2.getAttribute("id")==null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
    }
%>
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Ubuntu:500'
	rel='stylesheet' type='text/css'>

<%
	Locale locale = Locale.ENGLISH;
	ResourceBundle resb = ResourceBundle
	.getBundle("peakcentre", locale);
	request.getSession(true).setAttribute("locale", locale);
%>
</head>
<body>

	<!--- HEADER -->

	<div class="header">
		<img src="../image/logo.png" alt="Logo" height="50" /></a>

	</div>

	<div class="top-bar">
		<ul id="nav">
			<li id="user-panel"><img
				src="http://localhost:8080/PeakCentreProject/pic/<%=session.getAttribute("id")%>.jpg"
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
							src="../image/nav/dash.png" alt="" />
							<p>Main Page</p></a></li>

					<li class="nav-item"><a><img src="../image/nav/anlt.png"
							alt="" />
							<p>Test Result</p></a>
						<ul class="sub-nav">
							<%
								String usertype = session.getAttribute("usertype").toString();
																		if ("administrator".equals(usertype) || "coach".equals(usertype)) {
							%>
							<li><a href="addTestResult.jsp">Add</a></li>
							<li><a href="modifyTestResult.jsp">Modify</a></li>
							<li><a href="viewTestResult.jsp">View</a></li>
							<%
								} else if ("athlete".equals(usertype)) {
							%>
							<li><a href="viewTestResultForAthlete.jsp">View</a></li>
							<%
								}
							%>
						</ul></li>
					<li class="nav-item"><a><img src="../image/nav/cal.png"
							alt="" />
							<p>Training Plan</p></a>
						<ul class="sub-nav">
							<%
								if ("administrator".equals(usertype) || "coach".equals(usertype)) {
							%>
							<li><a href="addTrainingPlan.jsp">Add</a></li>
							<li><a href="modifyTrainingPlan.jsp">Modify</a></li>
							<li><a href="viewTrainingPlan.jsp">View</a></li>
							<%
								} else if ("athlete".equals(usertype)) {
							%>
							<li><a href="viewTrainingPlan.jsp">View</a></li>
							<%
								}
							%>
						</ul></li>
					<li class="nav-item"><a><img src="../image/nav/tb.png"
							alt="" />
							<p>Workout</p></a>
						<ul class="sub-nav">
							<%
								if ("administrator".equals(usertype) || "coach".equals(usertype)) {
							%>
							<li><a href="viewWorkout.jsp">View</a></li>
							<%
								} else if ("athlete".equals(usertype)) {
							%>
							<li><a href="addWorkout.jsp">Add</a></li>
							<li><a href="viewWorkout.jsp">View</a></li>
							<%
								}
							%>
						</ul></li>
					<li class="nav-item"><a><img
							src="../image/nav/dash-active.png" alt="" />
							<p>User Account</p></a>
						<ul class="sub-nav">
							<%
								if ("administrator".equals(usertype)) {
							%>
							<li><a href="createUser.jsp">Create</a></li>
							<li><a href="modifyUser.jsp">Modify</a></li>
							<li><a href="deleteUser.jsp">Delete</a></li>
							<%
								} else if ("coach".equals(usertype)) {
							%>
							<li><a href="createUser.jsp">Create</a></li>
							<li><a href="modifyUser.jsp">Modify</a></li>
							<li><a href="manageAthlete.jsp">Manage</a></li>
							<%
								} else if ("athlete".equals(usertype)) {
							%>
							<li><a href="modifyUserForAthlete.jsp">Modify</a></li>
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
							<li><a href="createTestResultTemp.jsp">Create</a></li>
							<li><a href="deleteTestResultTemp.jsp">Delete</a></li>
						</ul></li>
					<%
						} else if ("coach".equals(usertype)) {
					%>
					<li class="nav-item"><a><img src="../image/nav/icn.png"
							alt="" />
							<p>TR Template</p></a>
						<ul class="sub-nav">
							<li><a href="createTestResultTemp.jsp">Create</a></li>
						</ul></li>
					<%
						}
					%>
				</ul>
			</li>
		</ul>
	</div>

	<!--- CONTENT AREA -->
	<div class="content container_12">
		<div class="ad-notif-success grid_12 small-mg">
			<p>Delete User</p>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>User Profile Search</h2>
			</div>
			<form method="post" action="">
				<input type="hidden" value="delete" name="page" />
				<div class="box-content">
					<div class="form-row">
						<p><%=resb.getString("PLEASE_ENTER_USER_NAME_TO_DELETE")%></p>
					</div>
					<br><br>
					<div class="form-row">
						<label class="form-label">First Name</label>
						<div class="form-item">
							<input type="text" name="fname" required />
						</div>
					</div>
					<div class="form-row">
						<label class="form-label">Last Name</label>
						<div class="form-item">
							<input type="text" name="lname" required />
						</div>
					</div>
					<div class="form-row">
						<div class="form-item" id="errmessage">
							<%
								if (request.getAttribute("message") != null) {
							%>
							<p style="color: #ff6666; font-size: 11px"><%=request.getAttribute("message")%></p>
							<%
								}
							%>
						</div>
					</div>
					<div class="form-row" style="text-align: right;">
						<input type="button" id="userProfileSearch" class="button green" value="search">
					</div>
				</div>
			</form>
		</div>

		<%
			if(request.getAttribute("list") != null){
		%>
		<div class="box grid_4" id="confirmUser" title="User Selection">
			<%
				}else{
			%>
			<div class="box grid_4" id="confirmUser" title="User Selection"
				style="display: none">
				<%
					}
				%>

				<div class="box-head">
					<h2>User Profile</h2>
				</div>
				<form id="deleteUser_form" method="post" action="DeleteUserServlet">
					<div class="box-content">
						<div class="form-row">
							<p><%=resb.getString("PLEASE_CHOOSE_USER_TO_DELETE")%></p>
						</div>
						<br>
						<div class="form-row">
							<div class="form-item" id="hiddenPart">
								<select name="userlist">
									<%
										if (request.getAttribute("list") != null) {
											int i=0;
											ArrayList<Userinfo> list = (ArrayList<Userinfo>)request.getAttribute("list");
											for (Userinfo ui : list) {
									%>
									<option value=<%=i++%>><p><%=ui.getFname()%>&nbsp;<%=ui.getLname()%>&nbsp;&nbsp;<%=ui.getUsername()%>&nbsp;&nbsp;<%=ui.getCity()%></p>
									</option>

									<%
										}}
									%>
								</select>
								<%
									if (request.getAttribute("list") != null) {
										int i=0;
										ArrayList<Userinfo> list = (ArrayList<Userinfo>)request.getAttribute("list");
								%>
								<input name="fname" type="hidden"
									value=<%=list.get(0).getFname()%> /> <input name="lname"
									type="hidden" value=<%=list.get(0).getLname()%> />
								<%
									}
								%>
							</div>
						</div>
						<div class="form-row" style="text-align: right;">
							<input type="button" class="button green" id="open-dialog"
								value="delete">
						</div>
					</div>

				</form>
			</div>
		</div>
	</div>

	<div id="dialog" title="Comfirmation">
		<div>
			<p><%=resb.getString("SURE_TO_DELETE")%></p>
		</div>
		<div class="form-row" style="text-align: left;">
			<input type="button" class="button green" value="yes"
				onclick="del();"> 
				<input type="button" class="button green"
				value="no"
				onclick="$(this).closest('.ui-dialog-content').dialog('close');" />

		</div>
	</div>

	<div class="footer">
		<p>© Peak Centre. All rights reserved.</p>
	</div>

	<script>
	$('#userProfileSearch').click(function(){
		$("#errmessage").html("");
		var post = {
			fname : $("input[name=fname]").val(),
			lname : $("input[name=lname]").val(),
			page: $('input[name=page]').val()
		};
		console.log("fname : " + post.fname);
		console.log("lanme : " + post.lname);
		$.post('AjaxSearchUser',post, function(data){
			console.log(data);
			var message = data[0];
			var list = data[1];
			if(message == "") {
				var innerHtml = "";
				for(var i in list) {
					innerHtml = innerHtml + "<option value=" + i + ">" + 
					list[i].fname + " " +list[i].lname + " " + list[i].username + " " + list[i].city + "</option>";
				}
				var hiddenpart = "<input name='fname' type='hidden' value='" + list[0].fname + "' >" +
				"<input name='lname' type='hidden' value='" + list[0].lname + "' >";
				console.log("InnerHTML : " + innerHtml);
				$("select[name=userlist]").html(innerHtml);
				$("#hiddenPart").append(hiddenpart);
				$("#confirmUser").css({display:'block'});
				//document.getElementById("userProfile").style.display="block";
			} else {
				$("#errmessage").html("<p style='color: #ff6666; font-size: 11px'>"+message+"</p>");
				$("input[name=fname]").val("");
				$("input[name=lname]").val("");
			}
		});
	});
		$("#dialog").dialog({
			autoOpen : false,
			resizable : false,
			modal : true
		});

		$("#open-dialog").click(function() {
			$("#dialog").dialog("open");
			return false;
		});
		function del() {
			document.getElementById("deleteUser_form").submit();
			$("#dialog").dialog("close");
		}
	</script>
</body>
</html>