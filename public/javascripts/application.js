

$(function() {
	// ***delete better***
	$('a[data-method="delete"]').click (function(){
	            if(confirm("Are you sure?")){	               
	            	                return true;
	            	            } else {
	            	                //they clicked no.
	            	                return false;
	            	            }
	    });
	
	
	// ***Meal form***
	
	//Makes the calendar
 $("#meal_date_eaten").datepicker();

	//Makes the slider for the meal price
 $("#slider").slider({
			value: $( "#meal_price" ).val(),
			min: 0,
			max: 40,
			step: 1,
			slide: function( event, ui ) {
				$( "#meal_price" ).val(ui.value );
			}
		});
		$( "#meal_price" ).val( $( "#slider" ).slider( "value" ) );
});