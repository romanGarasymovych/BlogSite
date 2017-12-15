/*
 * Project: Blog Website
 * Author: Roman Garasymovych

 * Description: Validates and registers the user to database
 */
package servlets;

import java.io.IOException;
import java.sql.SQLException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.Errors;
import classes.User;
import util.DatabaseAccess;
import validators.RegistrationValidator;



@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String fName = request.getParameter("fname");
		String lName = request.getParameter("lname");
		String email = request.getParameter("email");
		String confirmEmail = request.getParameter("conEmail");
		String phoneNum = request.getParameter("phoneNum");
		String year = request.getParameter("year");
		String major = request.getParameter("major");
		String uName = request.getParameter("uName");
		String pass = request.getParameter("pass");
		
		String success = "Registration Complete";
		Errors errors;
		RegistrationValidator rv = new RegistrationValidator();
		DatabaseAccess da = new DatabaseAccess();
		HttpSession session = request.getSession();

		errors = rv.Validate(fName, lName, email, confirmEmail, phoneNum, year, major, uName, pass);
		
		if(errors.getFirstName() == null && errors.getLastName() == null && errors.getEmail() == null 
				&& errors.getConEmail() == null && errors.getPhone() == null && errors.getYear() == null
				&& errors.getMajor() == null && errors.getUsername() == null && errors.getPassword() == null){
			User user = new User(fName, lName, email, phoneNum, year, major, uName, pass);
			try{
				da.InsertUser(user);
				System.out.println("User created");
				request.setAttribute("success", success);
				session.setAttribute("user", user);
				RequestDispatcher rd=request.getRequestDispatcher("login.jsp");  
		        rd.include(request,response); 
			} catch (SQLException e) {
		        RequestDispatcher rd=request.getRequestDispatcher("login.jsp");  
		        rd.include(request,response);  
			} 
		}else{
			// Validation failed. Forward back to registration.jsp with most of used values
			session.setAttribute("errors", errors);
			session.setAttribute("fName_back", fName);
			session.setAttribute("lName_back", lName);
			session.setAttribute("email_back", email);
			session.setAttribute("phoneNum_back", phoneNum);
			session.setAttribute("year_back", year);
			RequestDispatcher rd=request.getRequestDispatcher("registration.jsp");  
	        rd.include(request,response); 
		}
	}
	

}
