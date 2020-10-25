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
<body>
	
	<jsp:include page="/WEB-INF/header.jsp" />
	
	<div class="container pt-3">
	  <div class="row">
	    <div class="col-sm-8">
	      <h2>Our beach</h2>
	      <img src="${pageContext.request.contextPath}/img/beach.jpg" class="img-fluid" alt="Beach">
				<p>Our beach is one of the best in Europe.</p>     
	      <br>
	    </div>
	  </div>
	</div>
	
	<div class="jumbotron mt-5 text-center" style="margin-bottom:0">
			<jsp:include page="/WEB-INF/footer.jsp" />
	</div>

</body>
</html>