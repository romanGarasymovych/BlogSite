<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"%>
<%
	if (session.getAttribute("user") != null) {
		response.sendRedirect("index.jsp");
	}

	Cookie[] cookies = request.getCookies();
	boolean foundCookie = false;
	for (int i = 0; i < cookies.length; i++) {
		Cookie c = cookies[i];
		if (c.getName().equals("username")) {
			session.setAttribute("username", c.getValue());
			foundCookie = true;
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Blog - Login</title>
<link href='./stylesheets/style.css' rel='stylesheet' />
<link href='./favicon.png' rel='shortcut icon' />

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
				<li class="active"><a href="#">Log In</a></li>
				<li><a href="registration.jsp">Register</a></li>
			</ul>
		</div>
	</nav>
	<div class='container-fluid'>
		<div class='row'>
			<div class='col-sm-1'>123</div>
			<div class='col-sm-10'>
				<h1>Login</h1>
				<p class='text-danger'>${wrong}</p>
				<form method="post" action="LoginServlet">
					<div class='form-group'>
						<label>Username <input type='text' class='form-control'
							name='username' value='${cookie.username.getValue()}'>
						</label>
					</div>
					<div class=”form-group”>
						<label>Password <input type='password'
							class='form-control' name='pass'>
						</label>
					</div>

					<div class=”checkbox”>

						<label> <input type='checkbox' name='rememberMe'
							value='true'> Remember Me
						</label>
					</div>
					<a href='registration.jsp'>Register</a>
					<button type='submit' class='btn btn-primary'>Submit</button>
				</form>
			</div>
			<div class='col-sm-1'>123</div>
		</div>
	</div>
</body>
</html>