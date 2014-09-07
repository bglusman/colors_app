$(document).ready ->
  clicked = false
  $('#colors').click (event)->
    unless clicked
      $('body').append('<p>clicked!</p>')
      clicked = true
      setInterval ->
        $.post '/', (data)->
          $('html').css( "background-color", "rgb(#{data.red}, #{data.blue}, #{data.green}" )
      , 3000