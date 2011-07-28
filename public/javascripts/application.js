// $(function() {
//   $("#foods th a, #foods .pagination a").live("click", function() {
//     $.getScript(this.href);
//     return false;
//   });
//   $("#foods_search input").keyup(function() {
//     $.get($("#foods_search").attr("action"), $("#foods_search").serialize(), null, "script");
//     return false;
//   });
// });
// $(function() {
//   $("#add th a, #add .pagination a").live("click", function() {
//     $.getScript(this.href);
//     return false;
//   });
//   $("#add_search input").keyup(function() {
//     $.get($("#add_search").attr("action"), $("#add_search").serialize(), null, "script");
//     return false;
//   });
// });

$(function() {
	// ***Meal form***
	
	// 			Grabs meal input
  // $('*[id*=what_food]').tokenInput("/foods.json", {
  // 	  crossDomain: false,
  // 	  prePopulate: $('*[id*=what_food]').data("pre"),
  // 		theme: "",
  // 		tokenLimit: 1
  // 	});
	
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