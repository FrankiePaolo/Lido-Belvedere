<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/book_spot.js"></script>
    <script src="${pageContext.request.contextPath}/js/beach_spots.js"></script>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/style.css">
	<title>Book a spot</title>
</head>
<body>
 	<div class="w3-container">
    	<jsp:include page="/WEB-INF/header.jsp" />
    </div>
    <br/>
    <div class="booking_date">
        <label for="date">Date:</label>
    	<input type="date" id="date" name="date">
    </div>
    <br/>
    <div class="booking_time">   
    	 <label for="time">Time:</label>
	    <select name="time" >
	    	<option value="Morning">Morning</option>
	        <option value="Afternoon">Afternoon</option>
	        <option value="Entire day">Entire day</option>
	    </select>
	    <button id="search">Search</button>
    </div> 

    <div class="description">   
        <br/>Our beach is open from 7 AM to 10 PM.<br />
        You can book for the whole day or half a day.<br />
        Each spot is equipped with two deckchairs and one beach umbrella.<br />
        <br/>
        <table>
            <tr><th>Time slot</th><th>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</th><th>Price</th></tr>
            <tr><td>Morning</td><td></td><td>20€</td></tr>
            <tr><td>Afternoon</td><td></td><td>15€</td></tr>
            <tr><td>Full day</td><td></td><td>35€</td></tr>
        </table>
    </div>
    <br/>
    <p>Seats:</p>
    <br/>
    <div class="map"></div>  
    
        <!-- Modal dialog -->
    <div class = "modal">
        <div class="modal-content">
            <h3> Confirm your booking details </h3><hr />
            	<div id="details"></div><hr/>
            <button class="close-modal">Close</button>
            <button class="submit">Submit</button>
        </div>
    </div>
    
    <jsp:include page="/WEB-INF/footer.jsp" />
</body>
</html>