/*
 * Project: Blog Website
 * Author: Roman Garasymovych
 * Description: Comment class
 */
package helperClasses;

public class Comment {
	private String id;
	private String Content;
	private String Author;
	private String Date;
	
	public Comment() {
	}
	
	public Comment(String content, String author, String date) {
		this.Content = content;
		this.Author = author;
		this.Date = date;
	}
	public Comment(String id, String content, String author, String date) {
		this.id = id;
		this.Content = content;
		this.Author = author;
		this.Date = date;
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
	public String getAuthor() {
		return Author;
	}
	public void setAuthor(String author) {
		Author = author;
	}
	public String getDate() {
		return Date;
	}
	public void setDate(String date) {
		Date = date;
	}
}
