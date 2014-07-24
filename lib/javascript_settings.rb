class JavascriptSettings < DelegateClass(Hash)
  include Rails.application.routes.url_helpers

  def initialize
    super(
      paths: {
        server_side_events_current_time: server_side_events_current_time_path,
        server_side_events_events: server_side_events_events_path
      }
    )
  end
end