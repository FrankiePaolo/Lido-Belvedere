// Select the desired number of columns depending of the disposition of the chairs
var numberOfColumns=3;
//The variable's value will be set by the ajax call
var numberOfChairs;



$(document).ready(function(){
	$.get("./beachSpots.json",
		{
			'op': "numberOfChairs"
		},
		function (data) {
			numberOfChairs=parseInt(data);  
		}); 
	



})