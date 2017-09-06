/*
 * Project: Blog Website
 * Author: Roman Garasymovych
 * Description: User class
 */
package helperClasses;

public class User {
	private int idUser;
	private String firstName;
	private String lastName;
	private String email;
	private String phone;
	private String year;
	private String major;
	private String username;
	private String password;
	
	public User(){		
	}

	public User(String username, String password) {
		this.username = username;
		this.password = password;
	}

	public User(String firstName, String lastName, String email, String phone, String year, String major,
			String username) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phone = phone;
		this.year = year;
		this.major = major;
		this.username = username;
	}public User(String firstName, String lastName, String email, String phone, String year, String major,
			String username, String password) {
		this.firstName = firstName;
		this.lastName = lastName;
		this.email = email;
		this.phone = phone;
		this.year = year;
		this.major = major;
		this.username = username;
		this.password = password;
	}
	public int getIdUser() {
		return idUser;
	}

	public void setIdUser(int idUser) {
		this.idUser = idUser;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}

	public String getMajor() {
		return major;
	}

	public void setMajor(String major) {
		this.major = major;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	public String ToString(){
		return this.username + " " + this.email;
	}
}
