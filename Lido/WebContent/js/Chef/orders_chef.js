$("#document").ready(function(){
	getOrders(insert);
})

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

//Sets the order with the given id as ready
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
			dataType: "text",
			success: function(message){
				var str= message.trim();
				if(str=="UNEXPECTED_ERROR"){
					$("#confirmationMessage1").html("<div id=\"confirmationMessage1\" class=\"alert alert-danger success alert-dismissible\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button><strong>Attention!</strong> There was an unexpected issue.</div>");
					return;
				}else if(str=="WRONG_ID"){						
					$("#confirmationMessage1").html("<div id=\"confirmationMessage1\" class=\"alert alert-success alert-dismissible\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button><strong>Success!</strong> The ID provided is not allowed.</div>");					
					return;
				}else if(str=="OK"){						
					getOrders();
				}
			},
	})
}

//Sets the order with the given id as delivered
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
			dataType: "text",
			success: function(message){
				var str= message.trim();
				if(str=="UNEXPECTED_ERROR"){
					$("#confirmationMessage1").html("<div id=\"confirmationMessage1\" class=\"alert alert-danger success alert-dismissible\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button><strong>Attention!</strong> There was an unexpected issue.</div>");
					return;
				}else if(str=="WRONG_ID"){						
					$("#confirmationMessage1").html("<div id=\"confirmationMessage1\" class=\"alert alert-success alert-dismissible\"><button type=\"button\" class=\"close\" data-dismiss=\"alert\">&times;</button><strong>Success!</strong> The ID provided is not allowed.</div>");					
					return;
				}else if(str=="OK"){						
					getOrders();
				}
			},
	})
}	
