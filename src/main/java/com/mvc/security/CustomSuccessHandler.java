package com.mvc.security;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.web.DefaultRedirectStrategy;
import org.springframework.security.web.RedirectStrategy;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;

import com.mvc.utils.SecurityUtils;

public class CustomSuccessHandler extends SimpleUrlAuthenticationSuccessHandler{

	private RedirectStrategy redirectStrategy = new DefaultRedirectStrategy();
	
	@Override
	protected void handle(HttpServletRequest request, HttpServletResponse response, Authentication authentication)
			throws IOException, ServletException {
		String targetUrl = determineTargetUrl(authentication);
		
		if(response.isCommitted())
			return;
		redirectStrategy.sendRedirect(request, response, targetUrl);
	}
	
	@Override
	public void setRedirectStrategy(RedirectStrategy redirectStrategy) {
		super.setRedirectStrategy(redirectStrategy);
	}
	
	@Override
	protected RedirectStrategy getRedirectStrategy() {
		return super.getRedirectStrategy();
	}
	
	private String determineTargetUrl(Authentication authentication) {
		String url = "";
		
		List<String> roles = SecurityUtils.getAuthorities();
		
		if(isAdmin(roles))
			url = "/admin/home";
		else if (isUser(roles)) 
			url = "/home";
		
		return url;
	}
	
	public boolean isAdmin(List<String> roles) {
		if(roles.contains("ADMIN"))
			return true;
		return false;
	}
	
	public boolean isUser(List<String> roles) {
		if(roles.contains("USER"))
			return true;
		return false;
	}
}
