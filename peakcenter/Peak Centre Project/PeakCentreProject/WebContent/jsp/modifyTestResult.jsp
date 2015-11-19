<!doctype html>
<html lang="en">
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%@ page import="com.peakcentre.web.dbc.DatabaseConnection"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.peakcentre.web.entity.Userinfo"%>
<head>
<meta charset="utf-8">
<title>PeakCentre - Modify Test Result</title>
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
		<!-- <a href="dashboard.jsp"> -->
		<img src="../image/logo.png" alt="Logo" height="50" /></a>
	</div>

	<div class="top-bar">
		<ul id="nav">
			<li id="user-panel">
				<!-- <img src="../image/nav/running.png"
				id="usr-avatar" alt="" /> --> <img
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
				</div>
			</li>
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
			<p>Modify Test Result</p>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>User Profile Search</h2>
			</div>
			<form method="post" id="userSearch_Form" action="">
				<input type="hidden" value="viewTestResult" name="page" />
				<div class="box-content">
					<div class="form-row">
						<p><%=resb.getString("PLEASE_ENTER_USER_NAME_TO_VIEW")%></p>
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
						<input type="button" id="userProfileSearch" class="button green" value="search">
					</div>
				</div>
			</form>
		</div>
		<%
			if ((request.getAttribute("list") != null)||(request.getAttribute("nameList") != null)||(request.getAttribute("messageGetTestResult") != null)) {
		%>
		<div class="box grid_4" id="confirmUser" title="User Selection">
			<%
				} else {
			%>
			<div class="box grid_4" id="confirmUser" title="User Selection"
				style="display: none">
				<%
					}
				%>
				<div class="box-head">
					<h2>User Profile</h2>
				</div>
				<form method="post" action="">
					<div class="box-content">
						<div class="form-row">
							<p><%=resb.getString("PLEASE_CHOOSE_USER_TO_VIEW_TEST_RESULT")%></p>
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
						<div class="form-row" style="text-align: right;">
							<input type="button" id="getTestResultNameAndData" class="button green" value="ok">
						</div>
				</form>
			</div>
		</div>


		<%
			if (request.getAttribute("nameList") != null) {
		%>
		<div class="box grid_4">
			<%
				} else {
			%>
			<div class="box grid_4"  id="testResult" style="display: none">
				<%
					}
				%>
				<div class="box-head">
					<h2>Choose Test Name and Date</h2>
				</div>
				<form method="post" action="">
					<%
						String username = (String)request.getAttribute("username");
					%>
					<input type="hidden" value=<%=username%> name="username" />
					<div class="box-content">
						<div class="form-row">
							<p><%=resb.getString("PLEASE_CHOOSE_TEMP_AND_DATE")%></p>
						</div>
						<br> <br>
						<p id="errTestNameAndDate" style="color: #ff6666; font-size: 11px; display:none">The user does not
							have any test results.</p>
						<br> <br>
						<div class="form-row">
							<label class="form-label">Test Name</label>
							<div class="form-item">

								<select name="tempName">
									<%
										if (request.getAttribute("nameList") != null) {	
											int i=0;
											ArrayList<String> list = (ArrayList<String>)request.getAttribute("nameList");
											for (String s : list) {
									%>
									<option value=<%=s%>><p><%=s%></p>
									</option>
									<%
										}}
									%>
								</select>

							</div>
						</div>
						<div class="form-row">
							<label class="form-label">Date</label>
							<div class="form-item" id="testResultHidden">

								<select name="date">
									<%
										if (request.getAttribute("dateList") != null) {	
											int i=0;
											ArrayList<String> list = (ArrayList<String>)request.getAttribute("dateList");
											for (String s : list) {
									%>
									<option value=<%=s%>><p><%=s%></p>
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
							<div class="form-item" id="errmessageGetTestResult">
								<%
									if (request.getAttribute("messageGetTestResult") != null) {
								%>
								<p style="color: #ff6666; font-size: 11px"><%=request.getAttribute("messageGetTestResult")%></p>
								<%
									}
								%>
							</div>
						</div>
						<div class="form-row" style="text-align: right;">
							<input type="button" id="getTestResult" class="button green" value="show">
						</div>
					</div>
				</form>

			</div>
		</div>
		<%
			if(request.getAttribute("html")!=null){
		%>
		<div class="content container_12">
			<div class="box grid_12">
				<%
					}else{
				%>
			<div class="content container_12">
				<div class="box grid_12" style="display: none">
					<%
						}
					%>
					<div class="box-head">
						<h2>Test Result</h2>
					</div>

				<form method="post" id="myForm" action="TestResultModifyJson">
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
									<button type="button" class="button green" onclick="submitAllJson()">save</button>
								</div>
							</div>
				</form>

				</div>
			</div>
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
	<script>
		
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
		/////////////////////////
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
						innerHtml = innerHtml + "<option value=" + list[i].username + ">" + 
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
				}
			});
		});
		//
		$('#getTestResultNameAndData').click(function(){
			var post = {
					fname: $("#confirmUser").find("input[name=fname]").val(),
					lname: $("#confirmUser").find("input[name=lname]").val(),
					userlist: $("#confirmUser").find("select[name=userlist]").val()
			};
			$.post('AjaxGetTestResultNameAndDate',post,function(data){
				var nameList = data[0];
				var dateList = data[1];
				var list = data[2];
				var username = data[3];
				var fname = data[4];
				var lname = data[5];
				var hiddenpart = "<input name='fname' type='hidden' value='" + list[0].fname + "' >" +
				"<input name='lname' type='hidden' value='" + list[0].lname + "' >";
				var innerHtmlName = "";
				var innerHtmlDate = "";
				for(var i in nameList) {
					innerHtmlName = innerHtmlName + "<option value='" + nameList[i] + "' >" +
					nameList[i] + "</option>";
				}
				for(var i in dateList) {
					innerHtmlDate = innerHtmlDate + "<option value='" + dateList[i] + "' >" +
					dateList[i] + "</option>";
				}
				$("#testResult").find("input[name=username]").val(username);
				$("#testResult").find("select[name=tempName]").html(innerHtmlName);
				$("#testResult").find("select[name=date]").html(innerHtmlDate);
				$("#testResultHidden").append(hiddenpart);
				$('#testResult').css({display:'block'});
			});
		});
		$("#getTestResult").click(function(){
			var post ={
					fname: $("#testResult").find("input[name=fname]").val(),
					lname: $("#testResult").find("input[name=lname]").val(),
					username: $("#testResult").find("input[name=username]").val(),
					tempName: $("#testResult").find("select[name=tempName]").val(),
					date: $("#testResult").find("select[name=date]").val()
			};
			$.post('AjaxModifyTestResult',post, function(data){
				var message = data[0];
				var html = data[1];
				if(message == "") {
					$("#divtext1").html(html);
					$("#field").css({display:'block'});
					$("#field2").css({display:'block'});
					$(".box.grid_12").css({display:'block'});
					for (var i = 0; i < 10; i++) {
						if(document.getElementById("tn"+i)){
							generateGraph(document.getElementById("tn"+i).value, $("input[name=X]").val(),$("input[name=Y]").val());
						}

					} 
				}
			});
		});
		function submitAllJson() {
			var AllData=[];
			var allTable=$("#divtext1").find("table");
			var table ={};
			for(var i=0;i<allTable.length-1;i++) {
				var dataArray = [];
				var allTh = $(allTable[i]).find("th");
				var headLength = allTh.length;
				var allTr = $(allTable[i]).find("tr");
				for(var m=1; m<allTr.length; m++) {
					var data={};
					for(var j=1; j < headLength; j++) {
						data[$(allTh[j]).html()] = $(allTr[m]).find("td:eq("+j+") input").val();
					}
					dataArray.push(data);	
				}
				table[i+1] = JSON.stringify(dataArray);
			}
			$('<input type="hidden" name="data"/>').val(JSON.stringify(table)).appendTo('#myForm');
			console.log(JSON.stringify(table));
			$('#myForm').submit();
		}
		
		////////////////////////////////////////////////
		//load graph
		window.onload = function() {
			for (var i = 0; i < 10; i++) {
				if(document.getElementById("tn"+i)){
					generateGraph(document.getElementById("tn"+i).value);
				}

			} 
		};
		//generate graph
		function generateGraph(tableNumber,X,Y) {
			var col1Title = X;
			var col2Title = Y;

			var data1 = [];
			var data2 = [];
			//fectch x and y data from table
			var allTable=$("#divtext1").find("table");
			var Xposition = 0;
			var Yposition = 0;
			for(var i = 0; i < $(allTable[tableNumber-1]).find("th").length; i++) {
				console.log("i:" + i + "  Html: " + $(allTable[tableNumber-1]).find("th:eq("+i+")").html());
				if($(allTable[tableNumber-1]).find("th:eq("+i+")").html() == X) {
					Xposition = i;
				}
				if($(allTable[tableNumber-1]).find("th:eq("+i+")").html() == Y) {
					Yposition = i;
				}
			}
			
			console.log(Xposition+","+Yposition);
			
			for(var j = 1; j < $(allTable[tableNumber-1]).find("tr").length; j++) {
				for(var m = 1; m < $(allTable[tableNumber-1]).find("th").length; m++) {
					if(m == Xposition) {
					data1.push($(($(allTable[tableNumber-1]).find("tr"))[j]).find("td:eq("+m+") input").val());
					}
					if(m == Yposition) {
					data2.push($(($(allTable[tableNumber-1]).find("tr"))[j]).find("td:eq("+m+") input").val());
					}
				}
			}
			
			console.log("Data : \n" + data1 + " <>\n " +data2 );

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
	</script>
</body>
</html>