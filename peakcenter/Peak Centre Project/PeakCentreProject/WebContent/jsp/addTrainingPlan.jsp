<!doctype html>
<html lang="en">
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="com.peakcentre.web.entity.Userinfo"%>
<head>
<meta charset="utf-8">
<title>PeakCentre - Add Training Plan</title>
<link rel="shortcut icon" href="../image/favicon.png">
<!---CSS Files-->
<link rel="stylesheet" href="../css/master.css">
<link rel="stylesheet" href="../css/tables.css">
<link rel="stylesheet" type='text/css' href="../css/fullcalendar.css" />
<!---jQuery Files-->
<script src="../js/jquery-1.7.1.min.js"></script>
<script src="../js/jquery-ui-1.8.17.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<script src="../js/jquery.jeditable.js"></script>
<script src="../js/jquery.dataTables.editable.js"></script>
<script src="../js/styler.js"></script>
<script src="../js/jquery.tipTip.js"></script>
<script src="../js/colorpicker.js"></script>
<script src="../js/sticky.full.js"></script>
<script src="../js/global.js"></script>
<script src="../js/fullcalendar/fullcalendar.min.js"></script>
<%
	HttpSession session2 = request.getSession(false); 
	if(session2.getAttribute("id")==null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
    }
%>
<!---Fonts-->
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
		<!-- <a href="dashboard.jsp"> -->
		<img src="../image/logo.png" alt="Logo" height="50" /></a>
	</div>

	<div class="top-bar">
		<ul id="nav">
			<li id="user-panel"><img
				src="http://localhost:8080/pic/<%=session.getAttribute("id")%>.jpg"
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
					<li class="nav-item"><a><img
							src="../image/nav/cal-active.png" alt="" />
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
					<li class="nav-item"><a><img src="../image/nav/dash.png"
							alt="" />
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
			<p>Add Training Plan</p>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>User Profile Search</h2>
			</div>

			<form method="post" action="">
				<input type="hidden" value="addTrainingPlan" name="page" />
				<div class="box-content">
					<div class="form-row">
						<p><%=resb
					.getString("PLEASE_ENTER_USERNAME_NAME_TO_ADD_PLAN")%></p>
					</div>
					<br> <br>
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
						<div class="form-item" id ="errmessage">
							<%
								if (request.getAttribute("message") != null) {
							%>
							<p style="color: #ff6666; font-size: 11px" id = "errmessage"><%=request.getAttribute("message")%></p>
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
		<form method="post" action="SaveTrainingPlanServlet">
			<%
				if(request.getAttribute("list") != null){
			%>
			<div class="box grid_4">
				<%
					}else{
				%>
				<div class="box grid_4" id="userProfile" style="display: none">
					<%
						}
					%>

					<div class="box-head">
						<h2>User Profile</h2>
					</div>
					<div class="box-content">
						<div class="form-row">
							<p><%=resb.getString("PLEASE_CHOOSE_USER_TO_ADD_TRAINING_PLAN")%></p>
						</div>
						<br>

						<div class="form-row">
							<div class="form-item" id="usernameForm">
								<select name="userlist">
									
									<%
										if (request.getAttribute("list") != null) {
											int i=0;
											ArrayList<Userinfo> list = (ArrayList<Userinfo>)request.getAttribute("list");
											for (Userinfo ui : list) {
									%>
									<option value=<%=ui.getUsername()%>><p><%=ui.getFname()%>&nbsp;<%=ui.getLname()%>&nbsp;&nbsp;<%=ui.getUsername()%>&nbsp;&nbsp;<%=ui.getCity()%></p>
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
						<div class="form-row">
							<p><%=resb.getString("PLEASE_ENTER_DATE_TO_ADD_PLAN")%></p>
						</div>
						<br>
						<div class="form-row">
							<label class="form-label">Start Date</label>
							<div class="form-item">
								<input type="text" class="datepicker" id="startdate"
									name="startdate" required />
							</div>
						</div>
						<div class="form-row">
							<label class="form-label">End Date</label>
							<div class="form-item">
								<input type="text" class="datepicker" id="enddate"
									name="enddate" required />
							</div>
						</div>
						<div class="form-row">
							<div class="form-item">
								<p id="message" style="color: #ff6666; font-size: 11px"></p>
							</div>
						</div>
						<div class="form-row" style="text-align: right;">
							<input type="button" class="button green" value="start"
								onclick="showTable()" />
						</div>
					</div>
				</div>

				<div id="div1" class="box grid_12" style="display: none"></div>
				<div class="box grid_12">
					<div id="div2" class="box grid_12" style="display: none">
						<div class="form-row" style="text-align: right;">
							<input type="submit" class="button green" value="save">
						</div>
					</div>
				</div>
		</form>
	</div>

	<div class="footer">
		<p>© Peak Centre. All rights reserved.</p>
	</div>
	
	<script>
	<%
	if ("administrator".equals(usertype)) {
	%>
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
				$("#usernameForm").append(hiddenpart);
				document.getElementById("userProfile").style.display="block";
			} else {
				$("#errmessage").html("<p style='color: #ff6666; font-size: 11px'>"+message+"</p>");
				$("input[name=fname]").val("");
				$("input[name=lname]").val("");
			}
		});
	});
	<%  } %>
	/*------------------------------------------------------------------------------*/
	/*-----------------------------------------------------------------------------*/
	/*----------------------------------------------------------------------------*/
	/*---------------------------------------------------------------------------*/
	/*--------------------------------------------------------------------------*/
	/*-------------------------------------------------------------------------*/
	
	
		//generate table base on data user entered
		function showTable() {
			var i = "";
			var startdate = new Date(
					document.getElementsByName("startdate")[0].value);
			var startdate2 = startdate;
			var enddate = new Date(
					document.getElementsByName("enddate")[0].value);
			enddate.setDate(enddate.getDate() + 1);

			//check empty
			if (document.getElementById("startdate").value == ""
					|| document.getElementById("enddate").value == "") {
				document.getElementById("message").innerHTML = "Start Date or End Date could not be empty.";

			} else {
				document.getElementById("message").innerHTML = "";
				var perWeek = 24 * 60 * 60 * 1000 * 7;
				//get total weeks
				var weeks = Math.ceil((enddate.valueOf() - startdate.valueOf())
						/ perWeek);
				//get mod days
				var mod = (enddate.valueOf() - startdate.valueOf()) % perWeek
						/ (24 * 60 * 60 * 1000);

				var table = "";
				for (i = 0; i < weeks; i++) {
					if ((i == (weeks - 1)) && (mod != 0)) {
						table += '<input type="hidden" name="weeks" value="'+weeks+'">';
						table += '<div class="box grid_12">';
						table += '<div class="box-head">'
								+ '<h2>Training Plan - Week' + (i + 1)
								+ '</h2>' + '</div>'
								+ '<div class="box-content no-pad">';
						table += '<ul class="table-toolbar">';
						table += '<li onClick="clickAddZoneLastTable('
								+ String(i)
								+ ','
								+ mod
								+ ')">'
								+ '<a>'
								+ '<img src="../image/icons/basic/plus.png" alt=""/>'
								+ ' Add Zone' + '</a>' + '</li>' + '</ul>';
						table += '<table id="myDataTable' + String(i) + '">';

						var weekday = new Array(7);
						weekday[0] = "Sunday";
						weekday[1] = "Monday";
						weekday[2] = "Tuesday";
						weekday[3] = "Wednesday";
						weekday[4] = "Thursday";
						weekday[5] = "Friday";
						weekday[6] = "Saturday";

						table += '<thead>' + '<tr>' + '<th></th>';
						for (var d = 0; d < mod; d++) {
							table += '<th>' + weekday[startdate2.getDay()]
									+ '</th>';
							startdate2.setDate(startdate2.getDate() + 1);

						}
						table += '</tr>';
						enddate.setDate(enddate.getDate() - mod - 1);

						table += '<tr>' + '<th>Zone</th>';
						for (var d = 0; d < mod; d++) {
							table += '<th>'
									+ new Date(enddate.setDate(enddate
											.getDate() + 1)).format("MM/dd")
									+ '</th>';

						}

						table += '</tr>' + '</thead>' + '<tbody>' + '<tr>';
						table += '<td><textarea style="width: 10px; height: 15px;" name="text" required></textarea></td>';
						for (var d = 0; d < mod; d++) {
							table += '<td><textarea rows="3" name="text" required></textarea></td>';

						}

						table += '</tr>' + '</tbody>';
						table += '</table>';
						table += '</div>' + '</div>';
						startdate.setDate(startdate.getDate() + 1);

					} else {
						table += '<div class="box grid_12">';
						table += '<div class="box-head">'
								+ '<h2>Training Plan - Week' + (i + 1)
								+ '</h2>' + '</div>'
								+ '<div class="box-content no-pad">';
						table += '<ul class="table-toolbar">';
						table += '<li onClick="clickAddZone('
								+ String(i)
								+ ')">'
								+ '<a>'
								+ '<img src="../image/icons/basic/plus.png" alt=""/>'
								+ ' Add Zone' + '</a>' + '</li>' + '</ul>';
						table += '<table id="myDataTable' + String(i) + '">';

						var weekday = new Array(7);
						weekday[0] = "Sunday";
						weekday[1] = "Monday";
						weekday[2] = "Tuesday";
						weekday[3] = "Wednesday";
						weekday[4] = "Thursday";
						weekday[5] = "Friday";
						weekday[6] = "Saturday";

						var startWeekday1 = weekday[startdate.getDay()];
						startdate.setDate(startdate.getDate() + 1);
						var startWeekday2 = weekday[startdate.getDay()];
						startdate.setDate(startdate.getDate() + 1);
						var startWeekday3 = weekday[startdate.getDay()];
						startdate.setDate(startdate.getDate() + 1);
						var startWeekday4 = weekday[startdate.getDay()];
						startdate.setDate(startdate.getDate() + 1);
						var startWeekday5 = weekday[startdate.getDay()];
						startdate.setDate(startdate.getDate() + 1);
						var startWeekday6 = weekday[startdate.getDay()];
						startdate.setDate(startdate.getDate() + 1);
						var startWeekday7 = weekday[startdate.getDay()];

						table += '<thead>' + '<tr>' + '<th></th>' + '<th>'
								+ startWeekday1 + '</th>' + '<th>'
								+ startWeekday2 + '</th>' + '<th>'
								+ startWeekday3 + '</th>' + '<th>'
								+ startWeekday4 + '</th>' + '<th>'
								+ startWeekday5 + '</th>' + '<th>'
								+ startWeekday6 + '</th>' + '<th>'
								+ startWeekday7 + '</th>' + '</tr>';

						startdate.setDate(startdate.getDate() - 6);

						table += '<tr>'
								+ '<th>Zone</th>'
								+ '<th>'
								+ startdate.format("MM/dd")
								+ '</th>'
								+ '<th>'
								+ new Date(startdate.setDate(startdate
										.getDate() + 1)).format("MM/dd")
								+ '</th>'
								+ '<th>'
								+ new Date(startdate.setDate(startdate
										.getDate() + 1)).format("MM/dd")
								+ '</th>'
								+ '<th>'
								+ new Date(startdate.setDate(startdate
										.getDate() + 1)).format("MM/dd")
								+ '</th>'
								+ '<th>'
								+ new Date(startdate.setDate(startdate
										.getDate() + 1)).format("MM/dd")
								+ '</th>'
								+ '<th>'
								+ new Date(startdate.setDate(startdate
										.getDate() + 1)).format("MM/dd")
								+ '</th>'
								+ '<th>'
								+ new Date(startdate.setDate(startdate
										.getDate() + 1)).format("MM/dd")
								+ '</th>';

						table += '</tr>' + '</thead>';
						table += '<tbody>'
								+ '<tr>'
								+ '<td><textarea style="width: 10px; height: 15px;" name="text" required></textarea></td>'
								+ '<td><textarea rows="3" name="text" required></textarea></td>'
								+ '<td><textarea rows="3" name="text" required></textarea></td>'
								+ '<td><textarea rows="3" name="text" required></textarea></td>'
								+ '<td><textarea rows="3" name="text" required></textarea></td>'
								+ '<td><textarea rows="3" name="text" required></textarea></td>'
								+ '<td><textarea rows="3" name="text" required></textarea></td>'
								+ '<td><textarea rows="3" name="text" required></textarea></td>'
								+ '</tr>';
						table += '</tbody>';
						table += '</table>';
						table += '</div>' + '</div>';
						startdate.setDate(startdate.getDate() + 1);
					}
				}

				table += '<div class="box grid_12">';
				table += '<div class="box-head">'
						+ '<h2>Training Plan - ST1</h2>' + '</div>'
						+ '<div class="box-content no-pad">';
				table += '<ul class="table-toolbar">';
				
				table += '<li onClick="clickAddRowST1()">' + '<a>'
						+ '<img src="../image/icons/basic/plus.png" alt=""/>'
						+ ' Add Row' + '</a>' + '</li>' + '</ul>';
				table += '<table id="ST1DataTable">';

				table += '<thead>' + '<tr>' + '<th>No.</th>'
						+ '<th>Exercise</th>' + '<th>Sets</th>'
						+ '<th>Reps</th>' + '<th>Tempo</th>' + '<th>Rest</th>'
						+ '</tr>' + '</thead>';
				table += '<tbody>' + '<tr>' + '<td></td>' + '<td></td>'
						+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
						+ '</tr>';
				table += '</tbody>';
				table += '</table>';
				table += '</div>' + '</div>';
				i++;

				table += '<div class="box grid_12">';
				table += '<div class="box-head">'
						+ '<h2>Training Plan - ST2</h2>' + '</div>'
						+ '<div class="box-content no-pad">';
				table += '<ul class="table-toolbar">';
				table += '<li onClick="clickAddRowST2()">' + '<a>'
						+ '<img src="../image/icons/basic/plus.png" alt=""/>'
						+ ' Add Row' + '</a>' + '</li>' + '</ul>';
				table += '<table id="ST2DataTable">';
				table += '<thead>' + '<tr>' + '<th>No.</th>'
						+ '<th>Exercise</th>' + '<th>Sets</th>'
						+ '<th>Reps</th>' + '<th>Tempo</th>' + '<th>Rest</th>'
						+ '</tr>' + '</thead>';
				table += '<tbody>' + '<tr>' + '<td></td>' + '<td></td>'
						+ '<td></td>' + '<td></td>' + '<td></td>' + '<td></td>'
						+ '</tr>';
				table += '</tbody>';
				table += '</table>';
				table += '</div>' + '</div>';
				i++;

				table += '<div class="box grid_12">';
				table += '<div class="box-head">'
						+ '<h2>Training Plan - Flexibility Training</h2>'
						+ '</div>' + '<div class="box-content no-pad">';
				table += '<ul class="table-toolbar">';
				table += '<li onClick="clickAddRowFT()">' + '<a>'
						+ '<img src="../image/icons/basic/plus.png" alt=""/>'
						+ ' Add Row' + '</a>' + '</li>' + '</ul>';
				table += '<table id="FTDataTable">';
				table += '<thead>' + '<tr>' + '<th>Stretching Exercise</th>'
						+ '<th>Sets</th>' + '<th>Hold (in sec)</th>' + '</tr>'
						+ '</thead>';
				table += '<tbody>' + '<tr>' + '<td></td>' + '<td></td>'
						+ '<td></td>' + '</tr>';
				table += '</tbody>';
				table += '</table>';
				table += '</div>' + '</div>';
				document.getElementById("div1").innerHTML = table;
				document.getElementById("div1").style.display = "block";
				document.getElementById("div2").style.display = "block";
			}

			$("#ST1DataTable").dataTable({
				sDom : 't',
				bLengthChange : false,
				bFilter : false,
				bPaginate : false,
				bSort : false
			}).makeEditable({
				sUpdateURL : function(value, settings) {
					return (value);
				},
				oEditableSettings : {
					event : 'click'
				}

			});
			$("#ST2DataTable").dataTable({
				sDom : 't',
				bLengthChange : false,
				bFilter : false,
				bPaginate : false,
				bSort : false
			}).makeEditable({
				sUpdateURL : function(value, settings) {
					return (value);
				},
				oEditableSettings : {
					event : 'click'
				}

			});
			$("#FTDataTable").dataTable({
				sDom : 't',
				bLengthChange : false,
				bFilter : false,
				bPaginate : false,
				bSort : false
			}).makeEditable({
				sUpdateURL : function(value, settings) {
					return (value);
				},
				oEditableSettings : {
					event : 'click'
				}

			});

		}

		//add one more row
		function clickAddZone(o) {
			$('#myDataTable' + String(o) + ' tr:last')
					.after(
							'<tr><td><textarea style="width: 10px; height: 15px;" name="text"></textarea></td>'
									+ '<td><textarea rows="3" name="text"></textarea></td>'
									+ '<td><textarea rows="3" name="text"></textarea></td>'
									+ '<td><textarea rows="3" name="text"></textarea></td>'
									+ '<td><textarea rows="3" name="text"></textarea></td>'
									+ '<td><textarea rows="3" name="text"></textarea></td>'
									+ '<td><textarea rows="3" name="text"></textarea></td>'
									+ '<td><textarea rows="3" name="text"></textarea></td></tr>');

		}
		function clickAddZoneLastTable(o, mod) {
			var tds = '';
			for (var i = 0; i < mod; i++) {
				tds += '<td><textarea rows="3" name="text"></textarea></td>';

			}
			$('#myDataTable' + String(o) + ' tr:last')
					.after(
							'<tr><td><textarea style="width: 10px; height: 15px;" name="text"></textarea></td>'
									+ tds + '</tr>');

		}
		function clickAddRowST1() {

			$('#ST1DataTable').dataTable()
					.fnAddData([ "", "", "", "", "", "" ]);
			$('#ST1DataTable').dataTable().find('td').editable(function(v, s) {
				console.log(v);
				return (v);
			});
		}
		function clickAddRowST2() {

			$('#ST2DataTable').dataTable()
					.fnAddData([ "", "", "", "", "", "" ]);
			$('#ST2DataTable').dataTable().find('td').editable(function(v, s) {
				console.log(v);
				return (v);
			});
		}
		function clickAddRowFT() {

			$('#FTDataTable').dataTable().fnAddData([ "", "", "" ]);
			$('#FTDataTable').dataTable().find('td').editable(function(v, s) {
				console.log(v);
				return (v);
			});
		}
		$(".datepicker").datepicker({
			showMonthAfterYear : true,
			changeYear : true,
			changeMonth : true,
			numberOfMonths : 1,
			yearRange : "2010:2020"

		});

		Date.prototype.format = function(format) {
			var o = {
				"M+" : this.getMonth() + 1, //month
				"d+" : this.getDate(), //day
			};
			if (/(y+)/.test(format))
				format = format.replace(RegExp.$1, (this.getFullYear() + "")
						.substr(4 - RegExp.$1.length));
			for ( var k in o)
				if (new RegExp("(" + k + ")").test(format))
					format = format.replace(RegExp.$1,
							RegExp.$1.length == 1 ? o[k] : ("00" + o[k])
									.substr(("" + o[k]).length));
			return format;
		};
	</script>
</body>
</html>