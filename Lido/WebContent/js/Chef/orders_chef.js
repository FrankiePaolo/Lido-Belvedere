$("#document").ready(function(){
	getOrders(insert);
	//The orders list is updated every 10 seconds
	setTimeout(function(){getOrders(insert);}, 10000);
})

function insert(data){
	
	//We wish to color the status text
	var status;
	if(data.status=="waiting"){
		status="<p class=\"text-danger\">waiting</p>";
	}else if(data.status="ready"){
		status="<p class=\"text-success\">ready</p>";
	}else if(data.status="delivered"){
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
	
