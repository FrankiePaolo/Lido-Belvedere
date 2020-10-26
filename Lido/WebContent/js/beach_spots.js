/**
 * 
 */


// Select the desired number of columns depending of the disposition of the chairs
var numberOfColumns=3;
var numberOfChairs=3;
getNumberOfChairs();

// Loads the beach map from the server
function loadMap (inputDate,inputTime) {
    $.ajax({
        type: "GET",
        url: "./beachJson",
        data:{
			op: 'map',
			"Date": inputDate,
			"Time": inputTime
        },
        dataType: 'json',
        async: 'true',
        cache: 'true',
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
        error: $('.map').html('<h2>Error loading map from server, please try again later.</h2>')
    });
}

function insertSlot(slot) {
	$("#"+slot.id).replaceWith("<div class=\"col d-flex justify-content-center\"><img src=\"/Lido/img/sunbed.png\" class=\"mapCol\"></div>");
}

function getNumberOfChairs(){
	    $.ajax({
	        type: "GET",
	        url: "./beachJson",
	        data:{
				op: 'numberOfChairs',
	        },
	        dataType: 'json',
	        async: 'true',
	        cache: 'true',
        	success: function(json) {
				json.forEach(function(num){
					numberOfChairs=parseInt(num.count);
				}); 
			}
        });	
}





