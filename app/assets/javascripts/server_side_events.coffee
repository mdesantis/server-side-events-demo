on_page_load = ->
  if $('#current_time').length > 0

    url = "#{window.settings.paths.server_side_events_current_time}?_sse=true"
    url += "&#{location.search.slice(1)}" if location.search.length > 0
    eventSource = new EventSource url

    eventSource.onopen = (e) ->
      console.log e
      $('#status').text('Status: online')

    eventSource.onmessage = (e) ->
      console.log e
      $('#current_time').prepend $ '<pre/>', text: JSON.parse(e.data).time

    eventSource.onerror = (e) ->
      console.log e
      $('#status').text('Status: offline')

$(document).ready on_page_load
$(document).on 'page:load', on_page_load
