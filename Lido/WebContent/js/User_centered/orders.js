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
				//We need to clear the modal
				$("#details").html("<div id=\"details\"></div>");
				json.forEach(insertModal);
			}
	})
}

function insertModal(data){
	$("#details").append("<div class=\"col mt-1 mb-5\"><br/><p><b>Name</b>: "+
	data.name+"<br/><b>Quantity</b>: "+data.quantity+"</br><b>Price</b>: "+
	data.price*data.quantity+"&euro;" +"<hr/>");
	$('#modalCenter').modal(focus);
}