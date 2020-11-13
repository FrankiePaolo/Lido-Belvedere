// Mail format regex
var mailformat = /^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$/;
// Select the desired number of columns depending of the disposition of the chairs
var numberOfColumns=3;
//The variable's value will be set by the ajax call
var numberOfChairs;

$(document).ready(function(){
	var inputDate ;
	var inputTime ;
	var inputMail ;
	var date = new Date();	
	 	
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
		}
	}
	
	$("#date").change(function(){
		updateMap();
	});	

	$("#time").change(function(){
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

function hideAll(){
		$("#beachSpotInfo").hide();
		$("#beachSpotSelection").hide();
}

// Loads the beach map from the server
function loadMap (inputDate,inputTime) {
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
				$('#mapRow').append("<div id= \""+ i + "\" class=\"col\"><div>");
				if(i % numberOfColumns == 0){
					$('#mapRow').append("<div class=\"w-100\">");
				}
			}
            json.forEach(insertSlot);
        },
    });
}

//We only wish to show the available chairs
function insertSlot(slot) {
	$("#"+slot.id).replaceWith("<div class=\"col d-flex justify-content-center\"><img style=\"cursor:pointer\" onclick=\"confirmBeachSpot("+slot.id+")\" src=\"/Lido/img/sunbed.png\" class=\"mapCol\"></div>");
}

function confirmBeachSpot(i) {
	$("#spotNumber").replaceWith("<div id=\"spotNumber\">"+i+"</div>");
	$('#modalCenter').modal(focus);
}

