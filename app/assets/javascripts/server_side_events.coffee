on_page_load = ->
  if $('#current_time').length > 0
    eventSource = new EventSource "#{window.settings.paths.server_side_events_current_time}?_sse=true"

    eventSource.onmessage = (e) ->
      $('#current_time').append $ '<pre/>', text: JSON.stringify(e.data)
      $('html, body').scrollTop $(document).height()

$(document).ready on_page_load
$(document).on 'page:load', on_page_load
