class AllEventsController < ApplicationController
  expose_decorated :event
  expose_decorated :events, -> { fetch_events }

  private
    def fetch_events
      events = Event.where('CAST(date AS text) LIKE ?', "#{params[:date]}%")
      .order(:date) if  params[:date]
    end

end
