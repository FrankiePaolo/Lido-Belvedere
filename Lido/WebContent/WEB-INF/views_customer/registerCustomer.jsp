<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" language="java"%>
<!DOCTYPE html>
<jsp:useBean id="form_results" class="it.unipa.community.castiglione.francescopaolo.beans.Customer" scope="session" />

<html>
    <head>
    	  <title>Registration</title>
		  <meta charset="utf-8">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		  <link rel="stylesheet" type="text/css" href="././css/style.css">  
		  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
    </head>
    <body>
    
    	<jsp:include page="/WEB-INF/header.jsp"/>
	    <div class="container pt-3">
			<%  String success=request.getParameter("success"); 
				String error = request.getParameter("error");
		    	if(success !=null && success.equals("true")){ 
		     %>
			     <div class="alert alert-success" role="alert">
			        Registration was successful. Please <a  class="alert-heading" href="${pageContext.request.contextPath}/Login">log in</a>.
				 </div>
		    <% } else if(success !=null && success.equals("false")){ %>
					<div class="alert alert-danger" role="alert">
						There was an unexpected issue. Please try again.
					</div>
		    <% } else if (error !=null && error.equals("mailExists")){ %>
		    		<div class="alert alert-danger" role="alert">
						The email is already in use.
					</div>
		    <% } else if (error !=null && error.equals("noMatch")){ %>
		    		<div class="alert alert-danger" role="alert">
						The passwords do not match.
					</div>
			<% } else if (error !=null && error.equals("fields_missing")){ %>
		    		<div class="alert alert-danger" role="alert">
						There are some missing fields.
					</div>		    
		    <% } else {%>
		    		    	
		    		<h2>Register</h2>
					<form action="${pageContext.request.contextPath}/CustomerRegistration" method="post">	
						<img src="${pageContext.request.contextPath}/img/user.png" alt="Avatar" class="img-thumbnail w-25">
						 
						 <div class="form-group">
						    <label for="name">First name</label>
						    <input type="text" class="form-control" name="firstName" placeholder="Enter Name" value="${form_results.firstName}" required>
						 </div>
						 						 
						 <div class="form-group">
						    <label for="name">Last name</label>
						    <input type="text" class="form-control" name="lastName" placeholder="Enter Name" value="${form_results.lastName}" required>
						 </div>
						 
						 <div class="form-group">
						    <label for="email">Email address</label>
						    <input type="email" class="form-control" name="email"  placeholder="Enter email" required>
						  </div> 
						
						  <div class="form-group">
						    <label for="password">Password</label>
						    <input type="password" class="form-control" name="password" id="password" placeholder="Enter password" required>
						  </div>
						  
						  <div class="form-group">
						    <label for="password_repeat">Repeat password</label>
						    <input type="password" class="form-control" name="password_repeat" id="password_repeat" placeholder="Repeat password" required>
						    <small id="info" class="form-text text-muted">By creating an account you agree to our Terms & Privacy</small>		  
						  </div>
				
					  	  <button type="submit" value="Submit" class="btn btn-primary">Register</button>
					</form>
					
			<% } %>
	    </div>
	    
		<div class="jumbotron mt-1 text-center" style="margin-bottom:0">
			<jsp:include page="/WEB-INF/footer.jsp" />
		</div>
			    
	</body>
</html>