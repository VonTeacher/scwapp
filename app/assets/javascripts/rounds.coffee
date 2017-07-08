# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ->
  $('#round_tee_id').parent().hide()
  $('#round_date_played').parent().hide()
  $('#round_adjusted_score').parent().hide()
  $('#score_reminder').hide()
  tees = $('#round_tee_id').html()
  $('#round_club_id').change ->
    club = $('#round_club_id :selected').text()
    escaped_club = club.replace(/([ #;&,.+*~\':"!^$[\]()=>|\/@])/g, '\\$1')
    options = $(tees).filter("optgroup[label='#{escaped_club}']").html()
    if options
      $('#round_tee_id').html(options)
      $('#round_tee_id').parent().show(400)
      $('#round_date_played').parent().show(400)
      $('#round_adjusted_score').parent().show(400)
      $('#score_reminder').show(400)
    else
      $('#round_tee_id').empty()
      $('#round_tee_id').parent().hide()
      $('#round_date_played').parent().hide()
      $('#round_adjusted_score').parent().hide()
      $('#score_reminder').hide()
