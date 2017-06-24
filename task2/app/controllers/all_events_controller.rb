class AllEventsController < ApplicationController
  expose_decorated :event
  expose_decorated :events, -> { fetch_events }

  def index
    events = Event.all
    @calendar_events = events.flat_map{ |e| e.calendar_events(params.fetch(:start_time, Time.zone.now).to_date) }
  end

  private
    def fetch_events
      events = Event.where('CAST(date AS text) LIKE ?', "#{params[:date]}%")
      .order(:date) if params[:date]
    end

end
