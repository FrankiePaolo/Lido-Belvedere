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
	  <script src="${pageContext.request.contextPath}/js/beach_spots.js"></script>
	</head>
	<body class="d-flex flex-column min-vh-100">
	    <jsp:include page="/WEB-INF/header.jsp" />
	    
	    <div class="container mt-5 p-3 my-3 border">
			 <p>Our beach is open from 7 AM to 10 PM.<br/>
	        	You can book for the entire day or for just half a day.<br/>
	        	Each spot is equipped with two deckchairs and one beach umbrella.<br/>
			 </p>
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
	
	
		<div class="container mt-5 p-3 my-3 border">
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
			<button type="button" id="search" class="btn btn-primary mt-3" data-toggle="modal" data-target="#modalCenter">Search</button>
		</div>
		
		<!-- Modal -->
		<div class="modal fade" id="modalCenter" tabindex="-1" role="dialog" aria-labelledby="modalCenterTitle" aria-hidden="true">
		  <div class="modal-dialog modal-dialog-centered" role="document">
		    <div class="modal-content">
		      <div class="modal-header">
		        <h5 class="modal-title" id="modalLongTitle">Available seats</h5>
		        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
		          <span aria-hidden="true">&times;</span>
		        </button>
		      </div>
		      <div class="modal-body">		     		      	
		      	<div class="container">
		      		<div class="map"></div>
				</div>						      			      	
		      </div>
		      <div class="modal-footer">
		        <button type="button" id="close" class="btn btn-secondary" data-dismiss="modal">Close</button>
		      </div>
		    </div>
		  </div>
		</div>
	    
		<jsp:include page="/WEB-INF/footer.jsp" />
		
	</body>
</html>