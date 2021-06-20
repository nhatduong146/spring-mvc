package com.mvc.utils;

import org.springframework.stereotype.Component;

@Component
public class MessageUtil {
	public String getAlert(String message) {
		String alert = "";
		if(message.equals("insert_success") || message.equals("update_success") 
				|| message.equals("delete_success"))
			alert = "success";
		else if (message.equals("system_error"))
			alert = "danger";
		return alert;
	}
}
