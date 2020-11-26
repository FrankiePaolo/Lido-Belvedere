$("#document").ready(function(){
	getOrders(insert);	
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
	
	$("#orders").append("<div class=\"col mt-1 mb-5\"><br/><div class=\"row\"><div class=\"col-sm\"><b>ID</b>:</div><div class=\"col-sm\">"+
	data.id+"</div></div><div class=\"row\"><div class=\"col-sm\"><b>Status</b>:</div><div class=\"col-sm\">"+status+"</div></div>"+
	"<div class=\"row\"><div class=\"col-sm\"><b>Date and time</b>:</div><div class=\"col-sm\">"+
	data.date+"</div></div><div class=\"row\"><div class=\"col-sm\"><button title=\"Order details\" onclick=\"info("+data.id+")\"class=\"btn btn-primary\"><i class=\"fa fa-info\"></i></button></div></div><hr/>");
}