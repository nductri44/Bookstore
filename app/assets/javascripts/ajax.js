$(document).ready(function() {

  $('.button-add').on('click', function(e) {
    e.preventDefault();
    var $input = $(this).prev();
    var currentValue = parseInt($input.val());
    $(this).parent().find('.button-subtract').prop('disabled', false);
    $input.val(currentValue + 1);
  });


  $('.button-subtract').on('click', function(e) {
    e.preventDefault(); 
    var $input = $(this).next();
    var currentValue = parseInt($input.val());
    if (currentValue <= 1) {
      $(this).prop('disabled', true);
    } else {
      $input.val(currentValue - 1);
    }
  });



  $('.button-add').on('click', function(e) {
    e.preventDefault();
    var updates = [];

    var cart = {
      updates: updates
    };

    $('.quantity-input').each(function() {
      var productId = $(this).data('product-id');
      var newQuantity = parseInt($(this).val(), 10);
      
      var update = {
        product_id: productId,
        quantity: newQuantity
      };
      
      updates.push(update); 
    });

    $.ajax({
      url: '/user/carts/update_cart',
      method: 'PATCH',
      data: JSON.stringify(cart),
      contentType: 'application/json',
    }).done(function(data) {
      $('#total-price').text('' + formatPrice(data.total));
    });
  });


  $('.button-subtract').on('click', function(e) {
    e.preventDefault();
    var updates = [];

    var cart = {
      updates: updates
    };

    $('.quantity-input').each(function() {
      var productId = $(this).data('product-id');
      var newQuantity = parseInt($(this).val(), 10);
      
      var update = {
        product_id: productId,
        quantity: newQuantity
      };
      
      updates.push(update);
    });

    $.ajax({
      url: '/user/carts/update_cart',
      method: 'PATCH',
      data: JSON.stringify(cart),
      contentType: 'application/json',
    }).done(function(data) {
      $('#total-price').text('' + formatPrice(data.total));
    });
  });


  $('.quantity-input').on('input', function(e) {
    e.preventDefault();
    var updates = [];

    var cart = {
      updates: updates
    };

    $('.quantity-input').each(function() {
      var productId = $(this).data('product-id');
      var newQuantity = parseInt($(this).val(), 10);
      
      var update = {
        product_id: productId,
        quantity: newQuantity
      };
      
      updates.push(update);
    });

    $.ajax({
      url: '/user/carts/update_cart',
      method: 'PATCH',
      data: JSON.stringify(cart),
      contentType: 'application/json',
    }).done(function(data) {
      $('#total-price').text('' + formatPrice(data.total));
    });
  });


  
  // function updateTotalPrice(price) {
  //   var totalPrice = $('#total-price').data("price") + price;

  //   $('#total-price').text('' + formatPrice(price));
  // }

  function formatPrice(amount) {
    return amount.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
  }



  $('.add-to-cart').on('click', function(e) {
    e.preventDefault();
    var productId = $(this).parent().find('.product-id').val();
    var stock = $(this).parent().find('.stock').val();
    var quantity = $(this).parent().find('.quantity').val();
    var adds = [];

    var cart = {
      adds: adds
    };

    var add = {
      product_id: productId,
      stock: stock,
      quantity: quantity,
    }

    adds.push(add);

    $.ajax({
      url: '/user/carts/add_to_cart',
      method: 'POST',
      data: JSON.stringify(cart),
      contentType: 'application/json',
    }).done(function(data) {
      $('.cart-count').attr('value', data.cart_count);
      if (stock == 0 ) {
        Swal.fire({
          icon: "error",
          title: "Oops...",
          text: "Cannot add to cart!",
          footer: "This product is out of stock."
        });
      } else {
        Swal.fire({
          position: "top-start",
          icon: "success",
          title: "Add to cart success!",
          showConfirmButton: false,
          timer: 1000
        });
      }
    });
  });



});
