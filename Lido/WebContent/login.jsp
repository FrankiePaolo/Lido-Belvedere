<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	  <title>Login</title>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	  <link rel="stylesheet" type="text/css" href="././css/style.css">  
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	</head>
	<body class="d-flex flex-column min-vh-100">
	
			<jsp:include page="/WEB-INF/header.jsp" />
			<%
			   String error =request.getParameter("error");
			   if(error != null && error.equals("login")){ %>
				<div class="alert alert-danger" role="alert">
					Invalid user name or password. Please try again.
				</div>
			<% } %>
				
			<div class="container pt-3">
				<h2>Dear customer, please log in:</h2>
				<img src="${pageContext.request.contextPath}/img/user.png" alt="Avatar" class="img-thumbnail w-25">
				
				<form action="j_security_check" method=post>
					<div class="form-group">
					  <label for="exampleInputEmail1">Email address</label>
					  <input type="email" class="form-control" name="j_username" aria-describedby="emailHelp" placeholder="Enter email">
					  <small id="emailHelp" class="form-text text-muted">We'll never share your email with anyone else.</small>
					</div>
					<div class="form-group">
					  <label for="exampleInputPassword1">Password</label>
					  <input type="password" class="form-control" name="j_password" placeholder="Password">
					</div>
		  			<button type="submit" class="btn btn-primary">Submit</button>
		  			<br>
				</form>
			</div>
		  	
		  	<jsp:include page="/WEB-INF/footer.jsp" />
		
	</body>
</html>