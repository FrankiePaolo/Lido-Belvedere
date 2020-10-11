<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<jsp:useBean id="form_customer" class="it.unipa.community.castiglione.francescopaolo.beans.Customer" scope="session" />

<html>
    <head>
    	<meta name="viewport" content="width=device-width ,initial-scale=1.0">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/employeeregister.css">
    	<title>Registration form</title>
    </head>
    <body>
    	<jsp:include page="/WEB-INF/header.jsp"/>
	    	<div class="identity">
		<% String success=request.getParameter("success"); 
	    	if(success !=null && success.equals("true")){ 
	    		if (request.isUserInRole("Cashier")){ %>
	    		<script>window.close()</script>
	    	<% } %>
	    		<a href="${pageContext.request.contextPath}/login}">Registration was successful. Please log in.</a>
	    <%} else {%>
	    		<h1>Register</h1>
				<form class="identity" action="${pageContext.request.contextPath}/RegisterCustomer" method="post">
					<div class="imgcontainer">
						<img src="${pageContext.request.contextPath}/img/user-3331257_1280.png" width="10%" alt="Avatar" class="avatar" />
					</div>
					<% String error =request.getParameter("error"); 
					   if (error !=null && error.equals("mailExists")){ %>
						<div class="errormsg">Email already used!</div>
					<%} else if (error !=null && error.equals("noMatch")){ %>
						<div class="errormsg">The two password do not match!</div>
					<%} else if (error !=null && error.equals("fields_missing")){ %>
						<div class="errormsg">There are some missing fields!</div>
					<%}%>
					<%if (success !=null && success.equals("false")){ %>
						<div class="errormsg">There was some unexpected issue. Please retry.</div>
					<%}%>
					
					<label for="name"><b>First Name</b></label>
	                <input type="text" placeholder="Enter Name" name="firstName" value="${form_customer.firstName}" required>
	
	                <label for="surname"><b>Last Name</b></label>
	                <input type="text" placeholder="Enter Surname" name="lastName" value="${form_customer.lastName}" required>     
	
	                <label for="psw"><b>Password</b></label>
	                <input type="password" placeholder="Enter Password" name="password" id="password" required>
	                
	                <label for="psw-repeat"><b>Repeat Password</b></label>
	                <input type="password" placeholder="Repeat Password" name="password_repeat" id="password_repeat" required>
	                
	                <label for="email"><b>Email</b></label>
	                <input type="email" placeholder="Enter Email" name="email" id="email" required>
	  
	                <hr>
	                
	                <p>By creating an account you agree to our <a href="#">Terms & Privacy</a>.</p>
	                <button type="submit" value="Submit" class="registerbtn">Register</button>
				</form>
			 	<% } %>
	    	</div>
	    <jsp:include page="/WEB-INF/footer.jsp" />
    </body>
</html>