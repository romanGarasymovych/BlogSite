package CoreServlets;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import helperClasses.DatabaseAccess;
import helperClasses.User;


@WebServlet("/UpdateProfile")
public class UpdateProfile extends HttpServlet {
	private static final long serialVersionUID = 1L;

    public UpdateProfile() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost (request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String firstName;
		String lastName;
		String phone;
		String major;
		String year;
		
		firstName = (String) request.getParameter("firstName");
		lastName = (String) request.getParameter("lastName");
		phone = (String) request.getParameter("phone");
		major = (String) request.getParameter("major");
		year = (String) request.getParameter("year");
		HttpSession session = request.getSession();
		User currentUser = (User) session.getAttribute("user");
		User updateUser = new User();

		String message = "";
		
		if(currentUser.getUsername() == "invalid"){
			response.sendRedirect("index.jsp");
		}
		
		
		if(firstName == "" || firstName == null){
			updateUser.setFirstName(currentUser.getFirstName());
		} else {
			updateUser.setFirstName(firstName);
		}
		
		if(lastName == "" || lastName == null) {
			updateUser.setLastName(currentUser.getLastName());
		} else {
			updateUser.setLastName(lastName);
		}
		
		if(phone == "" || phone == null) {
			updateUser.setPhone(currentUser.getPhone());
		} else {
			updateUser.setPhone(phone);
		}
		
		if(major == "" || major == null) {
			updateUser.setMajor(currentUser.getMajor());
		} else {
			updateUser.setMajor(major);
		}
		
		if(year == "" || year == null){
			updateUser.setYear(currentUser.getYear());
		} else {
			updateUser.setYear(year);
		}
		updateUser.setEmail(currentUser.getEmail());
		updateUser.setUsername(currentUser.getUsername());
		DatabaseAccess da = new DatabaseAccess();
		boolean success = false;
		try{
			da.UpdateUser(updateUser);
			success = true;
		} catch (Exception e) {e.printStackTrace(); }
		
		if(success){
			message = "Profile updated";
			session.setAttribute("user", updateUser);
			session.setAttribute("isAlert", true);
			
			session.setAttribute("alertClass", "alert-success");
			session.setAttribute("message", message);
			String redirect = "profile.jsp?username=" + currentUser.getUsername();
			
			response.sendRedirect(redirect);
		}
		
	}

}
