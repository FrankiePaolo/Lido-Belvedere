<jsp:useBean id="cart" class="it.unipa.community.castiglione.francescopaolo.beans.Cart" scope="session" />
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
    	  <title>Confirm order</title>
		  <meta charset="utf-8">
		  <meta name="viewport" content="width=device-width, initial-scale=1">
		  <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
		  <link rel="stylesheet" type="text/css" href="././css/style.css">  
		  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
		  <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
		  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
		  <script src="${pageContext.request.contextPath}/js/User_centered/confirm_order.js"></script>		  
    </head>
  <body class="d-flex flex-column min-vh-100">
    
    	    <jsp:include page="/WEB-INF/header.jsp"/>
    	    
    	    <div id="message"></div>
	   
	         <div id="choices" class="col-md-8 mt-3 mx-auto ">
              <div class="card mb-3">
                <div class="card-body">
                  <table class="table">
				   <tr><th>Item</th><th>Price</th><th>Quantity</th></tr>
			        <% for(int i : cart.getItems_quantity().keySet()){ %>
			        <tr>
			            <td><%= cart.getItems_names().get(i)%></td>
			            <td><%= cart.getItems_prices().get(i)%>€</td>
			            <td>&times;<%= cart.getItem_quantity(i)%></td>
			        </tr>
			        <% }%>
			        <tr>
			            <td><b>Tot.</b></td>
			            <td><b><%=cart.getTotal()%>€</b></td>
			            <td></td>
			        </tr>
				   </table>
				     <div class="row">
					    <div class="col-md-auto">
                   			<button id="confirmButton" class="btn btn-primary">Confirm order</button>
					    </div>
					    <div class="col-md-auto">
                   			<button onclick="location.href='./Menu'" type="button" class="mt-3 mt-md-0 btn btn-secondary">Edit order</button>  
					    </div>
					    <div class="col-md-auto">
                   			<button type="button" id="cancel_order" class="mt-3 mt-md-0 btn btn-danger">Cancel order</button>                            
					    </div>
					  </div>
                </div>
              </div>
             </div>
	    
		    <jsp:include page="/WEB-INF/footer.jsp" />    
	</body>
</html>