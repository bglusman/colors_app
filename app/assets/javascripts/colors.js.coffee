
setUpListenerForBgColorChanges = ->
  $(document).on 'changeBgColor', (event, data)->
    $('html').css( "background-color", "rgb(#{data.red}, #{data.blue}, #{data.green}" )

pollIntervalInMilliseconds = 3000

pollBgForColors = ->
  setInterval ->
    $.post '/', (data)->
      $(document).trigger('changeBgColor', [data])
  , pollIntervalInMilliseconds

alertUserOnClick = ->
  $('#colors').html('<span>Coming right up!</span>')

setUpListenerForBgColorChanges()
clicked = null
$(document).on 'click', '#colors', (event)->
  unless clicked
    clicked = true
    pollBgForColors()
    alertUserOnClick()