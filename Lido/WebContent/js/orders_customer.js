$("#document").ready(function(){
	getOrders(insert);	
})

function insert(data){
	$("#orders").append("<div class=\"col mt-1 mb-5\"><br/><p><b>ID</b>: "+
	data.id+"<br/><b>Status</b>: "+data.status+"</br><b>Date and time</b>: "+
	data.date+"</br></p><button onclick=\"info("+data.id+")\"class=\"btn btn-primary\"><i class=\"fa fa-info\"></i></button><hr/></div>");
}

function info(id){
	$.ajax({
			type: "get",
			url: "./OrdersJson",
			data:{
				op:'info',
				id:id
				},
			dataType: 'json',
			async: 'true',
			cache: 'false',
			success: function(json) {
				json.forEach(insertModal);
			}
	})
}

function insertModal(data){
	$("#details").append("<div class=\"col mt-1 mb-5\"><br/><p><b>Name</b>: "+
	data.name+"<br/><b>Amount</b>: "+data.amount+"</br><b>Price</b>: "+
	data.price +"<hr/>");
	$('#modalCenter').modal(focus);
}