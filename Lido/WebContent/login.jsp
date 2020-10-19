<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width ,initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/index.css">
	<title>Login Page</title>
</head>
<body>
    <jsp:include page="/WEB-INF/header.jsp"/>
    <div class="login_form">    
	    <h2>Hello, please log in:</h2>
		<form class="login_form" action="j_security_check" method=post>
		    <p><strong>Please Enter Your Email: </strong>
		    <input type="text" name="j_username" size="25" required>
		    <p><p><strong>Please Enter Your Password: </strong>
		    <input type="password" size="15" name="j_password" required>
		    <br><br>
		    <input type="submit" value="Submit">
		    <input type="reset" value="Reset">
		</form>
    </div>
</body>
</html>