<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/book_spot.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/bookspot.css">
	<title>Book a spot</title>
</head>
<body>
    <jsp:include page="/WEB-INF/header.jsp" />
    
    <div class="date">
        <label for="date">Date:</label>
    	<input type="date" id="date" name="date">
    </div>
    <div class="time">   
    	 <label for="hour">Time:</label>
	    <select name="hour" >
	    	<option value="Morning">Morning</option>
	        <option value="Afternoon">Afternoon</option>
	        <option value="Entire day">Entire day</option>
	    </select>
	    <button id="search">Search</button>
    </div> 
    
        <!-- Modal dialog -->
    <div class = "modal">
        <div class="modal-content">
            <h3> Confirm your booking details </h3><hr />
            	<div id="details"></div><hr/>
            <button class="close-modal">Close</button>
            <button class="submit">Submit</button>
        </div>
    </div>
</body>
</html>