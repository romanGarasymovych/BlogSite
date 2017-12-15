<%@page import="classes.User"%>
<%@page import="classes.Post"%>
<%@page import="util.DatabaseAccess"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
	List<Post> posts = da.GetPosts();
%>
<!DOCTYPE html>
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Blog - Welcome</title>
		<link href='./stylesheets/style.css' rel='stylesheet'/>
		<link href='./bootstrap/css/bootstrap.min.css' rel='stylesheet' />
		<link href="./plugins/css/froala_style.min.css" rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='./bootstrap/js/bootstrap.min.js'></script>
	</head>
	<body class='body'>
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
			<h1>Blog</h1>
			<a href="newPost.jsp">Write a Post</a>
			<%
				// Populates page with posts
				for (Iterator<Post> i = posts.iterator(); i.hasNext();) {
                	Post post = i.next();
			%>
			<div class='panel panel-default'>
				<div class='panel-body'>
					<div class="media">
						<div class='media-left'></div>
							<div class='media-body'>
			                	<h4 class="media-heading">
			                		<a href="profile.jsp?username=<%= post.getUsername() %>" ><%= post.getUsername()%></a>
			                		<small class='pull-right'><i> Posted on <%= post.getDate() %></i></small>
			                	</h4>
			                	<h3><a href='post.jsp?postId=<%= post.getIDpost() %>'><%= post.getTitle() %></a></h3>
							<a href="comment.jsp?id=<%= post.getIDpost() %>"><span id='count'><%=post.getCommentCount() %></span>&nbsp;comment</a>
						</div>
					</div>
				</div>
			</div>
			<hr/>
			<%}%>
		</div>
	</body>
</html>