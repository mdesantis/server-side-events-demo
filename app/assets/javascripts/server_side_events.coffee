on_page_load = ->
  windowSettings()

  # FIXME `url` should be the same (one stream per client)
  if $('body').hasClass('server-side-events-controller') and (
       $('body').hasClass('current-time-action') or
       $('body').hasClass('events-action')
     )
    if $('body').hasClass('current-time-action')
      url = "#{window.settings.paths.server_side_events_current_time}?_sse=true"
    if $('body').hasClass('events-action')
      url = "#{window.settings.paths.server_side_events_events}?_sse=true"

    url += "&#{location.search.slice(1)}" if location.search.length > 0

    eventSource = new EventSource url

    eventSource.onopen = (e) ->
      console.log e
      $('#status').text('Status: online')

    eventSource.onmessage = (e) ->
      console.log e
      $('#stream').prepend $ '<pre/>', text: JSON.stringify(e.data)

    eventSource.onerror = (e) ->
      console.log e
      $('#status').text('Status: offline')

$(document).ready on_page_load
$(document).on 'page:load', on_page_load
