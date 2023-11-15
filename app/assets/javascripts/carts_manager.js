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

  
  function formatPrice(amount) {
    return amount.toLocaleString('vi-VN', { style: 'currency', currency: 'VND' });
  }


  $('.add-to-cart').on('click', function(e) {
    e.preventDefault();
    var productId = $(this).parent().find('.product-id').val();
    var stock = parseInt($(this).parent().find('.stock').val(), 10);
    var current_quantity = parseInt($(this).parent().find('.current-quantity').val(), 10);
    var quantity = parseInt($(this).parent().find('.quantity').val(), 10);
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
      if ((stock - quantity < 0) || (stock - (current_quantity + quantity) < 0)) {
        Swal.fire({
          icon: "error",
          title: "Oops...",
          text: "Cannot add to cart!",
          footer: "This product's stock is not enough."
        });
      } else if ((quantity == "") || (quantity == 0)) {
        Swal.fire({
          icon: "error",
          title: "Oops...",
          text: "Cannot add to cart!",
          footer: "The quantity field cannot be blank or equal to 0."
        });
      } else {
        Swal.fire({
          position: "center",
          icon: "success",
          title: "Add to cart success!",
          showConfirmButton: false,
          timer: 1000
        });
      }
      $('.current-quantity').attr('value', data.current_quantity);
    });
  });


  // $('.delete-button').on('click', function(e){
  //   e.preventDefault();
  //   Swal.fire({
  //     title: 'Are you sure?',
  //     text: 'This action cannot be undone!',
  //     icon: 'warning',
  //     showCancelButton: true,
  //     confirmButtonText: 'Yes, do it!',
  //     cancelButtonText: 'No, cancel!',
  //     reverseButtons: true 
  //   }).then((result) => {
  //     if (result.isConfirmed) {
  //       Swal.fire('Action performed!', 'You clicked Yes!', 'success');
  //     } else if (result.dismiss === Swal.DismissReason.cancel) {
  //       Swal.fire('Action cancelled', 'You clicked No!', 'error');
  //     }
  //   });
  // });

});
