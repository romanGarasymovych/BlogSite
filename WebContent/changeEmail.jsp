<%@page import="helperClasses.User"%>

<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    session = "true"

%>

<%
	if(session == null){
		response.sendRedirect("login.jsp");
	}
	User currentUser;
	currentUser = (User) session.getAttribute("user");
	
	if(currentUser == null){
		response.sendRedirect("login.jsp");
	}
	boolean isAlert = false;
	if(session.getAttribute("isAlert") == null){
		isAlert = false;
	}
	else {
		isAlert = (boolean) session.getAttribute("isAlert");
	}
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Blog - ${user.getUsername()} - Change Email</title>
		<link href='./stylesheets/style.css' rel='stylesheet'/>
		<link href='./bootstrap/css/bootstrap.min.css' rel='stylesheet' />
		<script type='text/javascript' src='./bootstrap/js/bootstrap.min.js'></script>
	</head>
	<body class="body">
		<nav class='navbar navbar-inverse'>
  			<div class="container-fluid">
    			<div class="navbar-header">
      				<a class="navbar-brand" href="index.jsp">Blog</a>
   				</div>
    			<ul class="nav navbar-nav navbar-right">
      				<li><button class='btn btn-link navbar-btn' onclick="location.href = 'profile.jsp?username=${user.getUsername()}'">${user.getFirstName()} ${user.getLastName() }</button></li>
      				<li>
      					<form action="Logout" method="post">
      					<button type='submit' class='btn btn-danger navbar-btn'>Logout</button>
      					</form>
      				</li>
   				</ul>
  			</div>
		</nav>
		<div class='container cont'>
			<h2>Change Email</h2>
			
			<%
			
			if(isAlert) {
				String alertClass = (String) session.getAttribute("alertClass");
				String message = (String) session.getAttribute("message");
			%>
				<div class="alert <%= alertClass %>">
					<%= message %>
				</div>
			<%
			}
			session.removeAttribute("isAlert");
			session.removeAttribute("message");
			session.removeAttribute("alertClass");
			%>
			<form class='form' method='post' action='ChangeEmail'>
				<div class='form-group'>
					<label for='currEmail'>Enter your current email:</label>
					<input class='form-control' type='email' id='currEmail' name='currEmail' placeholder='Current Email' required/>
				</div>
				<div class='form-group'>
					<label for='newEmail'>Enter a new email:</label>
					<input class='form-control' type='email' id='newEmail' name='newEmail' placeholder='New Email' required/>
				</div>
				<div class='form-group'>
					<label for='conEmail'>Confirm new email:</label>
					<input class='form-control' type='email' id='conEmail' name='conEmail' placeholder='Confirm Email' required/>
				</div>
				<button class='btn btn-primary' type="submit">Submit</button>
				<button class='btn btn-primary pull-right' onclick="location.href = 'profile.jsp?username=${user.getUsername()}'" type="button">Back</button>
			</form>
		</div>
	</body>
</html>