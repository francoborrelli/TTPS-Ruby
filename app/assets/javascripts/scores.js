// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $("#score_examination_id").change(function() {
    test = $("#score_examination_id :selected").val()
    course = $(this)
      .closest("form")
      .data("course")
    $.ajax({
      type: "POST",
      url: "/courses/" + course + "/get_students",
      data: {
        id: test
      },
      success: function(response) {
        select = $("#score_student_id")
        select
          .children()
          .not(":first")
          .remove()
        var listitems = ""
        $.each(response, function(key, value) {
          listitems +=
            "<option value=" +
            value.id +
            ">" +
            value.s_number +
            " - " +
            value.name +
            " " +
            value.surname +
            "</option>"
        })
        select.append(listitems)
        if ($value != null) {
          $("#score_student_id option[value=" + $value + "]").attr(
            "selected",
            "selected"
          )
          $value = null
        }
      }
    })
  })

  if ($("#score_examination_id").val() != 0) {
    $value = $("#score_student_id").val()
    $("#score_examination_id").trigger("change")
  }
})
