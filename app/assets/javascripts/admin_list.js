$(document).ready(function() {
  $('.delete-product-btn').on('click', function (e) {
    e.preventDefault();
    var form = $(this).parents('form');
    
    Swal.fire({
      title: 'Are you sure?',
      text: 'You will not be able to recover it!',
      icon: 'warning',
      showCancelButton: true,
      confirmButtonColor: '#d33',
      cancelButtonColor: '#3085d6',
      confirmButtonText: 'Yes, delete it!',
      cancelButtonText: 'No'
    }).then((result) => {
      if (result.isConfirmed) {
        Swal.fire(
          'Deleted!',
          'Delete success!',
          'success'
        ).then(() => {
          form.submit();
        });
      }
    });
  });

});