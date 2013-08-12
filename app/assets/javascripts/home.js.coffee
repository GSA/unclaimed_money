# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#last_name").on 'keypress', (e) ->
    if e.keyCode == 13
      $('#searchModal').foundation('reveal', 'open');
  $(".search.button").click ->
    $('#searchModal').foundation('reveal', 'open');
  $('body').on 'keypress', (e) ->
    sections = $('section');
    count = sections.size() - 1
    section = $('section.active');
    index = sections.index(section);
    if e.keyCode == 93
      if index == count
        $('#'+sections[0].id + ' p a').click();
      else
        $('#'+sections[index+1].id + ' p a').click();
    if e.keyCode == 91
      if index == 0
        $('#'+sections[count].id + ' p a').click();
      else
        $('#'+sections[index-1].id + ' p a').click();

jQuery ->
  hash = window.location.hash
  if hash != ''
    section = hash.match(/#(\w{2,4})-modal.*/)[1]
    $('section#'+section).addClass('active')
    $(hash).foundation('reveal', 'open')