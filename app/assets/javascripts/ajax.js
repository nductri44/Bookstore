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




  // $('.order-confirm').on('click', function(e) {
  //   e.preventDefault();
  //   $.post("/user/orders",
  //     {},
  //     function(data) {
  //       if (data.errors.length > 0) {
  //           Swal.fire({
  //           icon: "error",
  //           title: "Oops...",
  //           text: data.errors,
  //           footer: '<a href="#">Why do I have this issue?</a>'
  //         });
  //       } else {
  //           alert(data.success);
  //           window.location.href = "/home";
  //       }
  //     }
  //   );
  // });


  
  // function updateTotalPrice(price) {
  //   var totalPrice = $('#total-price').data("price") + price;

  //   $('#total-price').text('' + formatPrice(price));
  // }

  function formatPrice(amount) {
    return amount.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
  }


});
