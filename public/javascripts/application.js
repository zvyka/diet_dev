

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
		
		//  ***User form***
		
		//Makes the slider for the user's height.
		$(function() { 
		    $( "#slider-range" ).slider({ 
		        min: 0,
						max: 96, 
		        slide: function( event, ui ) { 
		            $("#size-range").html(Math.floor(ui.value / 12) + "'" + (ui.value % 12) + '"'); 
		            $("#user_height").val(ui.value); 
		        } 
		    }); 
		    $("#size-range").html(Math.floor($("#slider-range").slider("value") / 12) + "'" + ($("#slider-range").slider("value") % 12) + '"');
				$("#user_height").val($("#slider-range").slider("value")); 
		});
});