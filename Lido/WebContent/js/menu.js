var cart; // This variable holds the cart info, gets synchronized with server on every edit.

$(document).ready(function () {
    getCart();

    $.ajax({
        type: "get",
        url: './menu.json',
        dataType: 'json',
        async: 'true',
        cache: 'false',
        success: function(json) {
            var menu = $('#menu');
            menu.html('<h2 class="mb-5">Menu</h2>');
            makeMenu(json);
            menu.append('<div id="summary"></div> <br/> <div class="row"><div class="col-sm"> <button type="button" class="btn btn-primary mb-3" '+
				'id="submit_order">Confirm</button> </div> <div class="col-sm"><button type="button" class="btn btn-secondary mb-3" id="cancel_order">Clear</button></div></div>');
            $('#submit_order').click(function(){
                if(cart.length>0){
                    //window.location.replace("./confirm_order");
					console.log(cart);
                } else {
                    alert("No items selected");
                }
            });

            $('#cancel_order').click(function(){
                $.ajax({
					type:"get",
					url:"./CartController", 
					cache:"false",  
					data:
					{
						op:'clear'
					},
					success: function(){
						getCart();
					}
				});
            });
        },
    });
});

/* After every edit to the cart the form is set to match the cart, so that what
 * the user sees is synchronized with the server.
 */

$(document).ajaxStop(function () {
	//So that when we Clear we clear the values for the input fields
    $("input").val("0");
    var total=0;
    for(var i = 0; i < cart.length; i++){
        $("input[name='"+cart[i].id+"']").val(cart[i].amount);
        total+=cart[i].amount*cart[i].price;
    }
    $('#summary').html("<b>Tot. <span class='r_float'>"+total.toFixed(2)+"€</span> </b>")
});

function getCart() {
    $.getJSON('./CartController',
        {
			op:'get'
		},
        function (data) {
            cart = data;
    	}
	);
}

function makeMenu(menuJson) {
    // It populates the menu
    menuJson.forEach(function (item) {
        insertCategory(item.category);
        insertItem(item);
    });

    // When the item amount changes the server gets notified and the updated cart is requested.
    $('.item_amount').change( function () {
        var amount = $(this).val() ? $(this).val() : 0;

        // The selected items are considered to be sensitive data, hence POST is used.
        $.post('./CartController',
            {
                op:'set',
                id: $(this).attr('name'),
                amount: amount
            },
            function (retMsg) {
                switch (retMsg.trim()) {
                    case "OK":
                        break;
                    case "ILLEGAL_DATA":
                        alert("Invalid data detected");
                        break;
                    default:
                        alert("Something went wrong, please try again later");
                  }
                getCart();
        });
    })
}

// Adds the item category if it is not already in the menu
function insertCategory(category) {
    if( $('#'+category).length===0){
        $('#menu').append("<div id='"+category+"'><h3>"+category+"</h3></div><hr/>");
    }
}

// Adds item information to the relevant category
function insertItem(item) {
    $('#'+item.category).append("<div" +
        "<b>" + item.name + "</b><span style='float: right'>" + item.price + "&euro;</span><br />" +
        "<em>" + item.description + " " + "</em> "+ 
		"<input class=\"ml-5 item_amount\" style='float: right; width: 6ch' type='number' min='0' max='20' name="+item.id+" />" +
        "<hr style='border-width: 0' /></div>&nbsp;");
}
