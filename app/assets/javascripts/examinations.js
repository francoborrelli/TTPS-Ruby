// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

//= require js/datepicker.min
//= require locales/datepicker.es.min

$(document).ready(function(){
    $(function() {
        $('input.datepicker').data({behaviour: "datepicker"}).datepicker({
            format: "dd/mm/yyyy",
            language: lang,
            autoclose: true,
            orientation: "auto right",
            startDate: fSDate, 
            endDate: fEDate
        });
    });
});

