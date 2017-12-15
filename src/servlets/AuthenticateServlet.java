/*
 * Project: Blog Website
 * Assignment: Assignment 2
 * Author(s): Roman Garasymovych
 * 			  Matthew Arevalo
 * 			  Danielle De Guzman
 *            Philip Carvalho
 * Student Number: 100940045
 *                 100970156
 *                 100954714
 *                 100685332
 * Date:	04-12-2016
 * Description: Validates and logs in a user
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

import classes.User;
import util.DatabaseAccess;



@WebServlet("/AuthenticateServlet")
public class AuthenticateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public AuthenticateServlet() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException 
	{
		response.setContentType("text/html");  
		
		User user;
		String username = request.getParameter("username");
		String pass = request.getParameter("pass");
		
		HttpSession session = request.getSession();

		DatabaseAccess da = new DatabaseAccess();
		//Tries to login use using current credentials
		try {
			user = da.LoginUser(username, pass);
			
			String URL = "LoginServlet";
			String indexURL = "index.jsp";
			session.setAttribute("user", user);
			session.setAttribute("requestedURL", indexURL);
			
			RequestDispatcher rd = request.getRequestDispatcher(URL);
			rd.forward(request, response);
			
		} catch (SQLException e) {
	        RequestDispatcher rd = request.getRequestDispatcher("login.jsp");  
	        rd.include(request,response);  
		} 
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		doGet(request, response);
	}

}
