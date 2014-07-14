on_page_load = ->
  if $('#current_time').length > 0
    eventSource = new EventSource "#{window.settings.paths.server_side_events_current_time}?_sse=true"

    eventSource.onopen = (e) ->
    $('#status').text('Status: online')

    eventSource.onmessage = (e) ->
      $('#current_time').append $ '<pre/>', text: JSON.parse(e.data).time
      $('html, body').scrollTop $(document).height() unless Modernizr.touch

    eventSource.onerror = (e) ->
      $('#status').text('Status: offline')

$(document).ready on_page_load
$(document).on 'page:load', on_page_load
