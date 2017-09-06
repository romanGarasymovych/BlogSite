/*
 * Project: Blog Website
 * Author: Roman Garasymovych
 * Description: Posts class
 */
package helperClasses;

public class Post {
	private int IDpost;
	private String Content;
	private String Author;
	private String Date;
	
	public Post() {
		super();
	}
	
	public Post(String content, String author, String date) {
		this.Content = content;
		this.Author = author;
		this.Date = date;
	}
	
	public Post(int ID, String content, String author, String date) {
		this.IDpost = ID;
		this.Content = content;
		this.Author = author;
		this.Date = date;
	}

	public int getIDpost() {
		return IDpost;
	}

	public void setIDpost(int iDpost) {
		IDpost = iDpost;
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
