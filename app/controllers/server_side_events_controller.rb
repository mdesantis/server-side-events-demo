class ServerSideEventsController < ApplicationController
  include ActionController::Live

  def index
  end

  def current_time
    respond_to do |format|
      format.html { sse_current_time if sse? }
      format.sse  { sse_current_time }
    end
  end

  def events
    respond_to do |format|
      format.html { sse_events if sse? }
      format.sse  { sse_events }
    end
  end

  def fire_event
    ActiveSupport::Notifications.instrument('sse_event')

    render nothing: true
  end

  private

  def sse_events
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream)

    ActiveSupport::Notifications.subscribe('sse_event') do |*args|
      sse.write message: 'event received'
    end

    loop { }
  rescue IOError => e
    raise e unless e.message == 'closed stream'

    logger.info sse_closed_stream_message(request)
  ensure
    sse.close
  end

  def sse_current_time
    response.headers['Content-Type'] = 'text/event-stream'
    sse = SSE.new(response.stream)

    timeout = params[:timeout].try(:to_i)
    elapsed = 0

    loop do
      sse.write time: Time.now
      elapsed += (sleep 1)

      break if timeout && elapsed >= timeout
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

  def sse?
    params[:_sse] == 'true'
  end
end
