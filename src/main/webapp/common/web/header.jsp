<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>
<%@ page import="com.mvc.utils.SecurityUtils" %>
<nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
	<div class="container">
		<a class="navbar-brand" href="#">Start Bootstrap</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarResponsive" aria-controls="navbarResponsive"
			aria-expanded="false" aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav ml-auto">
				<li class="nav-item active"><a class="nav-link" href="<c:url value= '/home'/>">Home
						<span class="sr-only">(current)</span>
				</a></li>
				
				<security:authorize access="isAnonymous()">
					<li class="nav-item"><a class="nav-link" href="<c:url value= '/login'/>">Login</a></li>
					<li class="nav-item"><a class="nav-link" href="#">Sign up</a></li>
				</security:authorize>
				
				<security:authorize access="isAuthenticated()">
					<li class="nav-item"><a class="nav-link" href="#">
						Welcome <%= SecurityUtils.getPrincipal().getFullName() %></a>
					</li>
					<li class="nav-item"><a class="nav-link" href="<c:url value= '/logout'/>">Logout</a></li>
				</security:authorize>
			</ul>
		</div>
	</div>
</nav>