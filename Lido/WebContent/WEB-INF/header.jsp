<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header>

<!-- Login / Register / Logout / Home -->
	<div id="authentication">
		<% if(request.getRemoteUser()==null) {%>
			<a href="${pageContext.request.contextPath}/Login">Login</a>
			<a href="${pageContext.request.contextPath}/RegisterCustomer">Register</a>
		<% }else if(request.isUserInRole("Customer")){ %>
		 <div class="dropdown">
			 <button class="dropbtn">Visit the beach</button>
			 <div class="dropdown-content">
			 	<a href="${pageContext.request.contextPath}/BookSpot">Book a spot</a>
			 </div>
		 </div> 
		<% }else{ %>
			<a href="${pageContext.request.contextPath}/Logout">Logout</a>
		<% } %>
			<a href="${pageContext.request.contextPath}/">Home</a>
	</div>
	
</header>