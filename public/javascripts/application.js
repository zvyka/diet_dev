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
  $("#meal_food_tokens").tokenInput("/foods.json", {
    crossDomain: false,
    prePopulate: $("#meal_food_tokens").data("pre"),
		theme: ""
  });
 $("#meal_date_eaten").datepicker();
$( "#slider" ).slider({
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