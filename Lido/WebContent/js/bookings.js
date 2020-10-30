// Mail format regex
var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
var date;	


$(document).ready(function(){
	date=new Date();

	$("#find_all").click(function(){
		$("#bookings").html("<div id=\"bookings\"></div>");
	    $.ajax({
	        type: "GET",
	        url: "./bookings.json",
	        data:{
				user: $("#user_all").val()
	        },
	        dataType: 'json',
	        async: 'false',
	        cache: 'true',
	        success: function(json) {
				json.forEach(insert);
	        },
	    });		
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

