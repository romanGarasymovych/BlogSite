/*
 * Project: Blog Website
 * Author: Roman Garasymovych
 * Description: Contains all of the database related methods
 */
package helperClasses;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DatabaseAccess {
// TODO: Make changes to the theme
// TODO: Deploy website to AWS
// TODO: Format Registration page a little
	  private static Connection connect = null;
	  
	  public static Connection connectDataBase() throws Exception {

		      try {
		    	Context initCtx = new InitialContext();
			    Context envCtx = (Context) initCtx.lookup("java:comp/env");
			    DataSource ds = (DataSource) envCtx.lookup("jdbc/comp3095");
			    connect = ds.getConnection();
			    return connect;
		    }
		    catch (SQLException e) { throw e;}


		  
	  }

	  public User LoginUser(String name, String pass) throws SQLException{
		  Connection con = null;
		  User user = null;
		  PreparedStatement ps = null;
		  ResultSet rs = null;
			try{
				con = DatabaseAccess.connectDataBase();
				
				ps = con.prepareStatement
						("SELECT * FROM users WHERE username=? and password=?");
				ps.setString(1, name);
				ps.setString(2, pass);
				rs = ps.executeQuery();
				
				if(rs.next()){

					user = new User(rs.getString("firstName"), rs.getString("lastName"), 
							rs.getString("email"), rs.getString("phone"), 
							rs.getString("year"), rs.getString("major"), rs.getString("username"));
				}
				else{
					user = new User("invalid", "invalid");
				}
			}catch(Exception e){
				e.printStackTrace();
			}finally{
				if(con !=null){
					con.close();
					ps.close();
					rs.close();
				}
			}
			return user;
	  }
	  
	  public List<Post> GetPosts() throws SQLException{
		  Connection con = null;
		  PreparedStatement ps = null;
		  ResultSet rs = null;
		  Post post;
	  	  List<Post> posts = new ArrayList<Post>();
		  	try{
		  		con = DatabaseAccess.connectDataBase();
		  		ps = con.prepareStatement("SELECT * FROM posts ORDER BY post_date DESC");
		  		rs = ps.executeQuery();
		  		while(rs.next()){
		  			post = new Post(rs.getInt(1), rs.getString(2), rs.getString(3), FormatDate.format(rs.getString(4)));
		  			posts.add(post);
		  		}
		  		return posts;
		  	}catch(Exception e){
				e.printStackTrace();
			}finally{
				if(con !=null){
					con.close();
					ps.close();
				}
			}
		  	return posts;
	  }
	  
	  public Post GetPost(String id) throws SQLException{
		  Connection con = null;
		  PreparedStatement ps = null;
		  ResultSet rs = null;
		  Post post = null;
		  
		  try{
			  con = DatabaseAccess.connectDataBase();
			  
			  ps = con.prepareStatement("SELECT * FROM posts WHERE ID=?");
			  ps.setString(1, id);
			  
			  rs = ps.executeQuery();
			  
			  if(rs.next()){
				  post = new Post(rs.getInt(1), rs.getString(2), rs.getString(3), FormatDate.format(rs.getString(4)));
			  }
		  }catch(Exception e){
				e.printStackTrace();
			}finally{
				if(con !=null){
					con.close();
					ps.close();
					rs.close();
				}
			}
			return post;
		  
	  }
	  
	  public List<Comment> GetComments(int id) throws SQLException{
		  Connection con = null;
		  PreparedStatement ps = null;
		  ResultSet rs = null;
		  Comment comment;
	  	  List<Comment> comments = new ArrayList<Comment>();
	  	  String post_id =  String.valueOf(id);
		  try{
			  con = DatabaseAccess.connectDataBase();
			  ps = con.prepareStatement("SELECT * FROM comments INNER JOIN "
			  		+ "posts ON comments.post_id = posts.id "
			  		+ "WHERE posts.id ="+post_id);
			  rs =  ps.executeQuery();
			  while(rs.next()){
				  comment = new Comment(rs.getString(2), rs.getString(3), FormatDate.format(rs.getString(4)));
				  comments.add(comment);
			  }
			  return comments;
		  }catch(Exception e){
				e.printStackTrace();
			}finally{
				if(con !=null){
					con.close();
					ps.close();
				}
			}
		  return comments;
	  }
	  public boolean InsertPost(Post post){
		  Connection con = null;
		  PreparedStatement ps = null;
		  try{
		  		con = DatabaseAccess.connectDataBase();
		  		ps = con.prepareStatement("INSERT INTO posts (content, author, post_date) VALUES(?,?,?)");
		  		ps.setString(1, post.getContent());
		  		ps.setString(2, post.getAuthor());
		  		ps.setString(3, post.getDate());
		  		
		  		return ps.execute();
		  		
		  	}catch(Exception e){
				e.printStackTrace();
				return false;
			}finally{
				if(con !=null){
					try {
						con.close();
						ps.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				}
			}
	  }
	  
	  public boolean InsertComment(Comment comment, String post_id){
		  Connection con = null;
		  PreparedStatement ps = null;
		  try{
		  		con = DatabaseAccess.connectDataBase();
		  		ps = con.prepareStatement("INSERT INTO comments (content, author, post_date, post_id) VALUES(?,?,?,?)");
		  		ps.setString(1, comment.getContent());
		  		ps.setString(2, comment.getAuthor());
		  		ps.setString(3, comment.getDate());
		  		ps.setString(4, post_id);
		  		
		  		return ps.execute();
		  }catch(Exception e){
				e.printStackTrace();
			}finally{
				if(con !=null){
					try {
						con.close();
						ps.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					
				}
			}
		  return false;
	  }
	  public boolean InsertUser(User user) throws SQLException{
		  Connection con = null;
		  PreparedStatement ps = null;
		  try{
			  con = DatabaseAccess.connectDataBase();
			  ps = con.prepareStatement("INSERT INTO users(firstname, lastname, email, phone, year, major, username, password) "
			  		+ "VALUES(?,?,?,?,?,?,?,?)");
			  ps.setString(1, user.getFirstName());
			  ps.setString(2, user.getLastName());
			  ps.setString(3, user.getEmail());
			  ps.setString(4, user.getPhone());
			  ps.setString(5, user.getYear());
			  ps.setString(6, user.getMajor());
			  ps.setString(7, user.getUsername());
			  ps.setString(8, user.getPassword());
			  
			  ps.execute();
			return true;  
		  }catch(Exception e){
				e.printStackTrace();
			}finally{
				if(con !=null){
					con.close();
					ps.close();
				}
	  }
		  return false;
	  }
	  public boolean CheckUsername(String uName){
		  Connection con = null;
		  PreparedStatement ps = null;
		  ResultSet rs = null;
		  try{
			  con = DatabaseAccess.connectDataBase();
			  ps = con.prepareStatement("SELECT username FROM users WHERE username=?");
			  ps.setString(1, uName);
			  rs = ps.executeQuery();
			  if (!rs.next() ) {
				    return true;
				} 
			  else {return false;}
		  }catch(Exception e){
				e.printStackTrace();
			}finally{
				if(con !=null){
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
					try {
						ps.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		  return false;
	  }
}
