// Select the desired number of columns depending of the disposition of the chairs
var numberOfColumns=3;

//The variable's value will be set by the ajax call
var numberOfChairs;

$(document).ready(function(){
	 $.get("./beachJson",
            {
                'op': "numberOfChairs"
            },
            function (data) {
            	numberOfChairs=parseInt(data);  
            }); 
});

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

