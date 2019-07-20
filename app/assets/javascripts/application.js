// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require activestorage
//= require turbolinks
//= require_tree .
//= require jquery3
//= require popper
//= require bootstrap-sprockets

function calculatePerItem (itemKey, productId, qty) {
	$.ajax({
		url: '/products/' + productId + '.json',
		method: 'get',
		success: function (product) {
			var price = product.price
			var subTotal = price * qty;
			$('#order_items_attributes_'+itemKey+'_price').val(price);
			$('#order_items_attributes_'+itemKey+'_sub_total').val(subTotal);	
		}
	});
}

$(document).on('turbolinks:load', function() {

  	$('form').on('click', '.remove_record', function(event) {
		$(this).prev('input[type=hidden]').val('1');
		$(this).closest('tr').hide();
		return event.preventDefault();
  	});

  	$('form').on('click', '.add_fields', function(event) {
		var regexp, time;
		time = new Date().getTime();
		regexp = new RegExp($(this).data('id'), 'g');
		$('.fields').append($(this).data('fields').replace(regexp, time));
		return event.preventDefault();
  	});

  	$('form').on('change', '.select-item', function(event) {
  		var itemKey = $(this).attr('id').replace(/\D/g,'');
  		var productId = $(this).val();
  		var qty = $('#order_items_attributes_'+itemKey+'_qty').val();

  		calculatePerItem(itemKey, productId, qty);
  	});

  	$('form').on('keyup', '.qty-item', function(event) {
  		var itemKey = $(this).attr('id').replace(/\D/g,'');
  		var productId = $('#order_items_attributes_'+itemKey+'_product_id').val();
  		var qty = $(this).val();

  		calculatePerItem(itemKey, productId, qty);
  	});
  
  	$('form').on('keyup', '#payment_amount', function(event) {
  		var orderID = $('#payment_order_id').val();
  		var paymentAmount = $('#payment_amount').val();
  		$.ajax({
  			url: '/orders/' + orderID + '.json',
  			method: 'get',
  			success: function (order) {
  				var changeAmount  = 0;
  				if (order.grand_total < paymentAmount) {
  					changeAmount = paymentAmount - order.grand_total
  				}

  				$('#payment_change_amount').val(changeAmount);
  			}
  		})
  	})
});