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

	$('.delete-from-cart-button').click(function () {
		$.post('/store/remove_from_cart');
	});

	$(document).on('click', '#toggle_cart_button', function () {

		var display = $('#cart_detail_panel').css('display');
		if (display == "none"){
			$('#cart_detail_panel').slideDown();
		}else{
			$('#cart_detail_panel').slideUp();
		}
	});
});