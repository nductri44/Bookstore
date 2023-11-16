$(document).ready(function() {
  $("#priceForm").validate({
		onfocusout: false,
		onkeyup: false,
		onclick: false,
		rules: {
			"min_price": {
				required: true, 
				digits: true 
			},
      "max_price": {
				required: true,
				digits: true 
			}
	  }
  });
});