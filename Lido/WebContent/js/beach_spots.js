/**
 * 
 */

//var gridHeight = 2;

var numberOfColumns=3;

/* Loads the beach map from the server*/
function loadMap (inputDate,inputTime) {
    $.ajax({
        type: "GET",
        url: "./beachJson",
        data:{
			"Date": inputDate,
			"Time": inputTime
        },
        dataType: 'json',
        async: 'true',
        cache: 'true',
        success: function(json) {
			$('.map').html("<div id=\"mapRow\"class=\"row\">");
			for(var i=1;i<=json.length;i++){
				$('#mapRow').append("<div id= \""+ i + "\" class=\"col\"><div>");
				if(i % 3 == 0){
					$('#mapRow').append("<div class=\"w-100\"></div>");
				}
			}
			$('.map').append("<\div>");
            json.forEach(insertSlot);
        },
        error: $('.map').html('<h2>Error loading map from server, please try again later.</h2>')
    });
}

//		<div id= "+ i + " class=\"col\"><img src=\"/Lido/img/sunbed.png\" alt=\"Spot "+i+" \" class=\"img-thumbnail\"></div>

function insertSlot(slot) {
	$("#"+slot.id).replaceWith("<div class=\"col\"><img src=\"/Lido/img/sunbed.png\" class=\"img-thumbnail\"></div>");
}