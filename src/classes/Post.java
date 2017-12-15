/*
 * Project: Blog Website
 * Author: Roman Garasymovych
 * Description: Posts class
 */
package classes;

public class Post {
	private String IDpost;
	private String Content;
	private String username;
	private String Date;

	
	public Post() {
		super();
	}
	
	public Post(String content, String date, String username) {
		this.Content = content;
		this.Date = date;
		this.username = username;
	}
	
	public Post(String ID, String content, String date, String username) {
		this.IDpost = ID;
		this.Content = content;
		this.Date = date;
		this.username = username;
	}

	public String getIDpost(){
		return IDpost;
	}

	public void setIDpost(String iDpost) {
		IDpost = iDpost;
	}

	public String getContent() {
		return Content;
	}
	public void setContent(String content) {
		Content = content;
	}
	public String getDate() {
		return Date;
	}
	public void setDate(String date) {
		Date = date;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}
}
