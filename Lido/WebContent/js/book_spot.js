/**
 * 
 */

$(document).ready(function(){
		
	var date = new Date();	
	$("#search").click(function(){
		var inputDate = $("#date").val();
		var inputTime = $("#time").val();
		
		var inputDateFormatted=new Date(inputDate);
		
		if(inputDateFormatted>date){
			$("#dateBeachSpot").replaceWith("<div id=\"dateBeachSpot\">"+inputDate+"</div>");
			$("#timeBeachSpot").replaceWith("<div id=\"dateBeachSpot\">"+inputTime+"</div>");
			$('.map').show();
			loadMap(inputDate,inputTime);
					console.log($("#dateBeachSpot").text());

			
		}else if(inputDateFormatted.getDate()==date.getDate()){
			$('.map').hide();		
			alert("Attention! You must book a day in advance");	
		}else{
			$('.map').hide();		
			alert("Attention! The date provided has already past");		
		}
	});	
	
	$("#confirmSpotBtn").click(function(){
		$.get("./ConfirmBeachSpot",
            {
                'date': $("#dateBeachSpot").text(),
                'time': $("#timeBeachSpot").text(),
                'chair': $("#spotNumber").text()
            }
		)
		$('#modalCenter').modal('hide');
	});



});

