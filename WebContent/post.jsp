<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="classes.User"%>
<%@page import="classes.Post"%>
<%@page import="classes.Comment"%>
<%@page import="util.DatabaseAccess"%>
<%@ page session="true" %>

<%
	if(session == null){
		response.sendRedirect("login.jsp");
	}
	User currentUser;
	currentUser = (User) session.getAttribute("user");
	
	if(currentUser == null){
		response.sendRedirect("login.jsp");
	}
	
	DatabaseAccess da = new DatabaseAccess();
	String postId = request.getParameter("postId");
	
	Post post = da.GetPost(postId);
%>
<!DOCTYPE html>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Blog - <%= post.getTitle() %></title>
		<link href='./stylesheets/style.css' rel='stylesheet'/>
		<link href='./bootstrap/css/bootstrap.min.css' rel='stylesheet' />
		<link href="./plugins/css/froala_style.min.css" rel="stylesheet" type="text/css" />
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
		<div class='container cont'>
			<div class='row'>
				<p><%= post.getTitle() %></p>
				<div class='fr-view'><%= post.getContent() %></div>
			</div>
		</div>
	</body>
</html>