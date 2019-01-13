$(document).ready(function () {
  'use strict'

  if ($('#new_subdistrict_link').length) {
    $('#district').on('change', function () {
      var newStateLinkHref = $('#new_subdistrict_link').prop('href')
      var selectedCountryId = $('#district option:selected').prop('value')
      var newLink = newStateLinkHref.replace(/districts\/(\d+)/,
        'districts/' + selectedCountryId)
      $('#new_subdistrict_link').attr('href', newLink)
    })
  };
  //console.log("OK");
})