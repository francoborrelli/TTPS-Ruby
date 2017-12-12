// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function(){

    //Initialize page tooltips
    $('[data-toggle="tooltip"]').tooltip({
        placement: "right"
    }); 
        
    $error = function($element){
        $div = $($element).closest(".field_with_errors")
        $div.find("small").remove();
        $div.removeClass("field_with_errors");
    };
    $("input").change(function(){
        $error(this);
    })

    $("select").change(function(){
        $error(this);
    })
  });

