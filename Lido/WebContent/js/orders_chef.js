$("#document").ready(function(){
	getOrders(insert);
	//The orders list is updated every 10 seconds
	setTimeout(function(){getOrders(insert);}, 10000);
})

function insert(data){
	$("#orders").append("<div class=\"col mt-1 mb-5\"><br/><p><b>ID</b>: "+
	data.id+"<br/><b>Status</b>: "+data.status+"</br><b>Date and time</b>: "+
	data.date+"</br></p><button title=\"Order details\" onclick=\"info("+data.id+")\"class=\"btn btn-primary\"><i class=\"fa fa-info\"></i></button>&nbsp"+
	"<button title=\"Set the order to ready\" onclick=\"setReady("+data.id+")\"class=\"btn btn-primary\"><i class=\"fa fa-check-square-o\"></i></button>&nbsp"+
	"<button title=\"Set the order to delivered\" onclick=\"setDelivered("+data.id+")\"class=\"btn btn-primary\"><i class=\"fa fa-check-square\"></i></button>"+
	"<hr/></div>");
}

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
				location.reload();
			},
	})
}

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
				location.reload();
			},
	})
}	
	
