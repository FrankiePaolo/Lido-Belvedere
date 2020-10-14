<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width ,initial-scale=1.0">
	<meta charset="UTF-8">
	<title>Login Page</title>
</head>
<body>
    <jsp:include page="/WEB-INF/header.jsp"/>
	<h2>Hello, please log in:</h2>
	<br><br>
	<form action="j_security_check" method=post>
	    <p><strong>Please Enter Your Email: </strong>
	    <input type="text" name="j_username" size="25" required>
	    <p><p><strong>Please Enter Your Password: </strong>
	    <input type="password" size="15" name="j_password" required>
	    <p><p>
	    <input type="submit" value="Submit">
	    <input type="reset" value="Reset">
	</form>
</body>
</html>