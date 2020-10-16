/**
 * 
 */

$(document).ready(function(){
	var current_date=new Date();
	var time=(date.getHours() <=12? "Afternoon" : "Morning");
	
	var $inputDate=$("input[name='date']");
	
	//We get only the date
	$inputDate.attr("min",date.toIsoString().split("T")[0]);
});