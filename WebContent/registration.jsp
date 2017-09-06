<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Register</title>
		<link href='./bootstrap/css/bootstrap.min.css' rel='stylesheet' />
		<script type='text/javascript' src='./bootstrap/js/bootstrap.min.js'></script>
	</head>
	<body>
		<nav class="navbar navbar-inverse">
  			<div class="container-fluid">
    			<div class="navbar-header">
      				<a class="navbar-brand" href="index.jsp">Blog</a>
   				</div>
    			<ul class="nav navbar-nav navbar-right">
      				<li><a href="login.jsp">Log In</a></li>
      				<li class="active"><a href="#">Register</a></li>
   				</ul>
  			</div>
		</nav>
		<div class='container'>
			<h1>Registration</h1>
			<form method="post" action="RegisterServlet">
				<div class="row">
					<div class="col-sm-4">
						<div class='form-group'>
							<label>Username
								<input name='uName' type='text' class="form-control"/>
							</label>
							<p class='text-danger'>${errors.getUsername() }</p>
						</div>
						<div class='form-group'>
							<label>Password
								<input name='pass' type='password' class="form-control"/>
							</label>
							<p class='text-danger'>${errors.getPassword() }</p>
						</div>
					</div>
					<div class="col-sm-6">
						<div class='form-group'>
							<label>First Name
								<input name='fname' type='text' class="form-control" value='${fName_back}'/>
							</label>
							<p class='text-danger'>${errors.getFirstName() }</p>
						</div>
						<div class='form-group'>
							<label>Last Name
								<input name='lname' type='text' class="form-control" value='${lName_back}'/>
							</label>
							<p class='text-danger'>${errors.getLastName() }</p>
						</div>
						<div class='form-group'>
							<label>Email
								<input name='email' type="text" class="form-control" value='${email_back}'/>
							</label>
							<p class='text-danger'>${errors.getEmail() }</p>
						</div>
						<div class='form-group'>
							<label>Confirm Email
								<input name='conEmail' type='text' class="form-control" value='${conEmail_back}'/>
							</label>
							<p class='text-danger'>${errors.getConEmail() }</p>
						</div>
						<div class='form-group'>
							<label>Phone Number(999-999-9999)
								<input name='phoneNum' type='text'  class="form-control" value='${phoneNum_back}'/>
							</label>
							<p class='text-danger'>${errors.getPhone() }</p>
						</div>
						
						<div class='form-group'>
							<label>Major
								<select name="major" class="form-control">
									<option selected disabled>--Select One--</option>
									<option value="Information Technology">Information Technology</option>
									<option value="Engineering">Engineering</option>
									<option value="Human Resources">Human Resources</option>
									<option value="Psychology">Psychology</option>
									<option value="Biology">Biology</option>
									<option value="Education">Education</option>
									<option value="History">History</option>
								</select>
							</label>
							<p class='text-danger'>${errors.getMajor() }</p>
						</div>
						<div class='form-group'>
							<label>Year
								<input type="text" name="year" class="form-control" value='${year_back}'/>
							</label>
							<p class='text-danger'>${errors.getYear() }</p>
						</div>
					</div>
				</div>
				<button type='submit' class='btn btn-primary'>Submit</button>
			</form>
		</div>
	</body>
</html>