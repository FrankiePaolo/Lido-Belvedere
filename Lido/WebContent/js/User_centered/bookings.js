//This boolean variables allows us to control the looping Ajax calls 
loopAll = false;
loopFiltered = false;

$(document).ready(function(){
	//We get the Users emails so the Cashier does not need to type them
	$.get("./beachSpots.json",
            {
                'op': "getEmails"
            },
            function (json) {
            	json.forEach(insertEmail);
            }); 
	
	$("#find_all").click(function(){
		//This boolean variable allows the looping calls to update the list of all the bookings 
		loopAll = true;
		//Ajax call to gather all the bookings
		findAll();
		//Shows the modal
		$('#modalCenter').modal("show");	
	});
	
	$("#filter_bookings").click(function(){	
		//We check that the user has provided chair and date values
		if(!$("#spot").val()){
			alert("Attention: please provide a chair number.");
			return;
		}else if(!$("#date").val()){
			alert("Attention: please provide a date.");
			return;		
		}else{
			loopFiltered=true;
			filter();
			$('#modalCenter').modal("show");
		}
	});
	
	//When we close the modal we wish to stop the Ajax requests
	$("#close").click(function(){
		loopAll=false;
		loopFiltered=false;
	})
});

//Ajax call to gather all the bookings
function findAll(){
	if(loopAll){
		$.ajax({
				type: "get",
				url: "./BookingsJson",
				data:{
					user:$("#email").val(),
					future: $('#future_bookings').is(":checked")
				},
					dataType: 'json',
					async: 'true',
					cache: 'true',
					success: function(json) {
						//We first clear the modal
						$("#bookings").html("<div id=\"bookings\"></div>");
						json.forEach(insert);
						updateCall();
					},
		  });	
	}
}

//Ajax call to gather the filtered bookings
function filter(){
	if(loopFiltered){
		$.ajax({
				//We send a POST request to hide the user data from the URL
				type: "post",
				url: "./FilterBookingsJson",
				data:{
					chair: $("#spot").val(),
					date: $("#date").val(),
					time: $("#time").val(),
					user: $("#email").val(),	
					past: $("#past_bookings").is(":checked")
					},
				dataType: 'json',
				async: 'false',
				cache: 'false',
				success: function(json) {
					//We first clear the modal
					$("#bookings").html("<div id=\"bookings\"></div>");
					json.forEach(insert);
					updateFilterCall();
				},
			})	
	}
}

//We wish to update the list of all the bookings every 10 seconds
function updateCall(){
	if(loopAll){
		setTimeout(function(){findAll()}, 10000);
	}
}

//We wish to update the list of the filtered bookings every 10 seconds
function updateFilterCall(){
	if(loopFiltered){
		setTimeout(function(){filter()}, 10000);
	}
}

//This methods inserts all the emails for the Users so that the Cashier does not need to type them
function insertEmail(row){
	$("#email").append("<option value="+row.Email+">"+row.Email+"</option>")
}

//This methods inserts the bookings
function insert(element){
	date=new Date();
	var dateToCompare = new Date(element.date);	
	
	//We can only remove future bookings so we need to check the date first
	if(dateToCompare>date){
		$("#bookings").append("<div id=\"bookingContainer\" class=\"container p-3 my-3 border\"><p><b>"+
		"Seat number:</b> "+element.id+" <b>Date:</b> "+element.date+" <b>Time:</b> "+element.time+"</p>"+
		"<button class=\"btn btn-danger\" onclick=\"removeElement('"+element.id+"','"+element.date+"','"+element.time+"')\" data-dismiss=\"modal\" ><i class=\"fa fa-trash\" ></i></button></div>");
	}else{
		$("#bookings").append("<div id=\"bookingContainer\" class=\"container p-3 my-3 border\"><p><b>"+
		"Seat number:</b> "+element.id+" <b>Date:</b> "+element.date+" <b>Time:</b> "+element.time+"</p></div>");
	}	 

}

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

//This method hides the page
function hideAll(){
	$("#container").hide();
	$("#modalCenter").hide();
}

