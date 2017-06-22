class AllEventsController < ApplicationController
  expose_decorated :events, -> { fetch_events }

  private
    def fetch_events
      events = Event.all
      events = Event.where('CAST(date AS text) LIKE ?', "#{params[:date]}%")
      .order(:date) if  params[:date]
      events
    end

end
