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
<link href='./bootstrap/css/bootstrap.min.css' rel='stylesheet' />
<link href='./favicon.png' rel='shortcut icon' />

<!-- Include external CSS. -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.4.0/css/font-awesome.min.css"
	rel="stylesheet" type="text/css" />
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/codemirror.min.css">

<!-- Include Editor style. -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.7.3/css/froala_editor.pkgd.min.css"
	rel="stylesheet" type="text/css" />
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.7.3/css/froala_style.min.css"
	rel="stylesheet" type="text/css" />

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

				<script type="text/javascript"
					src="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.11.0/jquery.min.js"></script>
				<script type="text/javascript"
					src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/codemirror.min.js"></script>
				<script type="text/javascript"
					src="https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.25.0/mode/xml/xml.min.js"></script>

				<!-- Include Editor JS files. -->
				<script type="text/javascript"
					src="https://cdnjs.cloudflare.com/ajax/libs/froala-editor/2.7.3/js/froala_editor.pkgd.min.js"></script>

				<!-- Initialize the editor. -->
				<script>
					$(function() {
						$('#edit').froalaEditor({
							// Set the image upload URL.
							height : 300,
							imageUploadURL : '/upload_image',
							imageUploadParams : {
								id : 'my_editor'
							}
						})
					});
				</script>
			</div>
		</div>
	</div>
</body>
</html>