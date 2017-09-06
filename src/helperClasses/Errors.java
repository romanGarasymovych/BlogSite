/*
 * Project: Blog Website
 * Author: Roman Garasymovych

 * Description: Errors class
 */
package helperClasses;

public class Errors {
	private String fname;
	private String firstName;
	private String lastName;
	private String email;
	private String conEmail;
	private String phone;
	private String year;
	private String major;
	private String username;
	private String password;
	
	public Errors(){
		
	}
	
	public String getConEmail() {
		return conEmail;
	}

	public void setConEmail(String conEmail) {
		this.conEmail = conEmail;
	}

	public void setFname(String fname) {
		this.fname = fname;
	}
	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}
	public void setLastName(String lastName) {
		this.lastName = lastName;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public void setMajor(String major) {
		this.major = major;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getFname() {
		return fname;
	}
	public String getFirstName() {
		return firstName;
	}
	public String getLastName() {
		return lastName;
	}
	public String getEmail() {
		return email;
	}
	public String getPhone() {
		return phone;
	}
	public String getYear() {
		return year;
	}
	public String getMajor() {
		return major;
	}
	public String getUsername() {
		return username;
	}
	public String getPassword() {
		return password;
	}
}
