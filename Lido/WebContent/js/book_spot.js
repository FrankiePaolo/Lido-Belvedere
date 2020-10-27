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
			$('.map').show();
			loadMap(inputDate,inputTime);
		}else if(inputDateFormatted.getDate()==date.getDate()){
			$('.map').hide();		
			alert("Attention! You must book a day in advance");	
		}else{
			$('.map').hide();		
			alert("Attention! The date provided has already past");		
		}
	});	


});

