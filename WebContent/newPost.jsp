<%@page import="classes.User"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%
	if (session == null) {
		response.sendRedirect("login.jsp");
	}
	User currentUser;
	currentUser = (User) session.getAttribute("user");

	if (currentUser == null) {
		response.sendRedirect("login.jsp");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Blog - New Post</title>
<link href='./stylesheets/style.css' rel='stylesheet' />
<link href='./favicon.png' rel='shortcut icon' />

<!-- Bootstrap -->
<link href='./bootstrap/css/bootstrap.min.css' rel='stylesheet' />
<script type='text/javascript' src='./bootstrap/js/bootstrap.min.js'></script>

<!-- CKEditor -->
<script type="text/javascript" src="./plugins/ckeditor/ckeditor.js"/></script>


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
			<div class='col-sm-1'></div>
			<div class='col-sm-10'>
				<h1>Blog - New Post</h1>
				<p class='text-danger'>${invalid }</p>
				<form method="post" action="CreatePost">
					<div class='form-group'>
						<label for='title'>Title</label> <input name='title' id='title'
							type='text' class='form-control' />
					</div>
					<div class='form-group'>
						<textarea id='edit' name="content" rows='15'></textarea>
					</div>
					<div class="btn-group">
						<button class='btn btn-primary' type="submit">Submit</button>
						<button class='btn btn-default' form="back" type="submit">Back</button>
					</div>
				</form>
				<form id="back" action="index.jsp"></form>

				<!-- Initialize the editor. -->
				<script>
				CKEDITOR.replace('edit');
				</script>
			</div>
		</div>
	</div>
</body>
</html>