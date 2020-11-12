<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<header>

	<div class="jumbotron jumbotron-fluid text-center header-custom" style="margin-bottom:0">
	  <div class="container">
	  	<h1>Lido Belvedere</h1>
	  	    <p>Europe's best beach</p>
	  </div>
	</div>
	
	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		    <ul class="navbar-nav ">
			      <li class="nav-item">
			        <a class="nav-link" href="${pageContext.request.contextPath}/">Home</a>
			      </li>
		      <% if(request.getRemoteUser()==null) {%>
		      	  <li class="nav-item dropdown">
			        <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			          Food
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          <a class="dropdown-item" href="${pageContext.request.contextPath}/Menu">Menu</a>
			        </div>
			      </li>	
			      <li class="nav-item">
			        <a class="nav-link" href="${pageContext.request.contextPath}/Login">Login</a>
			      </li>
			       <li class="nav-item">
			        <a class="nav-link" href="${pageContext.request.contextPath}/RegisterCustomer">Register</a>
			      </li>
			  <% } else if(request.isUserInRole("Cashier")) {%>
			      <li class="nav-item">
			        <a class="nav-link"  href="${pageContext.request.contextPath}/BookSpot">New booking</a>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link"  href="${pageContext.request.contextPath}/Bookings">Manage bookings</a>
			      </li>
			       <li class="nav-item">
			        <a class="nav-link"  href="${pageContext.request.contextPath}/Logout">Logout</a>	
			      </li>
			  <% } else if(request.isUserInRole("Chef")) {%>
			   	  <li class="nav-item">
			        <a class="nav-link"  href="${pageContext.request.contextPath}/Orders">Orders</a>	
			      </li>
			      <li class="nav-item">
			        <a class="nav-link"  href="${pageContext.request.contextPath}/Logout">Logout</a>	
			      </li>
			  <% } else if(request.isUserInRole("Lifeguard")) {%>
			      <li class="nav-item">
			        <a class="nav-link"  href="${pageContext.request.contextPath}/BeachStatus">Beach status</a>
			      </li>
			       <li class="nav-item">
			        <a class="nav-link"  href="${pageContext.request.contextPath}/Logout">Logout</a>	
			      </li>
		      <% }else if(request.isUserInRole("Customer")){ %>
		      	   <li class="nav-item dropdown">
			        <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			          Food
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          <a class="dropdown-item" href="${pageContext.request.contextPath}/Menu">Menu</a>
			          <a class="dropdown-item" href="${pageContext.request.contextPath}/Orders">My orders</a>
			        </div>
			      </li>	
			      <li class="nav-item dropdown">
			        <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			          Beach
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          <a class="dropdown-item" href="${pageContext.request.contextPath}/BookSpot">Book a spot</a>
			        </div>
			      </li>			  
			      <li class="nav-item dropdown">
			        <a class="nav-link dropdown-toggle" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			          Account
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          <a class="dropdown-item" href="${pageContext.request.contextPath}/Info">Info</a>
			          <a class="dropdown-item" href="${pageContext.request.contextPath}/Bookings">My bookings</a>			        
			   	      <a class="dropdown-item" href="${pageContext.request.contextPath}/Logout">Logout</a>			       
			        </div>
			      </li>
			      
			 <% } %>
		    </ul>
	</nav>
	
</header>