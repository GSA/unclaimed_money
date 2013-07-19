# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

# jQuery ->
#   $("#last_name").focus ->   
#    $('#searchModal').foundation('reveal', 'open');

jQuery ->
  $("#last_name").live 'keypress', (e) ->
    if e.keyCode == 13
      $('#searchModal').foundation('reveal', 'open');