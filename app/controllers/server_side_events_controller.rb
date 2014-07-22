class ServerSideEventsController < ApplicationController
  include ActionController::Live
  include ServerSideEvent::Helper

  def index
  end

  def current_time
    respond_to do |format|
      format.html do
        sse_current_time if sse?
      end
      format.sse do
        sse_current_time
      end
    end
  end

  private

  def sse_current_time
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream)

    loop do
      sse.write(time: Time.now)
      sleep 1
    end

  rescue IOError => e
    raise e unless e.message == 'closed stream'

    logger.info sse_closed_stream_message(request)
  ensure
    sse.close
  end

  # Closed SSE stream GET "/session/new" for 127.0.0.1 at 2012-09-26 14:51:42 -0700
  def sse_closed_stream_message(request)
    '  Closed SSE stream %s "%s" for %s at %s' % [
      request.request_method,
      request.filtered_path,
      request.ip,
      Time.now.to_default_s ]
  end
end
