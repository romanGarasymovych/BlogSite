<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    
<%@page import="classes.User"%>
<%@page import="classes.Post"%>
<%@page import="classes.Comment"%>
<%@page import="util.DatabaseAccess"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@ page session="true" %>

<%
	User currentUser = new User();
	Post post = new Post();
	DatabaseAccess da = new DatabaseAccess();

	if(session == null){
		response.sendRedirect("login.jsp");
	} else {
		currentUser = (User) session.getAttribute("user");
	}
	
	if(currentUser == null){
		response.sendRedirect("login.jsp");
	} 
	
	String postId = request.getParameter("postId");
	if(postId == null || postId == ""){
		response.sendRedirect("index.jsp");
	} else {
		post = da.GetPost(postId);
	}
	List<Comment> comments = da.GetComments(postId);
%>
<!DOCTYPE html>

<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Blog - <%= post.getTitle() %></title>
		<link href='./favicon.png' rel='shortcut icon' />
		<link href='./stylesheets/style.css' rel='stylesheet'/>
		<link href='./bootstrap/css/bootstrap.min.css' rel='stylesheet' />
		<link href="./plugins/css/froala_style.min.css" rel="stylesheet" type="text/css" />
		<script type='text/javascript' src='./bootstrap/js/bootstrap.min.js'></script>
		
		<!-- Include external CSS. -->
    	<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css" rel="stylesheet" type="text/css" />
	    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/codemirror.min.css">
	 
	    <!-- Include Editor style. -->
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.7.3/css/froala_editor.pkgd.min.css" rel="stylesheet" type="text/css" />
	    <link href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.7.3/css/froala_style.min.css" rel="stylesheet" type="text/css" />
		
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
		<div class='container-fluid'>
			<div class='row'>
				<div class='col-sm-10'>
					<div class='panel panel-default'>
						<div class='panel-heading'>
							<h3><%= post.getTitle() %><small><span class='pull-right'><%= post.getDate() %></span></small></h3>
							<%if(currentUser.getUsername().equals(post.getUsername())){  %>
							<a class='pull-right'>Edit</a>
							<%} %>
						</div>
						<div class='panel-body'>
							<div class='fr-view'><%= post.getContent() %></div>
						</div>
					</div>
                <div class='row'>
					<div class='col-sm-12'>
						<form method="post" action="AddComment">
							<p class='text-danger'>${invalid }</p>
							<% session.removeAttribute("invalid"); %>
							<textarea id='addComment' name="content" rows="5" cols="50"></textarea>
							<br />
							<input type="hidden" name="postID" value="<%=post.getIDpost() %>"/>	  
							<div class='btn-group'>
								<button class='btn btn-primary' type="submit">Add comment</button>
							</div>      		
			    		</form>
		    		</div>
				</div>
				<hr/>
				<script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
			    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/codemirror.min.js"></script>
			    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/mode/xml/xml.min.js"></script>
			 
			    <!-- Include Editor JS files. -->
			    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.7.3/js/froala_editor.pkgd.min.js"></script>
			 
			    <!-- Initialize the editor. -->
			    <script> 
				    $(function() { 
				    	$('#addComment').froalaEditor({
					        // Set the image upload URL.
					        height: 100,
					        imageUploadURL: '/upload_image',
					        imageUploadParams: {
					          id: 'my_editor'
					        }
					   	}) 
				   	}); 
			    </script>
                    <div class='row'>
                        <div class='col-sm-12'>
                            <div class='comments'>
                                <%
                                    for(Iterator<Comment> i = comments.iterator(); i.hasNext();) {
                                        Comment comment = i.next();
                                %>
                                <div class='panel panel-default'>
                                    <div class='panel-body'>
                                        <div class='media border'>
                                            <div class='media-left'>
                                                <!-- Image -->
                                            </div>
                                            <div class='media-body'>
                                                <h4><a href='profile.jsp?username=<%= comment.getUsername() %>'><%= comment.getUsername() %></a><small style='margin-left: 10px;'><i><%= comment.getDate() %></i></small></h4>
                                                <div class='fr-view'><%= comment.getContent() %></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <%} %>
                            </div>
                        </div>
                    </div>
				</div>
<<<<<<< HEAD
=======
				<div class='col-sm-1'>
				123
				</div>
>>>>>>> branch 'rework-post' of https://github.com/romanGarasymovych/BlogSite.git
			</div>
		</div>
	</body>
</html>