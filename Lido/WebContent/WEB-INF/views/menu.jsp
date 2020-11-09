<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
    	  <title>Menu</title>
		  <meta charset="utf-8">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		  <link rel="stylesheet" type="text/css" href="././css/style.css">  
		  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		  <script src="${pageContext.request.contextPath}/js/menu.js"></script>	  	
    </head>
  <body class="d-flex flex-column min-vh-100">
    	  <jsp:include page="/WEB-INF/header.jsp"/>

			<div class="col-md-8 mt-3 mx-auto ">
              <div class="card mb-3">
                <div class="card-body">
                  
                  <div class="row">
                    <div class="ml-5 mr-5" id="menu"></div>
                  </div>
                
                </div>
              </div>
             </div>
			
	      <jsp:include page="/WEB-INF/footer.jsp" />    
  </body>
</html>