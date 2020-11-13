function getOrders(insert){
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