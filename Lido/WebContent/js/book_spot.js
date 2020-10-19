/**
 * 
 */

$(document).ready(function(){
	
	//This returns the current date
	var current_date=new Date();
	//This returns the current time
	var current_time=(current_date.getHours() >=12? "Afternoon" : "Morning");
	
	var $inputDate=$("input[name='date']");
	
	//Sets the minimum date, which is obviousely the current date
	$inputDate.attr("min",current_date.toISOString().split("T")[0]);
	
	console.log($inputDate);
});