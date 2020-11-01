// Mail format regex
var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
var date;	


$(document).ready(function(){
	date=new Date();
	$("#find_all").click(function(){
		checkMail($("#user_all"),"false");
		$("#bookings").html("<div id=\"bookings\"></div>");
	});
	
	$("#find_all_future").click(function(){
		checkMail($("#user_future"),"true");
		$("#bookings").html("<div id=\"bookings\"></div>");
	});
	
	$("#filter_bookings").click(function(){
		if($("#user").length && !$("#user").val()){
			alert("Attention: please provide an email.")
			return;
		}else if($("#user").length && !$("#user").val().match(mailformat)){
			alert("Attention: email format not valid.")
			return;
		}else if(!$("#spot").val()){
			alert("Attention: please provide a chair number.")
			return;
		}else if(!$("#date").val()){
			alert("Attention: please provide a date.")
			return;		
		}else if($("#user").length && $("#spot").val() && $("#date").val()){
			$.get({
				url: "./CheckMail",
				method: "get",
	            data: {
					user: $("#user").val(),
	            },
				dataType: "text",
				success: function(data){
					var str= data.trim();
					if(str=="USER_NOT_CUSTOMER"){
						alert("Attention: The user is not a customer.");
						return;
					}else if(str=="USER_NOT_REGISTERED"){
						alert("Attention: The user is not registered.");
						return;
					}else{
						$.ajax({
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

function insert(element){
	var dateToCompare = new Date(element.date);	
	if(dateToCompare>date){
		$("#bookings").append(" <div id=\"bookingContainer\" class=\"container p-3 my-3 border\"><p><b>"+
		"Seat number:</b> "+element.id+" <b>Date:</b> "+element.date+" <b>Time:</b> "+element.time+"</p>"+
		"<button class=\"btn btn-danger\"><i class=\"fa fa-trash\"></i></button></div>");
	}else{
		$("#bookings").append(" <div id=\"bookingContainer\" class=\"container p-3 my-3 border\"><p><b>"+
		"Seat number:</b> "+element.id+" <b>Date:</b> "+element.date+" <b>Time:</b> "+element.time+"</p></div>");
	}	 
}

function checkMail(mail,futureString){
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
						$('#modalCenter').modal("show")
	}else if(!mail.val()){
		alert("Attention: please provide an email.")
		return;
	}else if(!mail.val().match(mailformat)){
		alert("Attention: email format not valid.")
		return;
	}else{
		$.get({
				url: "./CheckMail",
				method: "get",
	            data: {
					user: mail.val(),
	            },
				dataType: "text",
				success: function(data){
					var str= data.trim();
					if(str=="USER_NOT_CUSTOMER"){
						alert("Attention: The user is not a customer.");
						return;
					}else if(str=="USER_NOT_REGISTERED"){
						alert("Attention: The user is not registered.");
						return;
					}else{						
						 $.ajax({
					        type: "POST",
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
						$('#modalCenter').modal("show")
					}
				}
			})
	}
}


