$(document).ready(function() {
  $("#edit-btn").click(function() {
    $("input[type=number]").each(function() {
      $(this).prop("disabled", false)
    })
    $(this).addClass("hide")
    $("#submit-btn").removeClass("hide")
    $("#cancel-btn").removeClass("hide")
  })

  errors = $(".field_with_errors").length
  if (errors) {
    $("#edit-btn").trigger("click")
  }
})
