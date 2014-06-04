$(document).ready ->
  eventSource = new EventSource "/server_side_events/stream"
  eventSource.onmessage = (e) ->
    console.log e
    $('#stream_log').append $('<pre/>', text: JSON.stringify(e.data))
