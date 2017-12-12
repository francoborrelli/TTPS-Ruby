// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
    
        //Changes delete modal element
        $('.btn-delete-s').click(function(e) {
            e.preventDefault();
            $btn = $('#delete-confirm').find('.btn-danger')
            $href = $btn.attr('href');
            $new = $href.replace($href.slice(20), $(this).data('id'));
            $btn.attr('href', $new);
            $('#delete-confirm').modal('show');
        });

      });
    
    