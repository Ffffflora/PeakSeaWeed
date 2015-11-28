<!doctype html>
<html lang="en">

<head>
<meta charset="utf-8">
<title>PeakCentre - Modify Training Plan</title>
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
<%
	HttpSession session2 = request.getSession(false); 
if(session2.getAttribute("username")==null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
    }
%>
<link
	href='http://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700'
	rel='stylesheet' type='text/css'>
<link href='http://fonts.googleapis.com/css?family=Ubuntu:500'
	rel='stylesheet' type='text/css'>
</head>
<body>

	<!--- HEADER -->
	<%@ include file="header.jsp"%>

	<!--- CONTENT AREA -->

	<div class="content container_12">
		<div class="ad-notif-success grid_12 small-mg">
			<p>Modify Training Plan</p>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>Plan Information</h2>
			</div>
			<form id="chooseuser_form" method="post" action="DeleteUserServlet">
				<div class="box-content">
					<div class="form-row">
						<p>Please specify the User Name and Start Date associated with
							the training plan you would like to modify.</p>
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
						<label class="form-label">Start Date</label>
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
		<div id="div1" class="box grid_12" style="display: none"></div>
		<div id="div2" class="box grid_12" style="display: none">
			<div class="form-row" style="text-align: right;">
				<input type="submit" class="button green" value="save">
			</div>
		</div>
	</div>

	<div class="footer">
		<p>© Peak Centre. All rights reserved.</p>
	</div>

	<script>
		function searchResult() {
			var i = "";
			var startdate = new Date();
			//.format("MM/dd");
			//var startdate1 = startdate.format("MM/dd");
			var weeks = 4;
			var table = "";
			for (i = 0; i < weeks; i++) {
				table += '<div class="box grid_12">';
				table += '<div class="box-head">' + '<h2>Training Plan - Week'
						+ (i + 1) + '</h2>' + '</div>'
						+ '<div class="box-content no-pad">';
				table += '<ul class="table-toolbar">';
				table += '<li onClick="clickAddRow(' + String(i) + ')">'
						+ '<a>'
						+ '<img src="../image/icons/basic/plus.png" alt=""/>'
						+ ' Add Row' + '</a>' + '</li>' + '</ul>';
				table += '<table id="myDataTable' + String(i) + '">';
				table += '<thead>' + '<tr>' + '<th>Sunday</th>'
						+ '<th>Monday</th>' + '<th>Tuesday</th>'
						+ '<th>Wednesday</th>' + '<th>Thursday</th>'
						+ '<th>Friday</th>' + '<th>Saturday</th>' + '</tr>';
				table += '<tr>' + '<th>'
						+ startdate.format("MM/dd")
						+ '</th>'
						+ '<th>'
						+ new Date(startdate.setDate(startdate.getDate() + 1))
								.format("MM/dd")
						+ '</th>'
						+ '<th>'
						+ new Date(startdate.setDate(startdate.getDate() + 1))
								.format("MM/dd")
						+ '</th>'
						+ '<th>'
						+ new Date(startdate.setDate(startdate.getDate() + 1))
								.format("MM/dd")
						+ '</th>'
						+ '<th>'
						+ new Date(startdate.setDate(startdate.getDate() + 1))
								.format("MM/dd")
						+ '</th>'
						+ '<th>'
						+ new Date(startdate.setDate(startdate.getDate() + 1))
								.format("MM/dd")
						+ '</th>'
						+ '<th>'
						+ new Date(startdate.setDate(startdate.getDate() + 1))
								.format("MM/dd") + '</th>' + '</tr>'
						+ '</thead>';
				table += '<tbody>' + '<tr>' + '<td>SW 30</td>' + '<td>OFF</td>'
						+ '<td>R Z3 15</td>' + '<td>R Z1 50</td>'
						+ '<td>ST2</td>' + '<td>B Z1 35</td>'
						+ '<td>SW 30</td>' + '</tr>';
				table += '</tbody>';
				table += '</table>';
				table += '</div>' + '</div>';
				startdate.setDate(startdate.getDate() + 1);
			}

			table += '<div class="box grid_12">';
			table += '<div class="box-head">' + '<h2>Training Plan - ST1</h2>'
					+ '</div>' + '<div class="box-content no-pad">';
			table += '<ul class="table-toolbar">';
			table += '<li onClick="clickAddRowST(' + String(i) + ')">' + '<a>'
					+ '<img src="../image/icons/basic/plus.png" alt=""/>'
					+ ' Add Row' + '</a>' + '</li>' + '</ul>';
			table += '<table id="myDataTable' + String(i) + '">';
			table += '<thead>' + '<tr>' + '<th>No.</th>' + '<th>Exercise</th>'
					+ '<th>Sets</th>' + '<th>Reps</th>' + '<th>Tempo</th>'
					+ '<th>Rest</th>' + '</tr>' + '</thead>';
			table += '<tbody>' + '<tr>' + '<td>A1</td>'
					+ '<td>Close Stance Back Squats</td>' + '<td>3</td>'
					+ '<td>6-8</td>' + '<td>3210</td>' + '<td>10s</td>'
					+ '</tr>';
			table += '<tr>' + '<td>A2</td>'
					+ '<td>Standing DB Overhead Press</td>' + '<td>3</td>'
					+ '<td>6-8</td>' + '<td>3210</td>' + '<td>10s</td>'
					+ '</tr>';
			table += '</tbody>';
			table += '</table>';
			table += '</div>' + '</div>';
			i++;
			table += '<div class="box grid_12">';
			table += '<div class="box-head">' + '<h2>Training Plan - ST2</h2>'
					+ '</div>' + '<div class="box-content no-pad">';
			table += '<ul class="table-toolbar">';
			table += '<li onClick="clickAddRowST(' + String(i) + ')">' + '<a>'
					+ '<img src="../image/icons/basic/plus.png" alt=""/>'
					+ ' Add Row' + '</a>' + '</li>' + '</ul>';
			table += '<table id="myDataTable' + String(i) + '">';
			table += '<thead>' + '<tr>' + '<th>No.</th>' + '<th>Exercise</th>'
					+ '<th>Sets</th>' + '<th>Reps</th>' + '<th>Tempo</th>'
					+ '<th>Rest</th>' + '</tr>' + '</thead>';
			table += '<tbody>' + '<tr>' + '<td>A1</td>' + '<td>Deadlift</td>'
					+ '<td>3</td>' + '<td>6-8</td>' + '<td>3210</td>'
					+ '<td>10s</td>' + '</tr>';
			table += '<tr>' + '<td>A2</td>' + '<td>DB Chest Press</td>'
					+ '<td>3</td>' + '<td>6-8</td>' + '<td>3210</td>'
					+ '<td>10s</td>' + '</tr>';
			table += '</tbody>';
			table += '</table>';
			table += '</div>' + '</div>';
			i++;
			table += '<div class="box grid_12">';
			table += '<div class="box-head">'
					+ '<h2>Training Plan - Flexibility Training</h2>'
					+ '</div>' + '<div class="box-content no-pad">';
			table += '<ul class="table-toolbar">';
			table += '<li onClick="clickAddRowFT(' + String(i) + ')">' + '<a>'
					+ '<img src="../image/icons/basic/plus.png" alt=""/>'
					+ ' Add Row' + '</a>' + '</li>' + '</ul>';
			table += '<table id="myDataTable' + String(i) + '">';
			table += '<thead>' + '<tr>' + '<th>Stretching Exercise</th>'
					+ '<th>Sets</th>' + '<th>Hold (in sec)</th>' + '</tr>'
					+ '</thead>';
			table += '<tbody>' + '<tr>' + '<td>Lying quad stretch</td>'
					+ '<td>3</td>' + '<td>30</td>' + '</tr>';
			table += '<tr>' + '<td>Standing hamstring stretch</td>'
					+ '<td>3</td>' + '<td>30</td>' + '</tr>';
			table += '</tbody>';
			table += '</table>';
			table += '</div>' + '</div>';
			document.getElementById("div1").innerHTML = table;
			document.getElementById("div1").style.display = "block";
			document.getElementById("div2").style.display = "block";

			$("#myDataTable0").dataTable({

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
			$("#myDataTable2").dataTable({
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
			$("#myDataTable3").dataTable({
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
			$("#myDataTable4").dataTable({
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
			$("#myDataTable5").dataTable({
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
			$("#myDataTable6").dataTable({
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
			$("#myDataTable7").dataTable({
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
			$("#myDataTable8").dataTable({
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
		function clickAddRow(o) {

			$('#myDataTable' + String(o)).dataTable().fnAddData(
					[ "", "", "", "", "", "", "" ]);
			$('#myDataTable' + String(o)).dataTable().find('td').editable(
					function(v, s) {
						console.log(v);
						return (v);
					});
		}
		function clickAddRowST(o) {

			$('#myDataTable' + String(o)).dataTable().fnAddData(
					[ "", "", "", "", "", "" ]);
			$('#myDataTable' + String(o)).dataTable().find('td').editable(
					function(v, s) {
						console.log(v);
						return (v);
					});
		}
		function clickAddRowFT(o) {

			$('#myDataTable' + String(o)).dataTable().fnAddData([ "", "", "" ]);
			$('#myDataTable' + String(o)).dataTable().find('td').editable(
					function(v, s) {
						console.log(v);
						return (v);
					});
		}
		Date.prototype.format = function(format) {
			var o = {
				"M+" : this.getMonth() + 1, //month
				"d+" : this.getDate(), //day
			}
			if (/(y+)/.test(format))
				format = format.replace(RegExp.$1, (this.getFullYear() + "")
						.substr(4 - RegExp.$1.length));
			for ( var k in o)
				if (new RegExp("(" + k + ")").test(format))
					format = format.replace(RegExp.$1,
							RegExp.$1.length == 1 ? o[k] : ("00" + o[k])
									.substr(("" + o[k]).length));
			return format;
		}
	</script>


</body>
</html>