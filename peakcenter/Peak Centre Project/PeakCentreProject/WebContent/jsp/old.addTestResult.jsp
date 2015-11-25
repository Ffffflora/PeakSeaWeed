<!doctype html>
<html lang="en">
<%@ page import="com.peakcentre.web.dbc.DatabaseConnection"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.peakcentre.web.entity.Userinfo"%>
<head>
<meta charset="utf-8">
<title>PeakCentre - Add Test Result</title>
<link rel="shortcut icon" href="../image/favicon.png">
<!---CSS Files-->
<link rel="stylesheet" href="../css/master.css">
<link rel="stylesheet" href="../css/tables.css">
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
	if(session2 == null || session2.getAttribute("id")==null){
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

					<li class="nav-item"><a><img
							src="../image/nav/anlt-active.png" alt="" />
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
							<li><a href="testresultViewTestResultForAthlete.jsp">View</a></li>
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
			<p>Add Test Result</p>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>User Profile Search</h2>
			</div>
			<form method="post" id="userSearch_Form" action="">
				<input type="hidden" value="addTestResult" name="page" />
				<div class="box-content">
					<div class="form-row">
						<p><%=resb.getString("PLEASE_ENTER_USER_NAME_TO_ADD_TEST_RESULT")%></p>
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
						<!-- <input type="button" id="open-dialog" class="button green"
							value="delete"> -->
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
				<form id="addTestResult_form" method="post" action="">
					<div class="box-content">
						<div class="form-row">
							<p><%=resb.getString("PLEASE_CHOOSE_USER_TO_ADD_TEST_RESULT")%></p>
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
						<div class="form-row">
							<p><%=resb.getString("PLEASE_CHOOSE_TEMPLATE_AND_DATE")%></p>
						</div>
						<br>
						<div class="form-row">
							<label class="form-label">Template</label>
							<div class="form-item">
								<select name="templateName">
									<%
										//get all test result template names from database
										final DatabaseConnection dbc = new DatabaseConnection();;
										final Connection conn = dbc.getConnection();
										PreparedStatement pstmt = null;
										String sql = "SELECT name FROM TestResultTemplate";
										pstmt = conn.prepareStatement(sql);
										ResultSet rs = pstmt.executeQuery();
										while (rs.next()) {
									%>
									<option value=<%=rs.getString("name")%>><%=rs.getString("name")%></option>
									<%
										}
									%>
								</select>
							</div>
						</div>
						<div class="form-row">
							<label class="form-label">Date</label>
							<div class="form-item">
								<input type="text" id="datepicker" name="date" required />
							</div>
						</div>
						<div class="form-row" style="text-align: right;">
							<input type="button" id="getTestResultTemplate" class="button green" value="start">
						</div>
					</div>

				</form>

			</div>
			<div class="box grid_12">
				<div class="box-head">
					<h2>Test Result</h2>
				</div>
				<form method="post" id='myForm' action="SaveTestResultServlet">
					<%
						if(request.getAttribute("html")!=null){
					%>
					<div class="box-content" id="field">
						<%
							}else{
						%>
						<div class="box-content" id="field" style="display: none">
							<%
								}
							%>
							<div id="divtext1">
								<%=request.getAttribute("html")%>

							</div>
							<%
								if(request.getAttribute("html")!=null){
							%>
							<div class="form-row" id="field2" style="text-align: right;">
								<%
									}else{
								%>

								<div class="form-row" id="field2" style="display: none; text-align: right;">
									<%
										}
									%>
									<input type="submit" class="button green" value="save">
									<button type="button" class="button green" onclick="getAllJson()">Test Submit Json</button>
								</div>
							</div>
				</form>

			</div>
		</div>
		<div class="footer">
			<p>© Peak Centre. All rights reserved.</p>
		</div>

		<script type="text/javascript"
			src="https://www.google.com/jsapi?autoload={
            'modules':[{
              'name':'visualization',
              'version':'1',
              'packages':['corechart']
            }]
          }"></script>
		<script type="text/javascript"
			src="http://canvg.googlecode.com/svn/trunk/rgbcolor.js"></script>
		<script type="text/javascript"
			src="http://canvg.googlecode.com/svn/trunk/canvg.js"></script>
		<script>
		//-------------------------------------------------//
		
		
		//--------test add and remove row-----------------//
		 $("#addARow").click(function () {
			 var i = 0;
		     $("table tbody tr:first").clone().find("input").each(function () {
		         $(this).val('').attr({
		             'id': function (_, id) {
		                 return id + i
		             },
		                 'name': function (_, name) {
		                 return name + i
		             },
		                 'value': ''
		         });
		     }).end().appendTo("table");
		     i++;
		     console.log("Heere!");
		 });
		 $(document).on('click', 'button.removebutton', function () {
		     $(this).closest('tr').remove();
		     return false;
		 });
		 $(document).on('click', 'li.addarow', function () {
			 var i = 0;
		     $(this).parent().next().find("tbody tr:first").clone().find("input").each(function () {
		         $(this).val('').attr({
		             'id': function (_, id) {
		                 return id + i
		             },
		                 'name': function (_, name) {
		                 return name + i
		             },
		                 'value': ''
		         });
		         
		     }).end().appendTo($(this).parent().next());
		     i++;
		     return false;
		 });
		//--------test add and remove row-----------------//
		<%
		if ("administrator".equals(usertype)) {
		%>
		$('#userProfileSearch').click(function(){
			$("#errmessage").html("");
			var post = {
				fname : $("#userSearch_Form").find("input[name=fname]").val(),
				lname : $("#userSearch_Form").find("input[name=lname]").val(),
				page: $("#userSearch_Form").find('input[name=page]').val()
			};
			$.post('AjaxSearchUser',post, function(data){
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
					document.getElementById("confirmUser").style.display="block";
				} else {
					$("#errmessage").html("<p style='color: #ff6666; font-size: 11px'>"+message+"</p>");
					$("#userSearch_Form").find("input[name=fname]").val("");
					$("#userSearch_Form").find("input[name=lname]").val("");
					$("#confirmUser").css({display:'none'});
					$("#field").css({display:'none'});
					$("#field2").css({display:'none'});
					$("#addTestResult_form").find("input[name=date]").val("");
					$("#divtext1").html("");
				}
			});
		});
		//
		$('#getTestResultTemplate').click(function(){
			var post = {
					userlist: $("select[name=userlist]").val(),
					templateName: $("select[name=templateName]").val(),
					fname: $("#addTestResult_form").find("input[name=fname]").val(),
					lname: $("#addTestResult_form").find("input[name=lname]").val(),
					date: $("#addTestResult_form").find("input[name=date]").val()
			}
			console.log(post.date);
			$.post('AjaxGetTestResultTemplate',post,function(data){
				//console.log("Get : " + data);
				$("#divtext1").html(data);
				$("#field").css({display:'block'});
				$("#field2").css({display:'block'});
				
				$("#addARow").click(function () {
					 var i = 0;
				     $(this).parent().next().find("tbody tr:first").clone().find("input").each(function () {
				         $(this).val('').attr({
				             'id': function (_, id) {
				                 return id + i
				             },
				                 'name': function (_, name) {
				                 return name + i
				             },
				                 'value': ''
				         });
				         
				     }).end().appendTo($(this).parent().next());
				     i++;
				 });

			});
		});
		<%  } %>
		//-------------------------------------//
		function getAllJson() {
			var AllData=[];
			var allTable=$("#divtext1").find("table");
			var table ={};
			for(var i=0;i<allTable.length;i++) {
				var dataArray = [];
				var allTh = $(allTable[i]).find("th");
				var headLength = allTh.length;
				var allTr = $(allTable[i]).find("tr");
				for(var m=1; m<allTr.length; m++) {
					var data={};
					for(var j=1; j < headLength; j++) {
						data[$(allTh[j]).html()] = $(allTr[m]).find("td:eq("+j+") input").val();
						//console.log("Here:" + $(allTh[j]).html());
					}
					dataArray.push(data);	
				}
				table[i] = JSON.stringify(dataArray);
			}
			//alert(JSON.stringify(AllData));
			var post ={
					data: JSON.stringify(AllData),
					username:$('input[name=username]').val(),
					tempId:$('input[name=tempId]').val(),
					templateName:$('input[name=templateName]').val(),
					date:$('input[name=date]').val()
			};
			$('<input type="hidden" name="data"/>').val(JSON.stringify(table)).appendTo('#myForm');
			$('#myForm').submit();
		}
		//-------------------------------------//
		/*------------------------------------------------------------------------------*/
		/*-----------------------------------------------------------------------------*/

			//generate graph base on data user entered
			function generateGraph(tableNumber) {
				document.getElementById("generateButton" + tableNumber).value = "refresh graph";
				var col1Title = document.getElementById("col1_" + tableNumber).value;
				var col2Title = document.getElementById("col2_" + tableNumber).value;

				var data1 = [];
				var data2 = [];


				for (var i = 0; i < 20; i++) {
					if (document.getElementById(col1Title + "_" + i)) {
						data1
								.push(document.getElementById(col1Title + "_"
										+ i).value);

					}
					if (document.getElementById(col2Title + "_" + i)) {
						data2
								.push(document.getElementById(col2Title + "_"
										+ i).value);
					}

				}

				google.setOnLoadCallback(drawChart());

				function drawChart() {
					var data = new google.visualization.DataTable();
					data.addColumn('number');
					data.addColumn('number');

					for (var i = 0; i < data1.length; i++) {
						data.addRow([ parseInt(data1[i]), parseInt(data2[i]) ]);

					}
					var options = {
						legend : {
							position : 'none'
						},
						series : {
							0 : {
								color : '#a1b900',
								lineWidth : 10
							},
						},
						width : 500,
						height : 300,
						hAxis : {
							title : col1Title
						},
						vAxis : {
							title : col2Title
						},
					};

					var chart = new google.visualization.LineChart(document
							.getElementById('flot-lines' + tableNumber));
					chart.draw(data, options);
				}
			}

			$("#datepicker").datepicker({
				showMonthAfterYear : true,
				changeYear : true,
				changeMonth : true,
				numberOfMonths : 1,
				yearRange : "2014:2015"

			});
		</script>
</body>
</html>