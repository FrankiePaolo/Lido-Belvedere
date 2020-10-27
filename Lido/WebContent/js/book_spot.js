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
			$('#modalSeatsTitle').replaceWith("<h5 class=\"modal-title\" id=\"modalSeatsTitle\">Available seats</h5>");
			$('.map').show();
			loadMap(inputDate,inputTime);
		}else if(inputDateFormatted.getDate()==date.getDate()){
			$('#modalSeatsTitle').replaceWith("<div class=\"alert alert-danger\" id=\"modalSeatsTitle\"><strong>Attention!</strong> You must book a day in advance.</div>");
			$('.map').hide();
		}else{
			$('#modalSeatsTitle').replaceWith("<div class=\"alert alert-danger\" id=\"modalSeatsTitle\"><strong>Attention!</strong> The date provided has already past.</div>");
			$('.map').hide();
		}
		
	});	
	
});

