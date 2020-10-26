/**
 * 
 */

//var gridHeight = 2;

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
			$('.map').html('<table>');
            json.forEach(insertSlot);
			$('.map').append('</table>');
        },
        error: $('.map').html('<h2>Error loading map from server, please try again later.</h2>')
    });
}

function insertSlot(slot) {
	$('.map').append('<td onclick="alert(\'Clicked!\');">'+slot.id+'</td>');
	$('.map').append('<br>')
}
