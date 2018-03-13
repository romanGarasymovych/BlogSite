<%@page import="classes.User"%>
<%@page import="classes.Post"%>
<%@page import="classes.Comment"%>
<%@page import="util.DatabaseAccess"%>
<%@page import="java.util.Iterator"%>
<%@page import="java.util.List"%>
<%@page import="java.util.Objects"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" session="true"%>
<%!public String isCurrentMajor(User user, String str) {
		String major = user.getMajor();
		return major.equals(str) ? "selected" : "";
	}%>
<%
	boolean redirect = false;
	String redirectTo = "";

	boolean sameUser = false;
	if (session == null) {
		redirect = true;
		redirectTo = "login.jsp";
	}
	User currentUser;
	currentUser = (User) session.getAttribute("user");

	DatabaseAccess da = new DatabaseAccess();
	User userProfile = new User();
	String username = request.getParameter("username");

	if (username == "" || username == null) {
		redirect = true;
		redirectTo = "index.jsp";
	} else {
		userProfile = da.GetUserByUsername(username);
		if (currentUser == null || currentUser.getUsername() == "invalid"
				|| userProfile.getUsername() == "invalid") {
			redirect = true;
			redirectTo = "index.jsp";
		}
	}

	if (redirect) {
		response.sendRedirect(redirectTo);
	} else {
		String userProfileUsername = userProfile.getUsername();
		if (userProfileUsername.equals(currentUser.getUsername())) {
			sameUser = true;
		}
	}

	boolean isAlert = false;
	if (session.getAttribute("isAlert") == null) {
		isAlert = false;
	} else {
		isAlert = (boolean) session.getAttribute("isAlert");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Blog - ${user.getUsername()}'s profile</title>
<link href='./stylesheets/style.css' rel='stylesheet' />
<link href='./bootstrap/css/bootstrap.min.css' rel='stylesheet' />
<link href='./favicon.png' rel='shortcut icon' />
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
				<%
					if (sameUser) {
				%>
				<h1>
					Welcome to your profile,
					<%=userProfile.getUsername()%></h1>

				<%
					if (isAlert) {
							String alertClass = (String) session.getAttribute("alertClass");
							String message = (String) session.getAttribute("message");
				%>
				<div class="alert <%=alertClass%>">
					<%=message%>
				</div>
				<%
					}
						session.removeAttribute("isAlert");
						session.removeAttribute("message");
						session.removeAttribute("alertClass");
				%>

				<h2>Update Profile</h2>
				<div class="row">
					<div class="col-sm-5">
						<form class="form" method="post" action="UpdateProfile">
							<div class="form-group">
								<label for="firstName">First Name</label> <input type="text"
									name="firstName" placeholder="${user.getFirstName()}"
									id="firstName" class="form-control" />
							</div>
							<div class="form-group">
								<label for="lastName">Last Name</label> <input type="text"
									name="lastName" placeholder="${user.getLastName()}"
									id="lastName" class="form-control" />
							</div>
							<div class="form-group">
								<label for="phone">Phone Number</label> <input type="text"
									name="phone" id="phone" placeholder="${user.getPhone() }"
									class="form-control" />
							</div>
							<div class="form-group">
								<label for="major">Major</label> <select name="major" id="major"
									class="form-control">
									<option <%out.print(isCurrentMajor(userProfile, ""));%>
										disabled>--Select One--</option>
									<option
										<%out.print(isCurrentMajor(userProfile, "Information Technology"));%>
										value="Information Technology">Information Technology</option>
									<option
										<%out.print(isCurrentMajor(userProfile, "Engineering"));%>
										value="Engineering">Engineering</option>
									<option
										<%out.print(isCurrentMajor(userProfile, "Human Resources"));%>
										value="Human Resources">Human Resources</option>
									<option
										<%out.print(isCurrentMajor(userProfile, "Psychology"));%>
										value="Psychology">Psychology</option>
									<option
										<%out.print(isCurrentMajor(userProfile, "Biology"));%>
										value="Biology">Biology</option>
									<option
										<%out.print(isCurrentMajor(userProfile, "Education"));%>
										value="Education">Education</option>
									<option
										<%out.print(isCurrentMajor(userProfile, "History"));%>
										value="History">History</option>
								</select>
							</div>
							<div class="form-group">
								<label for="year">Year</label> <input type="text" name="year"
									id="year" placeholder="${user.getYear() }" class="form-control" />
							</div>
							<button class="btn btn-success" type="submit">Update</button>
						</form>
					</div>
					<div class="col-sm-3">
						<h3>Profile Details</h3>
						<hr />
						<h4>
							Name: <span class='pull-right'>${user.getFirstName() }&nbsp;${user.getLastName() }</span>
						</h4>
						<h4>
							Email: <span class='pull-right'>${user.getEmail()}</span>
						</h4>
						<h4>
							Phone Number: <span class='pull-right'>${user.getPhone()}</span>
						</h4>
						<h4>
							Major: <span class='pull-right'>${user.getMajor()}</span>
						</h4>
						<h4>
							Year: <span class='pull-right'>${user.getYear()}</span>
						</h4>
						<hr />
						<h3>Security Settings</h3>
						<button class="btn btn-primary"
							onClick="location.href = 'changeEmail.jsp'">Change Email</button>
						<button class="btn btn-primary"
							onClick="location.href = 'changePassword.jsp'">Change
							Password</button>
					</div>
				</div>


				<%
					} else {
				%>
				<h1>
					Welcome to
					<%=userProfile.getUsername()%>'s profile
				</h1>
				<div class='row'>
					<div class="col-sm-5">
						<h4>
							Name: <span class='pull-right'><%=userProfile.getFirstName()%>&nbsp;<%=userProfile.getLastName()%></span>
						</h4>
						<h4>
							Email: <span class='pull-right'><%=userProfile.getEmail()%></span>
						</h4>
						<h4>
							Phone Number: <span class='pull-right'><%=userProfile.getPhone()%></span>
						</h4>
						<h4>
							Major: <span class='pull-right'><%=userProfile.getMajor()%></span>
						</h4>
						<h4>
							Year: <span class='pull-right'><%=userProfile.getYear()%></span>
						</h4>
					</div>
				</div>
				<%
					}
				%>
			</div>
		</div>
	</div>
</body>
</html>
