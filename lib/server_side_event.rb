class ServerSideEvent
  def self.respond(response, &block)
    new(response.stream, &block)
  end

  def initialize(io, &block)
    @io = io

    if block_given?
      open &block
    end
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