/*
 * Project: Blog Website
 * Author: Roman Garasymovych
 * Description: Contains all of the database related methods
 */
package util;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import classes.Comment;
import classes.Post;
import classes.User;

public class DatabaseAccess {
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
		  			post = new Post(rs.getString(1), rs.getString(2), rs.getString(3), FormatDate.format(rs.getString(4)),  rs.getString(5), rs.getInt(6));
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
				  post = new Post(rs.getString(1), rs.getString(2), rs.getString(3), FormatDate.format(rs.getString(4)), rs.getString(5), rs.getInt(6));
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
	  
	  public List<Comment> GetComments(String id) throws SQLException{
		  Connection con = null;
		  PreparedStatement ps = null;
		  ResultSet rs = null;
		  Comment comment;
	  	  List<Comment> comments = new ArrayList<Comment>();
		  try{
			  con = DatabaseAccess.connectDataBase();
			  ps = con.prepareStatement("SELECT * FROM comments INNER JOIN "
			  		+ "posts ON comments.post_id = posts.id "
			  		+ "WHERE posts.id = '"+id + "' ORDER BY comments.post_date ASC");
			  rs =  ps.executeQuery();
			  while(rs.next()){
				  comment = new Comment(rs.getString(2), FormatDate.format(rs.getString(3)), rs.getString(4));
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
		  		ps = con.prepareStatement("INSERT INTO posts (title, content, post_date, username, comment_count) VALUES(?,?,?,?,?)");
		  		ps.setString(1, post.getTitle());
		  		ps.setString(2, post.getContent());
		  		ps.setString(3, post.getDate());
		  		ps.setString(4, post.getUsername());
		  		ps.setInt(5, post.getCommentCount());
		  		
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
		  		ps = con.prepareStatement("INSERT INTO comments (content, post_date, post_id, username) VALUES(?,?,?,?)");
		  		ps.setString(1, comment.getContent());
		  		ps.setString(2, comment.getDate());
		  		ps.setString(3, post_id);
		  		ps.setString(4, comment.getUsername());
		  		
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
	  
	  public boolean UpdateUser(User user) throws SQLException{
		  Connection con = null;
		  PreparedStatement ps = null;
		  try{
			  con = DatabaseAccess.connectDataBase();
			  ps = con.prepareStatement("UPDATE users SET firstname = ?, lastname = ?, "
			  		+ "phone = ?, year = ?, major = ? WHERE username = ?");
			  ps.setString(1,  user.getFirstName());
			  ps.setString(2,  user.getLastName());
			  ps.setString(3,  user.getPhone());
			  ps.setString(4, user.getYear());
			  ps.setString(5,  user.getMajor());
			  ps.setString(6,  user.getUsername());
			  
			  ps.execute();
			  return true;
		  } catch(Exception e){
			  e.printStackTrace();
		  } finally{
			  if(con != null){
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
	  public User GetUserByUsername(String username) throws SQLException {
		  Connection con = null;
		  User user = null;
		  PreparedStatement ps = null;
		  ResultSet rs = null;
			try{
				con = DatabaseAccess.connectDataBase();
				
				ps = con.prepareStatement
						("SELECT * FROM users WHERE username=?");
				ps.setString(1, username);
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
	  
	  public boolean checkPassword(User user, String pass) {
		  Connection con = null;
		  PreparedStatement ps = null;
		  ResultSet rs = null;
		  try{
			  con = DatabaseAccess.connectDataBase();
			  ps = con.prepareStatement("Select password FROM users WHERE username=?");
			  ps.setString(1, user.getUsername());
			  
			  rs = ps.executeQuery();
			  
			  if(rs.next()){
				  if(rs.getString(1).equals(pass)){
					  return true;
				  } 
				  return false;
			  }
			  return false;
		  } catch (Exception e){ e.printStackTrace(); }
		  
		  return false;
	  }
	  
	  public boolean changePassword(User user, String pass){
		  Connection con = null;
		  PreparedStatement ps = null;
		  try{
			  con = DatabaseAccess.connectDataBase();
			  ps = con.prepareStatement("UPDATE users SET password=? WHERE username=?");
			  ps.setString(1, pass);
			  ps.setString(2, user.getUsername());
			  
			  ps.execute();
			  return true;
		  } catch (Exception e) {e.printStackTrace();}
		  
		  return false;
	  }
	  
	  public boolean changeEmail(User user, String email){
		  Connection con = null;
		  PreparedStatement ps = null;
		  try{
			  con = DatabaseAccess.connectDataBase();
			  ps = con.prepareStatement("UPDATE users SET email=? WHERE username=?");
			  ps.setString(1, email);
			  ps.setString(2, user.getUsername());
			  
			  ps.execute();
			  return true;
		  } catch (Exception e) {e.printStackTrace();}
		  
		  return false;
	  }
}
