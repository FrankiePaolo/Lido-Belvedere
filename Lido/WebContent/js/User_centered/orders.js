//We wish to update the orders list of the beach every 10 seconds
function updateCall(){
	setTimeout(function(){getOrders()}, 10000);
}

//Ajax call to get the orders
function getOrders(){
	$.ajax({
			type: "get",
			url: "./OrdersJson",
			data:{
				op:'list'
				},
			dataType: 'json',
			async: 'true',
			cache: 'true',
			success: function(json) {
				$("#orders").html("<div id=\"orders\"></div>");
				json.forEach(insert);
			},
	})
	updateCall();
}

//Method to get the order info
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

//Method to populate the modal
function insertModal(data){
	$("#details").append("<div class=\"col mt-1 mb-5\"><br/><p><b>Name</b>: "+
	data.name+"<br/><b>Quantity</b>: "+data.quantity+"</br><b>Price</b>: "+
	data.price*data.quantity+"&euro;" +"<hr/>");
	$('#modalCenter').modal(focus);
}