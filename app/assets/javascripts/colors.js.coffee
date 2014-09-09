
setUpListenerForBgColorChanges = ->
  $(document).on 'changeBgColor', (event, data)->
    $('html').css( "background-color", "rgb(#{data.red}, #{data.blue}, #{data.green}" )

pollIntervalInMilliseconds = 3000

getNewColor = ->
  $.post '/', (data)->
    $(document).trigger('changeBgColor', [data])

pollBgForColors = ->
  getNewColor()
  setInterval getNewColor, pollIntervalInMilliseconds

alertUserOnClick = ->
  $('#colors').html('<span>Coming right up!</span>')

setUpListenerForBgColorChanges()
clicked = null
$(document).on 'click', '#colors', (event)->
  unless clicked
    clicked = true
    alertUserOnClick()
    pollBgForColors()