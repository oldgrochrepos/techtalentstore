$(document).ready(function () {

	$('.add-to-cart-button').click(function () { 
		var value = $(this).siblings('.quantity').val();

		var value_int = parseInt(value);

		var product_id = $(this).data('product-id');
		var product_name = $(this).data('product-name');
		var price = $(this).data('price');

		if(value_int > 0){
			//Make an AJAX call
			$.post('/store/add_to_cart', {
				quantity : value_int,
				product_id : product_id,
				product_name : product_name,
				price : price
			});

		}else{
			alert('C\'mon. Don\'t be like that.')
		}
	});
});