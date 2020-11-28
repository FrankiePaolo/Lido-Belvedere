$("#document").ready(function(){
	getOrders(insert);
})

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

//This method adds the orders 
function insert(data){
	
	//We wish to color the status text
	var status;
	if(data.status=="waiting"){
		status="<p class=\"text-danger\">waiting</p>";
	}else if(data.status=="ready"){
		status="<p class=\"text-success\">ready</p>";
	}else if(data.status=="delivered"){
		status="<p class=\"text-primary\">delivered</p>";
	}
	
	$("#orders").append("<div class=\"col mt-1 mb-5\"><div class=\"row\"><div class=\"col-sm\"><b>ID</b>:</div><div class=\"col-sm\">"+
	data.id+"</div></div><div class=\"row\"><div class=\"col-sm\"><b>Status</b>:</div><div class=\"col-sm\">"+status+"</div></div>"+
	"<div class=\"row\"><div class=\"col-sm\"><b>Date and time</b>:</div><div class=\"col-sm\">"+
	data.date+"</div></div><button title=\"Order details\" onclick=\"info("+data.id+")\"class=\"btn btn-primary\"><i class=\"fa fa-info\"></i></button>&nbsp"+
	"<button title=\"Set the order to ready\" onclick=\"setReady("+data.id+")\"class=\"btn btn-primary\"><i class=\"fa fa-check-square-o\"></i></button>&nbsp"+
	"<button title=\"Set the order to delivered\" onclick=\"setDelivered("+data.id+")\"class=\"btn btn-primary\"><i class=\"fa fa-check-square\"></i></button>"+
	"<hr/></div>");
}

//Sets the order with the gived id as ready
function setReady(id){
	$.ajax({
			type: "get",
			url: "./ManageOrder",
			data:{
				state:'ready',
				id:id
				},
			async: 'true',
			cache: 'false',
			success: function() {
				getOrders();
			},
	})
}

//Sets the order with the gived id as delivered
function setDelivered(id){
	$.ajax({
			type: "get",
			url: "./ManageOrder",
			data:{
				state:'delivered',
				id:id
				},
			async: 'true',
			cache: 'false',
			success: function() {
				getOrders();
			},
	})
}	
