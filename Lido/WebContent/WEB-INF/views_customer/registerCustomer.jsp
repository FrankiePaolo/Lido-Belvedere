<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<jsp:useBean id="form_results" class="it.unipa.community.castiglione.francescopaolo.beans.Customer" scope="session" />

<html>
    <head>
    	<meta name="viewport" content="width=device-width ,initial-scale=1.0">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
    	<title>Registration form</title>
    </head>
    <body>
    	<jsp:include page="/WEB-INF/header.jsp"/>
	    <div class="identity">
			<% String success=request.getParameter("success"); 
		    	if(success !=null && success.equals("true")){ 
		     %>
		    		<a href="${pageContext.request.contextPath}/Login">Registration was successful. Please log in.</a>
		    <% } else if(success !=null && success.equals("false")){ %>
					<script>alert("There was some unexpected issue. Please retry.");</script>
		    <% } else {%>
		    		<h1>Register</h1>
					<form class="registration_form" action="${pageContext.request.contextPath}/CustomerRegistration" method="post">			
						<div class="img_container">
							<img src="${pageContext.request.contextPath}/img/user-3331257_1280.png" width="10%" alt="Avatar" class="avatar" />
						</div>
						<% String error = request.getParameter("error"); 
						   if (error !=null && error.equals("mailExists")){ %>
						  	<script>alert("Email already used!");</script>
						<%} else if (error !=null && error.equals("noMatch")){ %>
							<script>alert("The two passwords do not match!");</script>
						<%} else if (error !=null && error.equals("fields_missing")){ %>
							<script>alert("There are some missing fields!");</script>
						<%}%>
						<%if (success !=null && success.equals("false")){ %>
							<script>alert("There was some unexpected issue. Please retry.");</script>
						<%}%>
						
						<label for="name"><b>First Name</b></label>
		                <input type="text" placeholder="Enter Name" name="firstName" value="${form_results.firstName}" required>
						<br/>
		                <label for="surname"><b>Last Name</b></label>
		                <input type="text" placeholder="Enter Surname" name="lastName" value="${form_results.lastName}" required>  
		                <br/>
		                <label for="email"><b>Email</b></label>
		                <input type="email" placeholder="Enter Email" name="email" id="email" required>   
						<br/>
		                <label for="password"><b>Password</b></label>
		                <input type="password" placeholder="Enter Password" name="password" id="password" required>
		                
		                <label for="password_repeat"><b>Repeat Password</b></label>
		                <input type="password" placeholder="Repeat Password" name="password_repeat" id="password_repeat" required>	              
		                
		                <p>By creating an account you agree to our <a href="#">Terms & Privacy</a>.</p>			<!-- ADD LINK TO TERMS AND PRIVACY -->
		                <button type="submit" value="Submit" class="registerbtn">Register</button>
					</form>
				<%} %>
	    </div>
	    <jsp:include page="/WEB-INF/footer.jsp" />
    </body>
</html>