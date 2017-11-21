<%@page import="helperClasses.User"%>
<%@page import="helperClasses.Post"%>
<%@page import="helperClasses.Comment"%>
<%@page import="helperClasses.DatabaseAccess"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    session="true"
%>
<%
	if(session == null){
		response.sendRedirect("login.jsp");
	}
	User currentUser;
	currentUser = (User) session.getAttribute("user");
	
	User userProfile;
	if(currentUser == null){
		response.sendRedirect("login.jsp");
	}
	DatabaseAccess da = new DatabaseAccess();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title></title>
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
      				<li><button class='btn btn-link navbar-btn'>${user.getFirstName()} ${user.getLastName() }</button></li>
      				<li>
      					<form action="Logout" method="post">
      					<button type='submit' class='btn btn-danger navbar-btn'>Logout</button>
      					</form>
      				</li>
   				</ul>
  			</div>
		</nav>
		<div class='container'>
			<h1>Welcome to your profile, ${user.getFirstName()} ${user.getLastName()}</h1>
		</div>
	</body>
</html>