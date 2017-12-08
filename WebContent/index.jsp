<%@page import="helperClasses.User"%>
<%@page import="helperClasses.Post"%>
<%@page import="helperClasses.Comment"%>
<%@page import="helperClasses.DatabaseAccess"%>
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
		<div class='container cont'>
			<h1>Blog</h1>
			<a href="post.jsp">Write a Post</a>
			<%
				// Populates page with posts
				for (Iterator<Post> i = posts.iterator(); i.hasNext();) {
                	Post post = i.next();
                	List<Comment> comments = da.GetComments(post.getIDpost());
			%>
			<div class='panel panel-default'>
				<div class='panel-body'>
					<div class="media">
						<div class='media-left'></div>
							<div class='media-body'>
			                	<h4 class="media-heading"><a href="profile.jsp?username=<%= post.getUsername() %>" ><%= post.getUsername()%></a><small><i> Posted on <%= post.getDate() %></i></small></h4>
								<p><%= post.getContent() %></p>
									<%
									// Populates page with comments attached to posts
									for (Iterator<Comment> c = comments.iterator(); c.hasNext();) {
					                	Comment comment = c.next();
									%>
									<div class='media'>
										<div class='media-left'></div>
										<div class='media-body'>
											<h5 class="media-heading"><a href="profile.jsp?username=<%= comment.getUsername() %>"><%= comment.getUsername() %></a><small><i> Posted on <%= comment.getDate() %></i></small></h5>
						                    <p class="comment-content"> <%=comment.getContent()%></p>
					                    </div>
									</div>
								<%}%>
							<a href="comment.jsp?id=<%= post.getIDpost() %>">Add a Comment</a>
						</div>
					</div>
				</div>
			</div>
			<hr/>
			<%}%>
		</div>
	</body>
</html>