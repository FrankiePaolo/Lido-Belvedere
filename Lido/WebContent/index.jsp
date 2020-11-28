<!DOCTYPE html>
<html lang="en">
	<head>
	  <title>Homepage</title>
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
		
		 <% if(session.getAttribute("firstLogin")=="true"){ %>
			 <div class="alert alert-success" role="alert">Welcome back <% out.println(request.getRemoteUser()); %> !</div>
			 <% 	session.setAttribute("firstLogin", "false");
			} %>
			 	
		<div class="container pt-3">
			 <div class="row">
			   <div class="col">
				   <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
					  <ol class="carousel-indicators">
					    <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
					    <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
					  </ol>
					  <div class="carousel-inner">
					    <div class="carousel-item active">
					      <img class="d-block w-100" src="${pageContext.request.contextPath}/img/beach.jpg" alt="First image">
					    </div>
					    <div class="carousel-item">
					      <img class="d-block w-100" src="${pageContext.request.contextPath}/img/beach2.jpg" alt="Second image">
					    </div>
					  </div>
					  <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
					    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
					    <span class="sr-only">Previous</span>
					  </a>
					  <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
					    <span class="carousel-control-next-icon" aria-hidden="true"></span>
					    <span class="sr-only">Next</span>
					  </a>
					</div>
			   </div>
			   </div>
			   <div class="row">
			   		<div class="col mt-5">
			 	    	<p class="font-italic">Our beach is one of the best in Europe.</p>     
			   		</div>
		       </div>
		</div>
		     		
		<jsp:include page="/WEB-INF/footer.jsp" />
	 
	</body>

</html>