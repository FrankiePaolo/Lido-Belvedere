<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header>
<nav>

<!-- Login / Register / Logout -->
	<div id="authentication">
		<% if(request.getRemoteUser()==null) {%>
			<a href="${pageContext.request.contextPath}/Login">Login</a>
			<a href="${pageContext.request.contextPath}/RegisterCustomer">Register</a>
		<% }else{ %>
			<a href="">Logout</a>
			<% } %>
	</div>
</nav>
</header>