$(document).ready(function () {
  'use strict'

  if ($('#new_district_link').length) {
    $('#state').on('change', function () {
      var newStateLinkHref = $('#new_district_link').prop('href')
      var selectedCountryId = $('#state option:selected').prop('value')
      var newLink = newStateLinkHref.replace(/states\/(\d+)/,
        'states/' + selectedCountryId)
      $('#new_district_link').attr('href', newLink)
    })
  };
  //console.log("OK");
})