package servlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import util.DatabaseAccess;
import classes.User;
import validators.EmailValidator;

@WebServlet("/ChangeEmail")
public class ChangeEmail extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public ChangeEmail() {
        super();
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String currEmail = (String) request.getParameter("currEmail");
		String newEmail = (String) request.getParameter("newEmail");
		String conEmail = (String) request.getParameter("conEmail");
		
		HttpSession session = request.getSession();
		DatabaseAccess da = new DatabaseAccess();
		User user = (User) session.getAttribute("user");
		EmailValidator ev = new EmailValidator();
		
		String message = "";
		if(currEmail == null || currEmail == "" || newEmail == null || newEmail == "" || conEmail == null || conEmail == ""){
			message = "Can't have empty fields";
			goBackWithError(message, request, response, session);
		} else {
			if(ev.validateEmail(currEmail)){
				if(currEmail.equals(user.getEmail())){
					if(newEmail.equals(conEmail)){
						if(!newEmail.equals(currEmail)){
							if(ev.validateEmail(newEmail)){
								da.changeEmail(user, newEmail);
								
								message = "Email successfully changed.";
								System.out.println("Email changed");
								
								session.setAttribute("isAlert", true);
								session.setAttribute("alertClass", "alert-success");
								session.setAttribute("message", message);
								
								response.sendRedirect("profile.jsp?username="+user.getUsername());
								
							} else {
								message = "New email invalid";
								goBackWithError(message, request, response, session);
							}
						} else {
							message = "New email can't be the same as old email";
							goBackWithError(message, request, response, session);
						}
					} else {
						message = "Confirm email not the same as new email";
						goBackWithError(message, request, response, session);
					}
				} else {
					message = "This is not your current email";
					goBackWithError(message, request, response, session);
				}
			} else {
				message = "That's not even an email";
				goBackWithError(message, request, response, session);
			}
		}
	}
	private void goBackWithError(String message, HttpServletRequest request, HttpServletResponse response, HttpSession session) throws ServletException, IOException {

		session.setAttribute("isAlert", true);
		session.setAttribute("alertClass", "alert-danger");
		session.setAttribute("message", message);
		
		response.sendRedirect("changeEmail.jsp");
	}

}
