class ServerSideEvent
  module Helper
    def sse?
      params[:_sse] == 'true'
    end

    def respond_using_sse(&block)
      response.headers['Content-Type']  = 'text/event-stream'
      response.headers['Cache-Control'] = 'no-cache'

      ServerSideEvent.respond response, &block
    end
  end

  def self.respond(response, &block)
    new(response.stream, &block)
  end

  def initialize(io, &block)
    @io = io

    open &block if block_given?
  end

  def open
    begin
      yield self
    rescue IOError => e
      raise e unless e.message == 'closed stream'
    ensure
      close
    end
  end

  def write(object, **options)
    options.each do |k, v|
      @io.write "#{k}: #{v}\n"
    end
    @io.write "data: #{object}\n\n"
  end

  def close
    @io.close
  end
end