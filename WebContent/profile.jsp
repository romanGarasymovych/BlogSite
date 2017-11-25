<%@page import="helperClasses.User"%>
<%@page import="helperClasses.Post"%>
<%@page import="helperClasses.Comment"%>
<%@page import="helperClasses.DatabaseAccess"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Objects" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"
    session="true"
%>
<%
	boolean redirect = false;
	String redirectTo = "";
	
	boolean sameUser = false;
	String didWeCheck = "no";
	if(session == null){
		redirect = true;
		redirectTo = "login.jsp";
	}
	User currentUser;
	currentUser = (User) session.getAttribute("user");
	
	DatabaseAccess da = new DatabaseAccess();
	User userProfile = new User();
	String username = request.getParameter("username");
	
	if(username == "" || username == null){
		redirect = true;
		redirectTo = "index.jsp";
	} else {
		userProfile = da.GetUserByUsername(username);
		if(currentUser == null || currentUser.getUsername() == "invalid" || userProfile.getUsername() == "invalid"){
			redirect = true;
			redirectTo = "index.jsp";
		}
	}
	
	if(redirect){
		response.sendRedirect(redirectTo);
	} else {
		String userProfileUsername = userProfile.getUsername();
		if(userProfileUsername.equals(currentUser.getUsername())){
			sameUser = true;
		}
	}
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
      				<li><button class='btn btn-link navbar-btn' onclick="location.href = 'profile.jsp?username=${user.getUsername()}'">${user.getFirstName()} ${user.getLastName() }</button></li>
      				<li>
      					<form action="Logout" method="post">
      					<button type='submit' class='btn btn-danger navbar-btn'>Logout</button>
      					</form>
      				</li>
   				</ul>
  			</div>
		</nav>
		<div class='container'>
		<% if (sameUser) {%>
			<h1>Welcome to your profile, <%= userProfile.getUsername() %></h1>
		<% } else {%>
			<h1> Welcome to <%= userProfile.getUsername() %>'s profile</h1>
		<% } %>
		</div>
	</body>
</html>