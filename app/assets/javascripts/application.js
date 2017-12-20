//= require jquery3
//= require rails-ujs
//= require popper
//= require bootstrap-sprockets
//= require_tree .

$(document).ready(() => {

  //Initialize page tooltips

  $('[data-toggle="tooltip"]').tooltip()
  
  $(".btn-delete").click(function(e) {
    e.preventDefault()
    $btn = $("#delete-confirm").find(".btn-danger")
    $href = $btn.attr("href")
    $slice = $(this).data("slice")
    console.log($(this).data("id"))
    $new = $href.replace($href.slice($slice), $(this).data("id"))
    $btn.attr("href", $new)
    $("#delete-confirm").modal("show")
  })

  error = function(element) {
    div = $(element).closest(".field_with_errors")
    div.find("small").remove()
    div.removeClass("field_with_errors")
  }
  $("input").change(function(){
    error(this)
  })

  $("select").change(function(){
    error(this)
  })
})
