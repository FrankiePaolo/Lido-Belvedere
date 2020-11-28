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
    <body class="d-flex flex-column min-vh-100">
    
    	<jsp:include page="/WEB-INF/header.jsp"/>
			<%  String success=request.getParameter("success"); 
				String error = request.getParameter("error");
			  if(success !=null && success.equals("false")){ %>
					<div class="alert alert-danger alert-dismissible">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>Attention! </strong>There was an unexpected issue. Please try again.
					</div>
		    <% } else if (error !=null && error.equals("mailExists")){ %>
		    		<div class="alert alert-danger alert-dismissible">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>Attention! </strong>The email is already in use.
					</div>
		    <% } else if (error !=null && error.equals("noMatch")){ %>
		    		<div class="alert alert-danger alert-dismissible">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>Attention! </strong>The passwords do not match.
					</div>
			 <% } else if (error !=null && error.equals("shortPassword")){ %>
		    		<div class="alert alert-danger alert-dismissible">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>Attention! </strong>The password is too short.
					</div>
			<% } else if (error !=null && error.equals("unexpectedCharacters")){ %>
		    		<div class="alert alert-danger alert-dismissible">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>Attention! </strong>Please only use standard characters for First Name and Last Name.
					</div>
			<% } else if (error !=null && error.equals("fields_missing")){ %>
		    		<div class="alert alert-danger alert-dismissible">
					<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong>Attention! </strong>There are some missing fields.
					</div>		    
		    <% }
		    	if(success !=null && success.equals("true")){ %>
		    	 <div class="alert alert-success">
			        <strong>Success! </strong>Registration was successful. Please <a style="cursor:pointer"  href="${pageContext.request.contextPath}/Login"><ins>login</ins></a>.
				 </div>
		    <%  } else { %>
		        <div class="container pt-3">	    	
		    		<h2>Register</h2>
					<form action="${pageContext.request.contextPath}/CustomerRegistration" method="post">	
						<img src="${pageContext.request.contextPath}/img/user.png" alt="Avatar" class="img-thumbnail w-25 mt-3">
						<div class="message mt-4">
							<p class="font-italic">The password must be at least 4 characters long</p>
							<hr/>
						</div>
						 
						 <div class="form-group">
						    <label for="name"><b>First name</b></label>
						    <input type="text" class="form-control" name="firstName" placeholder="Enter name" value="${form_results.firstName}" required>
						 </div>
						 						 
						 <div class="form-group">
						    <label for="name"><b>Last name</b></label>
						    <input type="text" class="form-control" name="lastName" placeholder="Enter last name" value="${form_results.lastName}" required>
						 </div>
						 
						 <div class="form-group">
						    <label for="email"><b>Email address</b></label>
						    <input type="email" class="form-control" name="email"  placeholder="Enter email" required>
						  </div> 
						
						  <div class="form-group">
						    <label for="password"><b>Password</b></label>
						    <input type="password" class="form-control" name="password" id="password" placeholder="Enter password" required>
						  </div>
						  
						  <div class="form-group">
						    <label for="password_repeat"><b>Repeat password</b></label>
						    <input type="password" class="form-control" name="password_repeat" id="password_repeat" placeholder="Repeat password" required>
						    <small id="info" class="form-text text-muted">By creating an account you agree to our Terms & Privacy</small>		  
						  </div>
				
					  	  <button type="submit" value="Submit" class="btn btn-primary">Register</button>
					</form>		 
	    		</div>
	    	<% } %>
	    
		<jsp:include page="/WEB-INF/footer.jsp" />
			    
	</body>
</html>