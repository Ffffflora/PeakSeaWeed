<!doctype html>
<%@page import="com.peakcentre.web.dao.UserinfoDao"%>
<html lang="en">
<%@ page import="java.util.ResourceBundle"%>
<%@ page import="java.util.Locale"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="com.peakcentre.web.entity.Userinfo"%>
<%@ page import="com.peakcentre.web.dbc.DatabaseConnection"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.PreparedStatement"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<head>
<meta charset="utf-8">
<title>PeakCentre - Modify User Account</title>
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

<%
	Locale locale = Locale.ENGLISH;
	ResourceBundle resb = ResourceBundle
			.getBundle("peakcentre", locale);
	request.getSession(true).setAttribute("locale", locale);
%>
</head>
<body>

	<%@ include file="header.jsp"%>

	<!--- CONTENT AREA -->

	<div class="content container_12">
		<div class="ad-notif-success grid_12 small-mg">
			<p>Modify User Information</p>
		</div>

		<div class="box grid_6" id="userInformation">

			<div class="box-head">
				<h2>User Information</h2>
			</div>
			<div class="box-content">

				<form id="modifyuser_form" method="post" action="ModifyUserServlet"
					enctype="multipart/form-data">
					<%
						final UserinfoDao uiDao = new UserinfoDao();
						String username = session.getAttribute("username").toString();
						ArrayList<Userinfo> userList = uiDao.getUserinfoByUsername(username);
						if (userList.size() > 0) {
					%>

					<div class="form-row">
						<label class="form-label">Type of User</label>
						<div class="form-item">
							<select name="usertype">
								<option selected="selected" value='Athlete'>Athlete</option>
							</select>
						</div>
					</div>

					<div class="form-row">
						<p class="form-label">Username</p>
						<div class="form-item">
							<input type="text" name="username" required
								value=<%=userList.get(0).getUsername()%> readonly />
						</div>
					</div>
					<div class="form-row">
						<p class="form-label">Password</p>
						<div class="form-item">
							<input id="password" type="password" name="password" required
								value=<%=userList.get(0).getPassword()%> />
						</div>
					</div>
					<div class="form-row">
						<p class="form-label">Re-enter Password</p>
						<div class="form-item">
							<input id="repassword" type="password" name="repassword" required
								value=<%=userList.get(0).getPassword() %> onkeyup="checkPass(); return false;" />
						</div>
					</div>
					<div class="form-row">
						<p class="form-label"></p>
						<div class="form-item" id="confirmMessage">
							<%
								if (request.getAttribute("password_message") != null) {
							%>
							<p style="color: #ff6666; font-size: 11px"><%=request.getAttribute("password_message")%></p>
							<%
								}
							%>
						</div>
					</div>
					<div class="form-row">
						<p class="form-label">First Name</p>
						<div class="form-item">
							<input type="text" name="fname" required
								value=<%=userList.get(0).getFname()%> />
						</div>
					</div>
					<div class="form-row">
						<p class="form-label">Last Name</p>
						<div class="form-item">
							<input type="text" name="lname" required
								value=<%=userList.get(0).getLname()%> />
						</div>
					</div>
					<div class="form-row">
						<label class="form-label">Profile Picture</label>
						<div class="form-item file-upload">
							<input value="Select a file to change..." /><input name="pic"
								class="filebase" type='file' id="imgInp" /> <img id="blah"
								src="http://localhost:8080/pic/<%=userList.get(0).getPicpath()%>"
								alt="Preview" height="60" width="60" />
						</div>
					</div>
					<div class="form-row">
						<label class="form-label">Gender</label>
						<div class="form-item">
							<select name="gender">
								<%
									if (userList.get(0).getGender().equals("Male")) {
								%>
								<option selected="selected" value='Male'>Male</option>
								<option value='Female'>Female</option>
								<%
									}
								%>
								<%
									if (userList.get(0).getGender().equals("Female")) {
								%>
								<option value='Male'>Male</option>
								<option selected="selected" value='Female'>Female</option>
								<%
									}
								%>
							</select>
						</div>
					</div>
					<input name="level" type="hidden" value=<%=userList.get(0).getLevel()%> />
					<div class="form-row">
						<label class="form-label">Date of Birth</label>
						<div class="form-item">
							<input type="text" id="datepicker" name="dob" required
								value=<%=userList.get(0).getDob()%> />
						</div>
					</div>
					<div class="form-row">
						<p class="form-label">City</p>
						<div class="form-item">
							<input type="text" name="city" readonly
								value=<%=userList.get(0).getCity()%> />
						</div>
					</div>
					<div class="form-row" style="text-align: right;">
						<input type="submit" class="button green" value="submit">
					</div>
					<%
						}
					%>
				</form>
			</div>

		</div>
	</div>
	<div class="footer">
		<p>© Peak Centre. All rights reserved.</p>
	</div>

	<script>
		function readURL(input) {
			if (input.files && input.files[0]) {
				var reader = new FileReader();

				reader.onload = function(e) {
					$('#blah').attr('src', e.target.result);
				};

				reader.readAsDataURL(input.files[0]);
			}
		}

		$("#imgInp").change(function() {
			readURL(this);
		});

		$(function() {
			$("#datepicker").datepicker({
				showMonthAfterYear : true,
				changeYear : true,
				changeMonth : true,
				numberOfMonths : 1,
				yearRange : "1930:2015"

			});
		});

		function checkPass() {
			//Store the password field objects into variables ...
			var pass1 = document.getElementById('password');
			var pass2 = document.getElementById('repassword');
			//Store the Confimation Message Object ...
			var message = document.getElementById('confirmMessage');
			//Set the colors we will be using ...
			var goodColor = "#66cc66";
			var badColor = "#ff6666";
			//Compare the values in the password field 
			//and the confirmation field
			if (pass1.value == pass2.value) {
				//The passwords match. 
				//Set the color to the good color and inform
				//the user that they have entered the correct password 
				pass2.style.backgroundColor = goodColor;
				message.style.fontSize = "11px";
				message.style.color = goodColor;
				message.innerHTML = "Passwords Match!";
			} else {
				//The passwords do not match.
				//Set the color to the bad color and
				//notify the user.
				pass2.style.backgroundColor = badColor;
				message.style.fontSize = "11px";
				message.style.color = badColor;
				message.innerHTML = "Passwords Do Not Match!";
			}
		}
	</script>
</body>
</html>