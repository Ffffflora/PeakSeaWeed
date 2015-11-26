<!doctype html>
<html lang="en">

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
<script src="../js/jquery.dataTables.min.js"></script>
<script src="../js/jquery.jeditable.js"></script>
<script src="../js/jquery.dataTables.editable.js"></script>
<script src="../js/styler.js"></script>
<script src="../js/jquery.tipTip.js"></script>
<script src="../js/colorpicker.js"></script>
<script src="../js/sticky.full.js"></script>
<script src="../js/global.js"></script>
<script src="../js/flot/jquery.flot.min.js"></script>
<script src="../js/flot/jquery.flot.resize.min.js"></script>
<script src="../js/jquery.dataTables.min.js"></script>
<!---Fonts-->
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Ubuntu:500'
	rel='stylesheet' type='text/css'>
</head>
<%
	HttpSession session2 = request.getSession(false); 
	if(session2.getAttribute("id")==null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
    }
%>
<body>

	<!--- HEADER -->

	<div class="header">
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
				<h2>Test Information</h2>
			</div>
			<form id="chooseuser_form" method="post" action="DeleteUserServlet">
				<div class="box-content">
					<div class="form-row">
						<p>Please specify the User Name and Date associated with the
							test result you would like to modify.</p>
					</div>
					<br> <br>
					<div class="form-row">
						<label class="form-label">User Name</label>
						<div class="form-item">
							<select>
								<option value='option1'>Alice</option>
								<option value='option2'>Bob</option>
								<option value='option3'>Charlie</option>
							</select>
						</div>
					</div>
					<div class="form-row">
						<label class="form-label">Date</label>
						<div class="form-item">
							<select>
								<option value='option1'>06/02/2015</option>
								<option value='option2'>06/03/2015</option>
								<option value='option3'>06/04/2015</option>
							</select>
						</div>
					</div>
					<div class="form-row" style="text-align: right;">
						<!-- <input type="submit" class="button green" value="search"> -->
						<input type="button" class="button green" value="show"
							onClick="searchResult()">
					</div>
				</div>
			</form>
		</div>
		<div class="box grid_12">
			<div class="box-head">
				<h2>Test Result</h2>
			</div>
			<form id="" method="post" action="SaveModifiedTestResultServlet">
				<div class="box-content" id="field" style="display: none">

					<div id="divtext2">
						<table id="myDataTable1">
							<thead>
								<tr>
									<th>Stage</th>
									<th>Power(watts)</th>
									<th>HR(bpm)</th>
									<th>Lactate(mMol)</th>
									<th>VO2(l/min)</th>
									<th>RQ</th>
									<th>Kcal/min</th>
								</tr>
							</thead>
							<tbody>
								<tr>
									<td>1</td>
									<td>50</td>
									<td>121</td>
									<td>1.72</td>
									<td>1.74</td>
									<td>0.91</td>
									<td>8.5</td>
								</tr>
								<tr>
									<td>2</td>
									<td>80</td>
									<td>124</td>
									<td>0.991</td>
									<td>1.79</td>
									<td>20.0</td>
									<td>8.8</td>
								</tr>
								<tr>
									<td>3</td>
									<td>33</td>
									<td>21</td>
									<td>45</td>
									<td>76</td>
									<td>45</td>
									<td>44</td>
								</tr>
								<tr>
									<td>4</td>
									<td>55</td>
									<td>09</td>
									<td>87</td>
									<td>65</td>
									<td>54</td>
									<td>43</td>
								</tr>
								<tr>
									<td>5</td>
									<td>66</td>
									<td>44</td>
									<td>33</td>
									<td>22</td>
									<td>22</td>
									<td>44</td>
								</tr>
							</tbody>
						</table>
						<!-- <input type="button" class="small button green" value="delete"
							onclick="del()" /> -->
					</div>
					<div id="divtext1">
						<div id="flot-lines1"></div>
						<!-- <input type="button" class="small button green" value="delete"
							onclick="del()" /> -->
					</div>
					<div id="divtext3">
						<textarea class="display" rows="6" name="text">Carbohydrate- Protein Mixes
While carbohydrate ingestion during exercise can enhance performance recent research suggests that the addition of protein to a carbohydrate drink during exercise enhances performance even further. Athletes consuming a mix of carbohydrates and protein (CHO-PRO) in their exercise drink have improved their endurance capacity by 29% over consuming just a carbohydrate drink when exercise at moderate intensity. At higher intensity the effect is even greater, the consumption of a CHO-PRO drink improves endurance capacity by 40% compared to carbohydrate alone.
					</textarea>
						<!-- <input type="button" class="small button green" value="delete"
							onclick="del()" /> -->
					</div>
					<div class="form-row" id="field2"
						style="display: none; text-align: right;">
						<input type="submit" class="button green" value="save">
					</div>
					<div class="form-row" id="field2"
						style="display: block; text-align: right;">
						<input type="button"  onclick="showinput()" class="button green" value="show input">
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
	<script>
		function showinput(){
			alert("test: " + $("#myDataTable1").dataTable().$('input').serialize());
		}
		function searchResult() {
			document.getElementById("field").style.display = "block";
			document.getElementById("field2").style.display = "block";
		}
		google.setOnLoadCallback(drawChart());

		function drawChart() {
			var data = new google.visualization.DataTable();
			data.addColumn('number');
			data.addColumn('number');

			data.addRows([ [ 0, 0 ], [ 1, 10 ], [ 2, 23 ], [ 3, 17 ],
					[ 4, 18 ], [ 5, 9 ], [ 6, 11 ], [ 7, 27 ], [ 8, 33 ],
					[ 9, 40 ], [ 10, 32 ], ]);

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
					title : 'Speed(km/hr)'
				},
				vAxis : {
					title : 'Lactate(mMol)'
				}
			};

			var chart = new google.visualization.LineChart(document
					.getElementById('flot-lines1'));
			chart.draw(data, options);

			$("#myDataTable1").dataTable({
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
	</script>


</body>
</html>