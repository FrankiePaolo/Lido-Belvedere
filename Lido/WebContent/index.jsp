<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" type="text/css" href="././css/index.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<title>Homepage</title>
</head>
<body>
	<div class="grid-container">
		<div class="grid-item1">
			<jsp:include page="/WEB-INF/header.jsp" />
		</div>
		<div class="grid-item2">
			<img src="${pageContext.request.contextPath}/img/beach-1824855_1920.jpg" width="40%" alt="Beach" />
		</div>
		<div class="grid-item3">
			<p>Our beach is one of the best in Europe.</p>
		</div>
		<div class="grid-item4">
			<jsp:include page="/WEB-INF/footer.jsp" />
		</div>
	</div>
</body>
</html>