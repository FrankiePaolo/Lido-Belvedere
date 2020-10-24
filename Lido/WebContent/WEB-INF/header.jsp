<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header>
<!-- Login / Register / Logout / Home -->
	<div id="authentication">
		<a class="dropbtn" style="text-decoration: none" href="${pageContext.request.contextPath}/">Home</a>
		<% if(request.getRemoteUser()==null) {%>
			<div class="dropdown">
				 <button class="dropbtn">Account</button>
				 <div class="dropdown-content">
				 	<a href="${pageContext.request.contextPath}/Login">Login</a>
					<a href="${pageContext.request.contextPath}/RegisterCustomer">Register</a>
				 </div>
			 </div> 
		<% }else if(request.isUserInRole("Customer")){ %>
			 <div class="dropdown">
				 <button class="dropbtn">Visit the beach</button>
				 <div class="dropdown-content">
				 	<a href="${pageContext.request.contextPath}/BookSpot">Book a spot</a>
				 </div>
			 </div> 
			<a class="dropbtn" style="text-decoration: none" href="${pageContext.request.contextPath}/Logout">Logout</a>
		<% } %>
	</div>
	
</header>