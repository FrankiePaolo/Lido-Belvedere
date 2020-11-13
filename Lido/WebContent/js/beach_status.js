// Select the desired number of columns depending of the disposition of the chairs
var numberOfColumns=3;

$(document).ready(function(){
	var numberOfChairs;
	var date=new Date();
	var day=date.toISOString().split("T")[0];
	var time=(date.getHours()>=12?"Afternoon":"Morning");
	
	//The first ajax call will set the numberOfChairs, the second ajax call will populate the map
	$.ajax({
        type: "GET",
        url: "./beachSpots.json",
        data:{
			op: 'numberOfChairs',
        },
        async: 'false',
		success: function(data){
			numberOfChairs=parseInt(data);  
			populateMap(numberOfChairs,day,time);

		}
	})
})

//We wish to update the map of the beach every 10 seconds
function updateCall(numberOfChairs,day,time){
	setTimeout(function(){populateMap(numberOfChairs,day,time)}, 10000);
}

//The ajax call to populate the beach map
function populateMap(numberOfChairs,day,time){
	$.ajax({
		type: "GET",
	    url: "./beachSpots.json",
	    data:{
			Date: day,
			Time: time,
			op: 'beachStatus',
		},
		async: 'true',
		cache: 'true',
		success: function(json) {
			$('.map').html("<div id=\"mapRow\"class=\"row\">");
			for(var i=1;i<=numberOfChairs;i++){
				$('#mapRow').append("<div id= \""+ i + "\" class=\"col d-flex justify-content-center\"><i title=\"This place is not booked\" class=\"fa fa-ban\" style=\"font-size:36px;\"></i><div>");
				if(i % numberOfColumns == 0){
					$('#mapRow').append("<div class=\"w-100\">");
				}
			}	
			json.forEach(insertSlot);        
		},
	})
	updateCall(numberOfChairs,day,time);
}

//This method replaces only the booked spots so that the Lifeguard only sees spots that have been booked at the time the request is made
function insertSlot(slot){
	$("#"+slot.Chair_ID).replaceWith("<div class=\"col d-flex justify-content-center\"><img style=\"cursor:pointer\" onclick=\"spotInfo('"+slot.FirstName+"','"+slot.LastName+"','"+slot.Email+"','"+slot.Chair_ID +"')\" src=\"/Lido/img/sunbed.png\" class=\"mapCol\"></div>");
}

//This methods shows info related to a beach spot in a Modal
function spotInfo(FirstName,LastName,Email,Chair_ID){
		$("#userFirstName").replaceWith("<div id=\"userFirstName\"><p>"+FirstName+"</p></div>");
		$("#userLastName").replaceWith("<div id=\"userLastName\"><p>"+LastName+"</p></div>");
		$("#userEmail").replaceWith("<div id=\"userEmail\"><p>"+Email+"</p></div>");
		$("#spotNumber").replaceWith("<div id=\"spotNumber\"><p>"+Chair_ID+"</p></div>");
		//Focuses on the modal
		$('#modalCenter').modal(focus);
}