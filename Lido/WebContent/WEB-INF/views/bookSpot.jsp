<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	  <title>Book a spot</title>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	  <link rel="stylesheet" type="text/css" href="././css/style.css">  
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	  <script src="${pageContext.request.contextPath}/js/book_spot.js"></script>
	</head>
	<body class="d-flex flex-column min-vh-100">
	    <jsp:include page="/WEB-INF/header.jsp" />	    
	    
	    <div class="container mt-5" >
	    	<div id="confirmationMessage"></div>
	    </div>
	    
	    <div class="container mt-5 p-3 my-3 border" id="beachSpotInfo">
			 <p>You must book a day in advance.<br/>
			    Our beach is open from 7 AM to 10 PM.<br/>
	        	You can book for the entire day or for just half a day.<br/>
	        	Each spot is equipped with two deckchairs and one beach umbrella.<br/>
			 <table class="table">
			  <thead>
			    <tr>
			      <th scope="col">Time slot</th>
			      <th scope="col">Price</th>
			    </tr>
			  </thead>
			  <tbody>
			    <tr>
			      <th scope="row">Morning</th>
			      <td>20€</td>
			    </tr>
			    <tr>
			      <th scope="row">Afternoon</th>
			      <td>25€</td>
			    </tr>
			    <tr>
			      <th scope="row">Entire day</th>
			      <td>35€</td>
			    </tr>
			  </tbody>
			 </table>	 
		</div>
	
	
		<div class="container mt-5 p-3 my-3 border" id="beachSpotSelection">
		 <div class="row">
		  <div class="col-sm">
			 <div class="booking_date">
		        <label for="date">Date:</label>
		    	<input type="date" id="date" name="date">
		    </div>
		    <br/>
		    <div class="booking_time">   
		    	<label for="time">Time:</label>
			    <select name="time" id="time">
			    	<option value="Morning">Morning</option>
			        <option value="Afternoon">Afternoon</option>
			        <option value="Entire day">Entire day</option>
			    </select>
		     </div>
		    </div>
		    <% if(request.isUserInRole("Cashier")){ %>
			    <div class="col-sm">
			     <div class="user-email">
			    	<label for="email">User email:</label>
					<input type="email" class="user" id="email"  placeholder="Enter email" required>
			     </div>	
			    </div>
			<% } %>		    
		   </div>
			<button type="button" id="search" class="btn btn-primary mt-3" >Search</button>
			<div class="container mt-5 p-3 my-3 border" id="beachSpotSelection">
				<div class="container" id="mapContainer">
		      		<div class="map"></div>
				</div>	
			</div>
		</div>
				
		<!-- Modal -->
		<div class="modal fade" id="modalCenter" tabindex="-1" role="dialog" aria-labelledby="modalCenterTitle" aria-hidden="true" data-backdrop="static" data-keyboard="false"> 
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <div class="modal-title" id="modalSeatsTitle">
		        	<h4>Booking details:</h4>
		        </div>
		      </div>
		      <div class="modal-body">		     		      	
			  	<div id="details">
			  		<% if(request.isUserInRole("Cashier")){ %>
			  			User email: <div id="userEmail"></div> <br/>
			  		<% } %>
			  		Spot number: <div id="spotNumber"></div> <br/>
			  		Date: <div id="dateBeachSpot"></div> <br/>
			  		Time slot: <div id="timeBeachSpot"></div> <br/>
			  	</div>    	
		      </div>
		      <div class="modal-footer">
		        <button type="button" id="close" class="btn btn-secondary" data-dismiss="modal">Close</button>
		        <button type="button" id="confirmSpotBtn" class="btn btn-primary">Confirm</button>
		      </div>
		    </div>
		  </div>
		</div>
	    
		<jsp:include page="/WEB-INF/footer.jsp" />
		
	</body>
</html>