package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import classes.User;
import util.DatabaseAccess;



@WebServlet("/ChangePassword")
public class ChangePassword extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public ChangePassword() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String currPass = (String) request.getParameter("currPass");
		String newPass = (String) request.getParameter("newPass");
		String conPass = (String) request.getParameter("conPass");
		
		HttpSession session = request.getSession();
		DatabaseAccess da = new DatabaseAccess();
		User user = (User) session.getAttribute("user");
		
		String message = "";
		
		if(da.checkPassword(user, currPass)){
			if(newPass.equals(conPass)) {
				if(da.changePassword(user, newPass)){
					message = "Password successfully changed.";
					System.out.println("Password changed");
					
					session.setAttribute("isAlert", true);
					session.setAttribute("alertClass", "alert-success");
					session.setAttribute("message", message);
					
					response.sendRedirect("profile.jsp?username="+user.getUsername());
				} else {
					message = "An internal error occured! Try again later.";
					System.out.println("Internal error");
					session.setAttribute("isAlert", true);
					
					session.setAttribute("alertClass", "alert-danger");
					session.setAttribute("message", message);
					
					response.sendRedirect("changePassword.jsp");
				}
				
			} else {
				System.out.println("Password not the same error");
				message += "\nPasswords don't match";
				
				session.setAttribute("isAlert", true);
				
				session.setAttribute("alertClass", "alert-danger");
				session.setAttribute("message", message);
				
				response.sendRedirect("changePassword.jsp");
			}
		} else {
			System.out.println("Incorrect password error");
			message += "\nIncorrect password.";
			
			session.setAttribute("isAlert", true);
			session.setAttribute("alertClass", "alert-danger");
			session.setAttribute("message", message);
			
			response.sendRedirect("changePassword.jsp");
		}
	}

}
