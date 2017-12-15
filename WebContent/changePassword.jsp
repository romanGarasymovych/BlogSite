<%@page import="classes.User"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"%>

<%
	if (session == null) {
		response.sendRedirect("login.jsp");
	}
	User currentUser;
	currentUser = (User) session.getAttribute("user");

	if (currentUser == null) {
		response.sendRedirect("login.jsp");
	}
	boolean isAlert = false;
	if (session.getAttribute("isAlert") == null) {
		isAlert = false;
	} else {
		isAlert = (boolean) session.getAttribute("isAlert");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Blog - ${user.getUsername()} - Change Password</title>
<link href='./favicon.png' rel='shortcut icon' />

<link href='./stylesheets/style.css' rel='stylesheet' />
<link href='./bootstrap/css/bootstrap.min.css' rel='stylesheet' />
<script type='text/javascript' src='./bootstrap/js/bootstrap.min.js'></script>
</head>
<body>
	<nav class='navbar navbar-inverse'>
		<div class="container-fluid">
			<div class="navbar-header">
				<a class="navbar-brand" href="index.jsp">Blog</a>
			</div>
			<ul class="nav navbar-nav navbar-right">
				<li><button class='btn btn-link navbar-btn'
						onclick="location.href = 'profile.jsp?username=${user.getUsername()}'">${user.getFirstName()}
						${user.getLastName() }</button></li>
				<li>
					<form action="Logout" method="post">
						<button type='submit' class='btn btn-danger navbar-btn'>Logout</button>
					</form>
				</li>
			</ul>
		</div>
	</nav>
	<div class='container-fluid'>
		<div class='row'>
			<div class='col-sm-1'>213</div>
			<div class='col-sm-10'>
				<h2>Change Password</h2>

				<%
					if (isAlert) {
						String alertClass = (String) session.getAttribute("alertClass");
						String message = (String) session.getAttribute("message");
				%>
				<div class="alert <%=alertClass%>">
					<%=message%>
				</div>
				<%
					}
					session.removeAttribute("isAlert");
					session.removeAttribute("message");
					session.removeAttribute("alertClass");
				%>
				<form class='form' method='post' action='ChangePassword'>
					<div class='form-group'>
						<label for='currPassword'>Enter your current password:</label> <input
							class='form-control' type='password' id='currPassword'
							name='currPass' placeholder='Current Password' />
					</div>
					<div class='form-group'>
						<label for='newPassword'>Enter a new password:</label> <input
							class='form-control' type='password' id='newPassword'
							name='newPass' placeholder='New Password' />
					</div>
					<div class='form-group'>
						<label for='conPassword'>Confirm new password:</label> <input
							class='form-control' type='password' id='conPassword'
							name='conPass' placeholder='Confirm Password' />
					</div>
					<button class='btn btn-primary' type="submit">Submit</button>
					<button class='btn btn-primary pull-right'
						onclick="location.href = 'profile.jsp?username=${user.getUsername()}'"
						type="button">Back</button>
				</form>
			</div>
			<div class='col-sm-1'>123</div>
		</div>

	</div>
</body>
</html>