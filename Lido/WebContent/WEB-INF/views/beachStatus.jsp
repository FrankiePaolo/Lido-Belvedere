<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	  <title>Beach status</title>
	  <meta charset="utf-8">
	  <meta name="viewport" content="width=device-width, initial-scale=1">
	  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
	  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
	  <link rel="stylesheet" type="text/css" href="././css/style.css">  
	  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
	  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
	  <script src="${pageContext.request.contextPath}/js/beach_status.js"></script>	  
	</head>
	<body class="d-flex flex-column min-vh-100">
	
		<jsp:include page="/WEB-INF/header.jsp"/>
		
		<div class="container mt-5 p-3 my-3 border" id="beachSpot">
				<div class="container" id="mapContainer">
					<h4>Current beach map :</h4>
		      		<div class="map"></div>
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
			  		<b>User first name:</b> <div id="userFirstName"></div> <br/>
			  		<b>User last name:</b> <div id="userLastName"></div> <br/>
			  		<b>User email:</b> <div id="userEmail"></div> <br/>
			  		<b>Spot number:</b> <div id="spotNumber"></div> <br/>
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
