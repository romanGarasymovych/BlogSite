<%@page import="helperClasses.User"%>
<%@page import="helperClasses.Post"%>
<%@page import="helperClasses.DatabaseAccess"%>
<%@page import="java.util.Iterator"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	Post post = da.GetPost(request.getParameter("id"));
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>New Comment</title>
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
			<h1>Blog - Add a Comment</h1>
			<div class='media'>
				<div class='media-body'>
					<h4 class="media-heading"><%= post.getAuthor() %><small><i> Posted on <%= post.getDate() %></i></small></h4>
					<p><%= post.getContent() %></p>
				</div>
			</div>
			<p class='text-danger'>${invalid }</p>
			<form method="post" action="AddComment">
				<textarea name = "content" rows="10" cols="100"></textarea>
				<br />
				<input type="hidden" name="postID" value="<%=post.getIDpost() %>"/>	  
				<div class='btn-group'>
					<button class='btn btn-primary' type="submit">Submit</button>
					<button class='btn btn-default' form="back" type="submit">Back</button>
				</div>      		
    		</form>
    		<form id="back" action="index.jsp"></form>
    	</div>
	</body>
</html>