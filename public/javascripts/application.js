$(function() {
  $("#foods th a, #foods .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#foods_search input").keyup(function() {
    $.get($("#foods_search").attr("action"), $("#foods_search").serialize(), null, "script");
    return false;
  });
});
$(function() {
  $("#add th a, #add .pagination a").live("click", function() {
    $.getScript(this.href);
    return false;
  });
  $("#add_search input").keyup(function() {
    $.get($("#add_search").attr("action"), $("#add_search").serialize(), null, "script");
    return false;
  });
});
