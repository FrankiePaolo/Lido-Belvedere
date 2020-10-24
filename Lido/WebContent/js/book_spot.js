/**
 * 
 */

$.ajaxSetup({cache: false});

$(document).ready(function(){
	var date = new Date();
	var time = (date.getHours()>=12?"PM":"AM");
	
	loadMap();
	
	
});
