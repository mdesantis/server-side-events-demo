class ServerSideEventsController < ApplicationController
  include ActionController::Live

  def test
  end

  def stream
    sse_response do |sse|
      loop do
        sse.write(Time.now, { option: 'option' })
        sleep 1
      end
    end
  end

  private

  def sse_response(&block)
    response.headers['Content-Type']  = 'text/event-stream'
    response.headers['Cache-Control'] = 'no-cache'

    ServerSideEvent.respond response, &block
  end
end
