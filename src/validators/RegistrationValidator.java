/*
 * Project: Blog Website
 * Author: Roman Garasymovych

 * Description: Validates and adds the errors to Errors object
 */
package validators;

import helperClasses.DatabaseAccess;
import helperClasses.Errors;

public class RegistrationValidator {
	
	public Errors Validate(String fname, String lastName,
			String email, String conEmail, String phone, String year, String major,
			String username, String password){
		
		Errors errors = new Errors();
		DatabaseAccess da = new DatabaseAccess();
		
		boolean invalid;
		String letterRegex = "[a-zA-Z]+";
		String emailRegex = "^[A-Z0-9._%+-]+@[A-Z0-9.-]+\\.[A-Z]{2,6}$";
		String numberRegex = "^(1\\-)?[0-9]{3}\\-?[0-9]{3}\\-?[0-9]{4}$";
		
		// Validate first name
		if(fname != null){
			invalid = fname.matches(letterRegex);
			if(!invalid){
			errors.setFirstName("Invalid First name");
			}
		}
		
		// Validate last name
		if(lastName !=null){
			invalid = lastName.matches(letterRegex);
			if(!invalid)
			errors.setLastName("Invalid First name");
		}
		
		// Validating Email
		invalid = email.matches(emailRegex);
		if(invalid || email == null || email == ""){
			errors.setEmail("Invalid Email");
		}
		
		// Confirming Email
		if(!email.equals(conEmail)){
			errors.setConEmail("Emails don't match");
		}
		
		// Validating Phone
		invalid = phone.matches(numberRegex);
		if(!invalid || phone.equals("")){
			errors.setPhone("Invalid Phone Number");
		}
		
		// Validating Year
		if(year == null){
			errors.setYear("Select Year");
		}
		else if(year.equals("^\n{4}")){
			errors.setYear("Invalid Year");
		}
		
		// Validating Major
		if(major == null){
			errors.setMajor("Select Major");
		}
		
		// Validating Username
		invalid = da.CheckUsername(username);
		if(!invalid){
			errors.setUsername("User already exists");
		}
		if(username.length() < 5){
			errors.setUsername("Must be 5 characters or longer");
		}
		
		// Validating Password
		if(password.length() < 5){
			errors.setPassword("Must be 5 characters or longer");
		}
		return errors;
	}
}
