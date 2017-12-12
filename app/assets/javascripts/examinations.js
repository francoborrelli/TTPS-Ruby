// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
    console.log(fSDate);
$(function() {
    $('input.datepicker').data({behaviour: "datepicker"}).datepicker({
        format: "dd/mm/yyyy",
        language: "es",
        autoclose: true,
        orientation: "auto right",
        startDate: fSDate, 
        endDate: fEDate
    });
});
});

