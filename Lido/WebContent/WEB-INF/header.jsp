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
		  <div class="collapse navbar-collapse" id="navbarSupportedContent">
		    <ul class="navbar-nav mr-auto">
		      <li class="nav-item active">
		        <a class="nav-link" href="${pageContext.request.contextPath}/">Home<span class="sr-only">(current)</span></a>
		      </li>
		      <% if(request.getRemoteUser()==null) {%>
			      <li class="nav-item">
			        <a class="nav-link" href="${pageContext.request.contextPath}/Login">Login</a>
			      </li>
			       <li class="nav-item">
			        <a class="nav-link" href="${pageContext.request.contextPath}/RegisterCustomer">Register</a>
			      </li>
			  <% } else if(request.isUserInRole("Customer")){ %>
			      <li class="nav-item dropdown">
			        <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
			          Visit the beach
			        </a>
			        <div class="dropdown-menu" aria-labelledby="navbarDropdown">
			          <a class="dropdown-item" href="${pageContext.request.contextPath}/BookSpot">Book a spot</a>
			        </div>
			      </li>
			      <li class="nav-item">
			        <a class="nav-link" href="${pageContext.request.contextPath}/Logout">Logout</a>
			      </li>
			 <% } %>
		    </ul>
		    <form class="form-inline my-2 my-lg-0">
		      <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
		      <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
		    </form>
		  </div>
	</nav>
	
</header>