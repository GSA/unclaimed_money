# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $("#last_name").on 'keypress', (e) ->
    if e.keyCode == 13
      $('#searchModal').foundation('reveal', 'open');
  $(".search.button").click ->
    $('#searchModal').foundation('reveal', 'open');
  $('.close').click ->
    $('.alert-box').remove();
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
  $("input.tm-input").tagsManager({
    hiddenTagListName: 'states',
    typeahead: true,
    typeaheadSource: getStates(),
    blinkBGColor_1: '#FFFF9C',
    blinkBGColor_2: '#CDE69C',
    onlyTagList: true
  });

  $('#skip-link').click (e) ->
    e.preventDefault()
    $('#skip-target').focus()
    return
  $('#skip-link').focus ->
    $('#header').addClass('move-header')
  $('#skip-link').on 'blur', ->
    $('#header').removeClass('move-header')

  $ ->
    $("#sidebar-accordion").accordion()
    return

  $ ->
    $("#tabs").tabs()
    return


jQuery ->
  hash = window.location.hash
  if hash != ''
    section = hash.match(/#(\w{2,4})-modal.*/)[1]
    $('section#'+section).addClass('active')
    $(hash).foundation('reveal', 'open')