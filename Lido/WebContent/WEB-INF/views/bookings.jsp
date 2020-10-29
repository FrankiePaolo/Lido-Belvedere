<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	  <title>Bookings</title>
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
	    	 
	    	 <div class="container pt-3 ">
			  <div class="row">
			    <div class="col-sm">
			       <div class="container pt-3 pb-3 mb-3 border">
                     	<div class="spot">
                     		<label for="spot">Spot number:</label>
                     		<input type="number" id="spot" min=0>
                     	</div><br/>
                     	<div class="date">
                     		<label for="date">Date:</label>
                     		<input type="date" id="date">
                     	</div><br/>
                     	<div class="time">
                     		<label for="time">Time:</label>
                     		<select id="time">
						    	<option value="Morning">Morning</option>
						        <option value="Afternoon">Afternoon</option>
						        <option value="Entire day">Entire day</option>
						    </select>                    	
             		    </div><br/>
             		    <% if(request.isUserInRole("Cashier")){ %>
             		    	<div class="user">
	                     		<label for="user">User email:</label>
	                     		<input type="email" id="user">
                     	</div><br/>
             		    <%} %>
             		    <div class="past_bookings">
             		      <input type="checkbox" id="past_bookings">
 						  <label for="past_bookings"> Show past bookings</label><br>             		    
             		    </div>
             		    <button type="button" id="filter_bookings" class="btn btn-primary mt-3" >Find booking</button>                                	            		    
			       </div> 
			    </div>
			    <div class="col-sm">
			       <div class="container pt-3 pb-3 mb-3 border">
			       	  <p>If you wish to see all the bookings</p>
                      <button type="button" id="find_all" class="btn btn-primary mt-3" >Show all</button>                                	
			       </div> 
			    </div>
			    <div class="col-sm">
			       <div class="container pt-3 pb-3 mb-3 border">
			       	  <p>If you only wish to see future bookings</p>
                      <button type="button" id="find_all" class="btn btn-primary mt-3" >Show all future bookings</button>                                	
			       </div> 
			    </div>
			  </div>
			</div>
			
				<!-- Modal -->
			<div class="modal fade" id="modalCenter" tabindex="-1" role="dialog" aria-labelledby="modalCenterTitle" aria-hidden="true" data-backdrop="static" data-keyboard="false"> 
			  <div class="modal-dialog modal-dialog-centered" role="document">
			    <div class="modal-content">
			      <div class="modal-header">
			        
			      </div>
			      <div class="modal-body">		     		      	
				  	    	
			      </div>
			      <div class="modal-footer">
			        
			      </div>
			    </div>
			  </div>
			</div>
	    	 	
		    <jsp:include page="/WEB-INF/footer.jsp" />    
	
	</body>
</html>