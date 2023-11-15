$(document).ready(function() {
  $("#orderForm").validate({
		onfocusout: false,
		onkeyup: false,
		onclick: false,
		rules: {
			"name": {
				required: true,
				maxlength: 50
			},
			"email": {
				required: true,
        maxlength: 100,
				email: true
			},
			"phone": {
				required: true,
				maxlength: 15,
				digits: true 
			},
			"address": {
				required: true
		  }
	  }
  });
});