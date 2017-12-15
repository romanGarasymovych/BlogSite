/*
 * Project: Blog Website
 * Author: Roman Garasymovych
 * Description: Comment class
 */
package classes;

public class Comment {
	private String id;
	private String Content;
	private String Date;
	private String username;
	
	public Comment() {
	}
	
	public Comment(String content, String date, String username) {
		this.Content = content;
		this.Date = date;
		this.username = username;
	}
	public Comment(String id, String content, String date, String username) {
		this.id = id;
		this.Content = content;
		this.Date = date;
		this.username = username;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
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
