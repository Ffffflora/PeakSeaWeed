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
<%@ page import="com.peakcentre.web.dao.TestResultTemplateDao" %>
<head>
<meta charset="utf-8">
<title>PeakCentre - Compare Test Result</title>
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
<script src="../js/flot/jquery.flot.axislabels.js"></script>
<!---Fonts-->
<%
	HttpSession session2 = request.getSession(false); 
if(session2.getAttribute("username")==null){
		response.sendRedirect(request.getContextPath() + "/index.jsp");
		return;
    }
%>

<%
	Locale locale = Locale.ENGLISH;
	ResourceBundle resb = ResourceBundle
	.getBundle("peakcentre", locale);
	request.getSession(true).setAttribute("locale", locale);
%>
</head>
<body>

	<!--- HEADER -->
	<%@ include file="header.jsp"%>

	<!--- CONTENT AREA -->

	<div class="content container_12">
		<div class="ad-notif-success grid_12 small-mg">
			<p>Compare Test Result</p>
		</div>
		<div class="box grid_4">
			<div class="box-head">
				<h2>Choose One Tempalte</h2>
			</div>
			<form method="" action="">
				<div class="box-content">
					<div class="form-row">
						<!--  
						<p><%=resb.getString("PLEASE_ENTER_USER_NAME_TO_VIEW")%></p>
						-->
						<p>Please Select One Template</p>
					</div>
					<br> <br>
					<div class="form-row">
						<label class="form-label">Template Name</label>
						<div class="form-item">
							<select name="templateName">
								<%
									
									TestResultTemplateDao tdao = new TestResultTemplateDao();
									ArrayList<String> l = tdao.getAllTempName();
									for(String s: l) {
										
								%>
								<option value=<%=s%>><%=s%></option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					
					<div class="form-row">
						<label class="form-label">Compare Mode</label>
						<div class="form-item">
							<select name="compareMode">
								<option value=0>Compare Same User</option>
								<option value=1>Compare Different Users</option>
							</select>
						</div>
					</div>
					<div class="form-row" style="text-align: right;">
						<input type="button" onclick="getTNameAndMode()" class="button green" value="Next">
					</div>
				</div>
			</form>
		</div>

		<div class="box grid_4" id="compareDetail" title="Search First User" style="display: none">
			<div class="box-head">
				<h2>User Profile Search</h2>
			</div>
			<form method="" id="firstUserSearch" action="">
				<div class="box-content">
					<div class="form-row">
						<!-- 
						<p><%=resb.getString("PLEASE_ENTER_USER_NAME_TO_ADD_TEST_RESULT")%></p>
						-->
						<p>Please specify the first name and last name</p>
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
					<input type="hidden" name="templateName" value="">
					<div class="form-row">
						<div class="form-item" id="errmessage">
						</div>
					</div>
					<div class="form-row" style="text-align: right;">
						<input type="button" onclick="getFirstUser()" class="button green" value="Search">
					</div>
				</div>
			</form>
			
		</div>

		<div class="box grid_4"  id="confirmUser" style="display: none">
				<div class="box-head">
					<h2>User Profile</h2>
				</div>
				<form method="" action="">
					<div class="box-content">
						<div class="form-row" id="usernameForm">
							<!-- 
							<p><%=resb.getString("PLEASE_CHOOSE_USER_TO_ADD_TEST_RESULT")%></p>
							 -->
							<p>Please Confirm User</p>
						</div>
						<br>
						<div class="form-row">
							<div class="form-item">
								<select name="userlist">
								</select>
							</div>
						</div>
						<input type="hidden" name="templateName" value="">
						
						<div class="form-row" style="text-align: right;">
							<input type="button" onclick="getTestResultDate()" class="button green" value="Next">
						</div>	
					</div>	
					<br>
				</form>
		</div>
		<div class="box grid_4"  id="selectDates" style="display: none;">
				<div class="box-head">
					<h2>Select Two Entries</h2>
				</div>
				<form method="" action="">
					<div class="box-content">
						<div class="form-row">
							<!-- 
							<p><%=resb.getString("PLEASE_CHOOSE_USER_TO_ADD_TEST_RESULT")%></p>
							 -->
							<p>Please Select At Least Two Entries</p>
						</div>
						<br>
						<div class="form-row">
						<label class="form-label">Select Two: </label>
							<div class="form-item">
							
								<select name="date[]"  id ="date1" multiple>
								</select>
							</div>
						</div>

						<input type="hidden" name="templateName" value="">
						<div class="form-row" style="text-align: right;">
							<input type="button" onclick="getComparisonGraph()" class="button green" value="Compare">
						</div>	
					</div>	
					<br>
				</form>
		</div>
	</div>

		
			<div class="content container_12">
				<div class="box grid_12" style="display: none">

					<div class="box-head">
						<h2>Comparison Result</h2>
					</div>

					<div class="box-content" id="field">

						<div id="divtext1">
							

						</div>
					</div>

				</div>
			</div>
		</div>
	</div>

	<div class="footer">
		<p>© Peak Centre. All rights reserved.</p>
	</div>

	<script>
		////////////////////////////////////////////////
		function getTNameAndMode() {
			var templateName = $("select[name=templateName]").val();
			var compareMode = $("select[name=compareMode]").val();
			if(compareMode == 0) {
				$("input[name=templateName]").val(templateName);
				$("#compareDetail").css({display:"block"});
			} else {
				//ajax load another jsp
			}
		}
		function getFirstUser() {
			var fname = $("#compareDetail input[name=fname]").val();
			var lname = $("#compareDetail input[name=lname]").val();
			var post = {
				fname: fname,
				lname: lname
			};
			$.post("AjaxSearchUser",post,function(data){
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
				}
			})
		}
		function getTestResultDate() {
			var post = {
					templateName : $("input[name=templateName]").val(),
					fname : $("input[name=fname]").val(),
					lname : $("input[name=lname]").val(),
					userlist : $("select[name=userlist]").val()
			};
			$.post("AjaxGetTestResultDate",post,function(data){
				var datelist = data[0];
				var username = data[1];
				var hiddenUsername = "<input type='hidden' name='username' value='"+  username + "' >"
				var innerHtml = "";
				for(var i in datelist) {
					//innerHtml = innerHtml + "<input type='checkbox' value='" + datelist[i] + "' name='date1' />" + datelist[i] +"<br>";
					innerHtml = innerHtml + "<option value='"+datelist[i]+"'>" + datelist[i] + "</option>";
				}
				innerHtml = innerHtml + "<option value='average'>Average</option>";
				$("#selectDates #date1").html(innerHtml);
				$("#selectDates form").append(hiddenUsername);
				$("#selectDates").css({display: "block"});
			});
		}
		function getComparisonGraph() {
			var a = $("#date1").val();
			var c = a.join("-");
			var post = {
					date1 :c,
					templateName : $("#selectDates input[name=templateName]").val(),
					username : $("#selectDates input[name=username]").val() 
			}
			$.post("TestMultipleSelection",post, function(data) {
				var htmlData = data[0];
				var cgData= data[1];
				$("#divtext1").html(htmlData);
				for(var i in cgData) {
					$("#flot-lines" + cgData[i].tableName).css({'min-height':"200px"});
				}
				$("div .box.grid_12").css({display:"block"});
				newGraph(cgData);
			});
		}
		//****************New Graph Function********************//
		function newGraph(allData) {
			for(var i in allData) {
				var dataArray = [];
				var xvalue = allData[i].xValues;
				var yvalue = allData[i].yValues;
				for(var j in xvalue) {
					var dataEntry = {};
					var points = [];
					var xaxis = xvalue[j];
					var yaxis = yvalue[j];
					for(var m=0; m < xaxis.length; m++) {
						points.push([xaxis[m],yaxis[m]]);
					}
					dataEntry.data = points;
					dataEntry.label = j;
					dataArray.push(dataEntry);
				}
				var plot = $.plot($("#flot-lines" + allData[i].tableName),
			            dataArray , {
			                 series: {
			                     lines: { show: true },
			                     points: { show: true }
			                 },
			                 xaxis: {
			                     axisLabel: allData[i].x,
			                     axisLabelUseCanvas: false,
			                     axisLabelFontSizePixels: 12,
			                     axisLabelPadding: 10
			                 },
			                 yaxis: {
			                     axisLabel: allData[i].y,
			                     axisLabelUseCanvas: false,
			                     axisLabelFontSizePixels: 12,
			                     axisLabelPadding: 10
			                 },
			                 grid: { hoverable: true },
			               });
			      var previousPoint = null;
			      $("#flot-lines" + allData[i].tableName).bind("plothover", function (event, pos, item) {
			          if ($("#enablePosition:checked").length > 0) {
			              var str = "(" + pos.x.toFixed(2) + ", " + pos.y.toFixed(2) + ")";
			              $("#hoverdata").text(str);
			          }
			      });
			}
		}
		//******************************************************//
	</script>
</body>
</html>