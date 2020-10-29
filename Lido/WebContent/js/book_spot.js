// Mail format regex
var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;


$(document).ready(function(){
	var inputDate ;
	var inputTime ;
	var inputMail ;
		
	var date = new Date();	
	
	$("#search").click(function(){
		
		//If we press search we do not want the user to be able to change the email address provided
		$("#email").prop("readonly",true);
	
		inputDate = $("#date").val();
		inputTime = $("#time").val();
		inputMail=  $("#email").val();
				
		//We check if the user is a cashier by verifying that the appropriate class exists
		var checkCashier = $(".user-email").length; 
		
		var inputDateFormatted=new Date(inputDate);
		
		if(checkCashier && !inputMail){
			$('.map').hide();		
			alert("Attention! You must provide an email address.");				
		}else if(checkCashier && !inputMail.match(mailformat)){
			$('.map').hide();		
			alert("You have entered an invalid email address!");
		}else if(inputDateFormatted>date){
			if(checkCashier){
				$("#userEmail").replaceWith("<div id=\"userEmail\">"+inputMail+"</div>")
			}
			$("#dateBeachSpot").replaceWith("<div id=\"dateBeachSpot\">"+inputDate+"</div>");
			$("#timeBeachSpot").replaceWith("<div id=\"timeBeachSpot\">"+inputTime+"</div>");
			$('.map').show();
			loadMap(inputDate,inputTime);			
		}else if(inputDateFormatted.getDate()==date.getDate()){
			$('.map').hide();		
			alert("Attention! You must book a day in advance");	
		}else if(inputDateFormatted<date){
			$('.map').hide();		
			alert("Attention! The date provided has already past");		
		}else{
			$('.map').hide();		
			alert("Please provide a date!");		
		}
	});	
	
	$("#close").click(function(){
		//We do not want the user to change email address now
		
		$("#email").prop("readonly",false);
	});
	
	$("#confirmSpotBtn").click(function(){
		$.get({
			url: "./ConfirmBeachSpot",
			method: "get",
            data: {
				'user': inputMail,
                'date': inputDate,
                'time': inputTime,
                'chair': $("#spotNumber").text()
            },
			dataType: "text",
			success: function(data){
				var str= data.trim();
				if(str=="OK"){
					hideAll();
					$("#confirmationMessage").html("<div id=\"confirmationMessage\" class=\"alert alert-success\"><strong>Success!</strong> The booking was successfully added.</div>");
				}else if(str=="USER_NOT_CUSTOMER"){
					hideAll();
					$("#confirmationMessage").html("<div id=\"confirmationMessage\" class=\"alert alert-danger\"><strong>Attention!</strong> The user is not a customer.</div>");			
				}else if(str=="USER_NOT_REGISTERED"){
					hideAll();
					$("#confirmationMessage").html("<div id=\"confirmationMessage\" class=\"alert alert-danger\"><strong>Attention!</strong> The user is not registered.</div>");			
				}else if(str=="ERROR"){
					hideAll();
					$("#confirmationMessage").append("<div id=\"confirmationMessage\" class=\"alert alert-danger\"><strong>Attention!</strong> There was an error in the booking process.</div>");
				}
			}
		})
		$('#modalCenter').modal('hide');
	});

});

function changed(){
		$("#email").prop("readonly",false);
}

function hideAll(){
		$("#beachSpotInfo").hide();
		$("#beachSpotSelection").hide();
}

