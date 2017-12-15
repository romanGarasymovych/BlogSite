package util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class FormatDate {
	public static String format(String inputString){
		try {
			DateFormat inputFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss.S");
			Date date;
			
			date = inputFormat.parse(inputString);
		
			DateFormat outputFormat = new SimpleDateFormat("dd-MM-yyyy HH:mm");
			String outputString = outputFormat.format(date);
			return outputString;
		}
		catch (ParseException e) {
			e.printStackTrace();
		}
		return inputString;
	}
}
