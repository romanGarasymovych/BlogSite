/*
 * Project: Blog Website
 * Author: Roman Garasymovych
 * Description: Login controller
 */
package CoreServlets;


import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import helperClasses.User;

@WebServlet(name="/LoginServlet",urlPatterns={"/LoginServlet"})
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public LoginServlet() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String username = "";
		
		HttpSession session = request.getSession();
		User user  = (User) session.getAttribute("user");
		String requestedURL = (String) session.getAttribute("requestedURL");
		String error = "Incorrect username or password";

		boolean remember = "true".equals(request.getParameter("rememberMe"));
		if(user == null){
			username = request.getParameter("username");
			String pass = request.getParameter("pass");
			
			request.setAttribute("username", username);
			request.setAttribute("pass", pass);
			RequestDispatcher rd = request.getRequestDispatcher("AuthenticateServlet");
			rd.forward(request, response);
			
		}
		// Called when login is wrong
		else if(user.getUsername() == "invalid"){
			user = null;
			session.setAttribute("wrong", error);
			session.setAttribute("user", user);
			response.sendRedirect("login.jsp"); 
		}
		// This is called if user logged in successfully
		else if(requestedURL == "index.jsp"){
			if(remember){
				Cookie c = new Cookie("username", username.toString());
				c.setMaxAge(24*60*60);
				response.addCookie(c);
				System.out.println("Adding cookie for " + user.getUsername());
			}
			RequestDispatcher rd = request.getRequestDispatcher("index.jsp");
			rd.forward(request, response);
		}
	}
}
