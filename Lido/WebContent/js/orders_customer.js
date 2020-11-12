$("#document").ready(function(){
	$.ajax({
			type: "get",
			url: "./OrdersJson",
			data:{
				op:'list'
				},
			dataType: 'json',
			async: 'true',
			cache: 'false',
			success: function(json) {
				json.forEach(insert);
			},
	})	
})

function insert(data){
	$("#orders").append("<div class=\"col mt-1 mb-5\"><br/><p><b>ID</b>: "+
	data.id+"<br/><b>Status</b>: "+data.status+"</br><b>Date and time</b>: "+
	data.date+"</br></p><button class=\"btn btn-primary\"><i class=\"fa fa-info\"></i></button><hr/></div>");
}