class ServerSideEventsController < ApplicationController
  include ActionController::Live
  include ServerSideEvent::Helper

  def index
  end

  def current_time
    respond_to do |format|
      format.html do
        current_time_sse if sse?
      end
      format.sse do
        current_time_sse
      end
    end
  end

  def current_time_sse
    respond_using_sse do |sse|
      loop do
        sse.write(Time.now, { option: 'option' })
        sleep 1
      end
    end
  end
end
