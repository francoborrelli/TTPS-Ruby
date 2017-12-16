// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//= require js/datepicker.min
//= require locales/datepicker.es.min

$(document).ready(function() {
  if (typeof lang === "undefined") {
    lang = "en"
    fSDate = Date.now()
    fEDate = Date.now()
  }

  $(function() {
    $("input.datepicker")
      .data({ behaviour: "datepicker" })
      .datepicker({
        format: "dd/mm/yyyy",
        language: lang || "es",
        autoclose: true,
        orientation: "auto right",
        startDate: fSDate,
        endDate: fEDate
      })
  })
})