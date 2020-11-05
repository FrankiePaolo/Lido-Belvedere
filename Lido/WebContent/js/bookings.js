// Mail format regex
var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
var date;	


$(document).ready(function(){
	date=new Date();
	
	//The user wants to see all the bookings
	$("#find_all").click(function(){
		checkMail($("#user_all"),"false");
		$("#bookings").html("<div id=\"bookings\"></div>");
	});
	
	//The user only wants to see future bookings
	$("#find_all_future").click(function(){
		checkMail($("#user_future"),"true");
		$("#bookings").html("<div id=\"bookings\"></div>");
	});
	
	//When we filter bookings we need to check that the email,the chair and the date are valid
	$("#filter_bookings").click(function(){
		if($("#user").length && !$("#user").val()){
			alert("Attention: please provide an email.");
			return;
		}else if($("#user").length && !$("#user").val().match(mailformat)){
			alert("Attention: email format not valid.");
			return;
		}else if(!$("#spot").val()){
			alert("Attention: please provide a chair number.");
			return;
		}else if(!$("#date").val()){
			alert("Attention: please provide a date.");
			return;		
		}else if($("#user").length && $("#spot").val() && $("#date").val()){
			$.get({
				url: "./CheckMail",
				method: "get",
	            data: {
					user: $("#user").val(),
	            },
				dataType: "text",
				async: 'true',
				success: function(data){
					//The servlet checks wheather the user is registered and is a Customer 
					var str= data.trim();
					if(str=="USER_NOT_CUSTOMER"){
						alert("Attention: The user is not a customer.");
						return;
					}else if(str=="USER_NOT_REGISTERED"){
						alert("Attention: The user is not registered.");
						return;
					}else{
						$.ajax({
							//We send a POST request to hide the user data from the URL
					        type: "POST",
					        url: "./FilterBookingsJson.json",
					        data:{
								chair: $("#spot").val(),
								date: $("#date").val(),
								time: $("#time").val(),
								user: $("#user").val(),
								past: String($("#past_bookings").is(":checked")),
					        },
					        dataType: 'json',
							async: 'true',
					        cache: 'true',
					        success: function(json) {
								json.forEach(insert);
					        },
					    });	
						$('#modalCenter').modal("show")
						$("#bookings").html("<div id=\"bookings\"></div>");
					}	
				}
			})		
		}else{
			$.ajax({
				//We send a POST request to hide the user data from the URL
				type: "POST",
				url: "./FilterBookingsJson.json",
				data:{
					chair: $("#spot").val(),
					date: $("#date").val(),
					time: $("#time").val(),
					user: $("#user").val(),
					past: String($("#past_bookings").is(":checked")),
				},
					dataType: 'json',
					async: 'true',
					cache: 'true',
					success: function(json) {
						json.forEach(insert);
					},
				});	
			$('#modalCenter').modal("show")
			$("#bookings").html("<div id=\"bookings\"></div>");				
		}
						
	});
});

//This method removes a booking
function removeElement(id,date,time){
	$.get({
		url: "./RemoveBooking",
		method: "get",
	    data: {
			id: id,
			date: date,
			time: time,
	    },
		dataType: "text",
		success: function(message){
			var str= message.trim();
			if(str=="ERROR"){
				hideAll();
				$("#confirmationMessage1").html("<div id=\"confirmationMessage1\" class=\"alert alert-danger\"><strong>Attention!</strong> There was an unexpected issue.</div>");
				return;
			}else if(str=="OK"){						
				hideAll();
				$("#confirmationMessage1").html("<div id=\"confirmationMessage1\" class=\"alert alert-success\"><strong>Success!</strong> The booking was successfully removed.</div>");					return;	
			}
		}
	})
}

function insert(element){
	var dateToCompare = new Date(element.date);	
	
	//We can only remove future bookings so we need to check first
	if(dateToCompare>date){
		$("#bookings").append(" <div id=\"bookingContainer\" class=\"container p-3 my-3 border\"><p><b>"+
		"Seat number:</b> "+element.id+" <b>Date:</b> "+element.date+" <b>Time:</b> "+element.time+"</p>"+
		"<button class=\"btn btn-danger\" onclick=\"removeElement('"+element.id+"','"+element.date+"','"+element.time+"')\" data-dismiss=\"modal\" ><i class=\"fa fa-trash\" ></i></button></div>");
	}else{
		$("#bookings").append(" <div id=\"bookingContainer\" class=\"container p-3 my-3 border\"><p><b>"+
		"Seat number:</b> "+element.id+" <b>Date:</b> "+element.date+" <b>Time:</b> "+element.time+"</p></div>");
	}	 

}

//This method hides the page
function hideAll(){
	$("#container").hide();
	$("#modalCenter").hide();
}

function checkMail(mail,futureString){
	//If user is a Customer there is no input mail
	if(!mail.length){
		 $.ajax({
				type: "GET",
				url: "./bookings.json",
				data:{
					future: futureString,
				},
					dataType: 'json',
					async: 'false',
					cache: 'true',
					success: function(json) {
						json.forEach(insert);
					},
		  });	
		  $('#modalCenter').modal("show");
	}else if(!mail.val()){
		alert("Attention: please provide an email.");
		return;
	}else if(!mail.val().match(mailformat)){
		alert("Attention: email format not valid.");
		return;
	}else{
		$.get({
			url: "./CheckMail",
			method: "get",
	        data: {
				user: mail.val(),
	        },
				dataType: "text",
				async: 'true',
				success: function(data){
					//If user is a Cashier we need to check if the email provided is registered and belongs to a Customer
					var str= data.trim();
					if(str=="USER_NOT_CUSTOMER"){
						alert("Attention: The user is not a customer.");
						return;
					}else if(str=="USER_NOT_REGISTERED"){
						alert("Attention: The user is not registered.");
						return;
					}else{						
						 $.ajax({
					        type: "GET",
					        url: "./bookings.json",
					        data:{
								future: futureString,
								user: mail.val()
					        },
					        dataType: 'json',
							async: 'true',
					        cache: 'true',
					        success: function(json) {
								json.forEach(insert);
					        },
					    });	
						$('#modalCenter').modal("show");
					}
				}
			})
	}
}


