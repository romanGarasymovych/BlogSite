/*
 * Project: Blog Website
 * Author: Roman Garasymovych
 
 * Description: Validates and adds the post to database
 */
package CoreServlets;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import helperClasses.DatabaseAccess;
import helperClasses.Post;
import helperClasses.User;


@WebServlet("/CreatePost")
public class CreatePost extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public CreatePost() {
        super();
    }


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		DatabaseAccess da = new DatabaseAccess();
		HttpSession session = request.getSession();
		User user = (User) session.getAttribute("user");
		
		String content = request.getParameter("content");
		String author = user.getFirstName() +" " + user.getLastName();
		
		String invalid = "Can't be empty";

		DateFormat dateFormat = new SimpleDateFormat("yyyy:MM:dd HH:mm");
		Date date = new Date();
		String postDate = dateFormat.format(date);
		
		Post newPost = new Post(content, author, postDate);
		if(content == null || content == ""){
			session.setAttribute("invalid", invalid);
			response.sendRedirect("post.jsp");
		}
		else{
			if(!da.InsertPost(newPost)){
				response.sendRedirect("index.jsp");  
		    }
			else{
				invalid = "Error creating a post.";
				session.setAttribute("invalid", invalid);
				response.sendRedirect("post.jsp");
			}
		}
	}

}
