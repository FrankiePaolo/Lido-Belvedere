// Mail format regex
var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
var date;	

$(document).ready(function(){
	date=new Date();
	//We need to check whether the user only wants to see future bookings or not
	var futureBookings=document.getElementById('future_bookings');
	//We need to check if we have the mail input field
	var inputMail=false;
	$("#find_all").click(function(){
		
		//The user is a Cashier so there is an input mail field for Customer email
		if($("#user_all").length){
			inputMail=true;
		}
		
		if(futureBookings.checked==true){
			//The user only wants to see future bookings
			checkMail(inputMail,$("#user_all").val(),"true");
		}else{
			//The user wants to see all the bookings
			checkMail(inputMail,$("#user_all").val(),"false");
		}
		$("#bookings").html("<div id=\"bookings\"></div>");
	});
	
	//When we filter bookings we need to check that the email,the chair and the date are valid
	$("#filter_bookings").click(function(){	
		
		//The user is a Cashier so there is an input mail field for Customer email
		if($("#user").length){
			inputMail=true;
		}
		//The email value
		mailValue=$("#user").val();
			
		if(inputMail && !mailValue){
			alert("Attention: please provide an email.");
			return;
		}else if(inputMail && !mailValue.match(mailformat)){
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
					}
				}
			})
		}	
		
		$.ajax({
			//We send a POST request to hide the user data from the URL
			type: "post",
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
		})
			$('#modalCenter').modal("show");
			$("#bookings").html("<div id=\"bookings\"></div>");		
	})					
})


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
	
	//We can only remove future bookings so we need to check the date first
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

function checkMail(inputMail,mailValue,futureString){

	//If user is a Customer then there is no input mail field
	if(!inputMail){
		 $.ajax({
				type: "get",
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
	}else if(inputMail && !mailValue){
		alert("Attention: please provide an email.");
		return;
	}else if(inputMail && !mailValue.match(mailformat)){
		alert("Attention: email format not valid.");
		return;
	}else{
		$.get({
			url: "./CheckMail",
	        data: {
				user: mailValue
	        },
			dataType: "text",
			async: 'false',
			success: function(data){
				//If user is a Cashier we need to check if the email provided is registered and belongs to a Customer
				var str= data.trim();
				if(str=="USER_NOT_CUSTOMER"){
					alert("Attention: The user is not a customer.");
					return;
				}else if(str=="USER_NOT_REGISTERED"){
					alert("Attention: The user is not registered.");
					return;
				}else if(str=="OK"){						
					 $.ajax({
				        type: "GET",
				        url: "./bookings.json",
				        data:{
							future: futureString,
							user: mailValue
				        },
				        dataType: 'json',
						async: 'false',
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


