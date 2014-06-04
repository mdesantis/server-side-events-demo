$(document).ready ->
  eventSource = new EventSource window.settings.paths.server_side_events_current_time

  eventSource.onmessage = (e) ->
    $('#current_time').append $ '<pre/>', text: JSON.stringify(e.data)
    $('html, body').scrollTop $(document).height()
