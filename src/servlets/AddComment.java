/*
 * Project: Blog Website
 * Author(s): Roman Garasymovych
 * Description: Validates and adds the comment to database
 */
package servlets;

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

import classes.Comment;
import util.DatabaseAccess;
import classes.User;


@WebServlet("/AddComment")
public class AddComment extends HttpServlet {
	private static final long serialVersionUID = 1L;
       

    public AddComment() {
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
		String postID = request.getParameter("postID");
		String username = user.getUsername();
		
		String invalid = "Can't be Empty";

		DateFormat dateFormat = new SimpleDateFormat("yyyy:MM:dd HH:mm");
		Date date = new Date();
		String commentDate = dateFormat.format(date);
		
		Comment comment = new Comment(content, commentDate, username);
		if(content == null || content == ""){
			session.setAttribute("invalid", invalid);
			response.sendRedirect("comment.jsp?id="+postID);
		}
		else{
			if(da.InsertComment(comment, postID)){
					response.sendRedirect("post.jsp?postId=" + postID);
				}
			response.sendRedirect("index.jsp");

		}
	}

}
