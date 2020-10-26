/**
 * 
 */

$(document).ready(function(){
	
	//var date = new Date();
	//var $formattedDate = date.toISOString().split("T")[0];
	
	$("#search").click(function(){
		var inputDate = $("#date").val();
		var inputTime = $("#time").val();
		
		console.log(inputDate);
		console.log(inputTime);
		loadMap(inputDate,inputTime);
	});


		
	
});

