$(document).ready(function () {
	   $('#confirmButton').click( function () {
			$.get('./CompleteOrder', function (data) {
			  $("#choices").hide();
	          if (data.trim() == "OK") {
			  	$("#message").append("<div class=\"alert alert-success\" role=\"alert\">Order successfully added!</div>");
	          } else if(data.trim()=="USER_NOT_LOGGED"){
			  	$("#message").append("<div class=\"alert alert-warning\" role=\"alert\">Please <a style=\"cursor:pointer\" onclick=\"redirect()\"><ins>Login</ins></a> before making an order.</div>");
			  } else if(data.trim()=="ERROR"){
				$("#message").append("<div class=\"alert alert-danger\" role=\"alert\">There was an unexpected error.</div>");
	          }
	      })
		})
});

function redirect(){
	window.location.replace("./Login");
}