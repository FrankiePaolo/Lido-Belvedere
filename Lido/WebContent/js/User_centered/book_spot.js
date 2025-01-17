// Select the desired number of columns depending of the disposition of the chairs
var numberOfColumns=3;
//The variable's value will be set by the ajax call
var numberOfChairs;

//Global variables
var inputDate ;
var inputTime ;

$(document).ready(function(){
	var inputMail ;
	var date = new Date();	
	
	//We get the users emails so the Cashier does not need to type them
	$.get("./beachSpots.json",
            {
                'op': "getEmails"
            },
            function (json) {
            	json.forEach(insertEmail);
            }); 
	 	
	//We get the total number of chairs
	$.get("./beachSpots.json",
            {
                'op': "numberOfChairs"
            },
            function (data) {
            	numberOfChairs=parseInt(data);  
            }); 

	function updateMap(){
		inputDate = $("#date").val();
		inputTime = $("#time").val();
		inputMail=  $("#email").val();
				
		var inputDateFormatted=new Date(inputDate);	
		if(inputDateFormatted>date){
			$("#confirmationMessage").replaceWith("<div id=\"confirmationMessage\"></div>");
			$("#userEmail").replaceWith("<div id=\"userEmail\">"+inputMail+"</div>")
			$("#dateBeachSpot").replaceWith("<div id=\"dateBeachSpot\">"+inputDate+"</div>");
			$("#timeBeachSpot").replaceWith("<div id=\"timeBeachSpot\">"+inputTime+"</div>");
			$('.map').show();
			loadMap(inputDate,inputTime);	
		}else if(inputDateFormatted.getDate()==date.getDate()){
			$('.map').hide();
			$("#confirmationMessage").html("<div id=\"confirmationMessage\" class=\"alert alert-danger alert-dismissible\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button><strong>Attention!</strong> You must book a day in advance.</div>");			
		}else if(inputDateFormatted<date){
			$('.map').hide();	
			$("#confirmationMessage").html("<div id=\"confirmationMessage\" class=\"alert alert-danger alert-dismissible\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button><strong>Attention!</strong> The date provided has already past.</div>");			
		}else{
			$('.map').hide();	
			$("#confirmationMessage").replaceWith("<div id=\"confirmationMessage\"></div>");
		}
	}
	
	$("#date").change(function(){
		updateMap();
	});	

	$("#time").change(function(){
		updateMap();
	});	
	
	$('#email').change(function(){
		updateMap();
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
					loadMap(inputDate,inputTime);
					$("#confirmationMessage").html("<div id=\"confirmationMessage\" class=\"alert alert-success alert-dismissible\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button><strong>Success!</strong> The booking was successfully added.</div>");
				}else if(str=="USER_NOT_CUSTOMER"){
					$("#confirmationMessage").html("<div id=\"confirmationMessage\" class=\"alert alert-danger alert-dismissible\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button><strong>Attention!</strong> The user is not a customer.</div>");			
				}else if(str=="USER_NOT_REGISTERED"){
					$("#confirmationMessage").html("<div id=\"confirmationMessage\" class=\"alert alert-danger alert-dismissible\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button><strong>Attention!</strong> The user is not registered.</div>");			
				}else if(str=="ERROR"){
					$("#confirmationMessage").append("<div id=\"confirmationMessage\" class=\"alert alert-danger alert-dismissible\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button><strong>Attention!</strong> There was an error in the booking process.</div>");
				}
			}
		})
		$('#modalCenter').modal('hide');
	});

});

//We wish to update the map of the beach every 10 seconds
function updateCall(inputDate,inputTime){
	setTimeout(function(){loadMap(inputDate,inputTime)}, 10000);
}

// Loads the beach map from the server
function loadMap (inputDateToCheck,inputTimeToCheck) {
  //We only need to issue Ajax calls regarding the current selected date and avoid looping Ajax calls with past dates
  if(inputDateToCheck==inputDate && inputTimeToCheck==inputTime){
    $.ajax({
        type: "GET",
        url: "./beachSpots.json",
        data:{
			op: 'map',
			"Date": inputDate,
			"Time": inputTime
        },
        dataType: 'json',
        async: 'true',
        cache: 'false',
        success: function(json) {
			$('.map').html("<div id=\"mapRow\"class=\"row\">");
			for(var i=1;i<=numberOfChairs;i++){
				$('#mapRow').append("<div id= \""+ i + "\" class=\"col d-flex justify-content-center\"><img style=\"cursor:pointer\" title=\"This spot is already booked\" src=\"/Lido/img/sunbedRed.png\" class=\"mapCol\"></div>");
				if(i % numberOfColumns == 0){
					$('#mapRow').append("<div class=\"w-100\">");
				}
			}
            json.forEach(insertSlot);
			//We wish to update the map of the beach every 10 seconds
			updateCall(inputDate,inputTime);
        },
    });
  }
}

//We only wish to show the available chairs
function insertSlot(slot) {
	$("#"+slot.id).replaceWith("<div class=\"col d-flex justify-content-center\"><img style=\"cursor:pointer\" onclick=\"confirmBeachSpot("+slot.id+")\" src=\"/Lido/img/sunbed.png\" class=\"mapCol\"></div>");
}

function insertEmail(row){
	$("#email").append("<option value="+row.Email+">"+row.Email+"</option>");
}

function confirmBeachSpot(i) {
	$("#spotNumber").replaceWith("<div id=\"spotNumber\">"+i+"</div>");
	$('#modalCenter').modal(focus);
}

