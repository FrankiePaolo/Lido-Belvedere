$(document).ready(function () {
	   $('#confirmButton').click( function () {
			$.get('./CompleteOrder', function (data) {
			  $("#choices").hide();
	          if (data.trim() == "OK") {
			  	$("#message").append("<div class=\"alert alert-success\"><strong>Success! </strong>Order successfully added!</div>");
	          } else if(data.trim()=="USER_NOT_LOGGED"){
			  	$("#message").append("<div class=\"alert alert-warning\"><strong>Please</strong> <a style=\"cursor:pointer\" onclick=\"redirect()\"><ins>login</ins></a> before completing the order.</div>");
			  } else if(data.trim()=="ERROR"){
				$("#message").append("<div class=\"alert alert-danger alert-dismissible\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button><strong>Attention! </strong>There was an unexpected error.</div>");
	          }
	      })
		})
		
		$('#cancel_order').click(function(){
                $.ajax({
					type:"get",
					url:"./CartController", 
					cache:"false",  
					data:
					{
						op:'clear'
					},
					success: function(){
						$("#choices").hide();
			  	    	$("#message").append("<div class=\"alert alert-success\"><strong>Success! </strong>Order successfully canceled!</div>");
					}
				});
            });
});

function redirect(){
	window.location.replace("./Login");
}