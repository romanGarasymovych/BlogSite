/*
 * Project: Blog Website
 * Author: Roman Garasymovych
 * Description: Posts class
 */
package classes;

public class Post {
	private String postId;
	private String title;
	private String content;
	private String username;
	private String date;
	private int commentCount;

	
	public Post() {
		super();
	}
	
	public Post(String title, String content, String date, String username, int commentCount) {
		this.title = title;
		this.content = content;
		this.date = date;
		this.username = username;
		this.commentCount = commentCount;
	}
	
	public Post(String ID, String title, String content, String date, String username, int commentCount) {
		this.postId = ID;
		this.title = title;
		this.content = content;
		this.date = date;
		this.username = username;
		this.commentCount = commentCount;
	}

	public String getIDpost(){
		return postId;
	}

	public void setIDpost(String iDpost) {
		postId = iDpost;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	public String getDate() {
		return date;
	}
	public void setDate(String date) {
		this.date = date;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public int getCommentCount() {
		return commentCount;
	}

	public void setCommentCount(int commentCount) {
		this.commentCount = commentCount;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
}
