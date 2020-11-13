function getOrders(insert){
	$("#orders").html("<div id=\"orders\"></div>");
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
	$("#details").html("<div class=\"col mt-1 mb-5\"><br/><p><b>Name</b>: "+
	data.name+"<br/><b>Amount</b>: "+data.amount+"</br><b>Price</b>: "+
	data.price+"&euro;" +"<hr/>");
	$('#modalCenter').modal(focus);
}