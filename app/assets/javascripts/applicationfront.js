

$(document).ready(function () {
  'use strict'
    $('[id$="address_attributes_zipcode"]').on('change', function () {
      $.ajax({
            url:  "/filter_units_by_postcode",
            type: "GET",
            data: { selected_postcode: $(this).val(),address_type:  $(this).data("addressid")},
            success: function(data){
               //console.log(data)
             }
        });
    })
  //console.log("OK");
})
