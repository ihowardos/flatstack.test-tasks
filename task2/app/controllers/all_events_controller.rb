class AllEventsController < ApplicationController
  expose_decorated :event
  expose_decorated :events, -> { fetch_events }

  def index
    events = Event.all
  end

  private
    def fetch_events
      # Как работать с ActiveRecord с вложенными хэшами?
      # events = Event.where('CAST(date AS text) LIKE ?', "#{params[:date]}%").order(:date) if params[:date]
      events = []

      Event.all.each do |event|
        if event.recurring.nil?
          events << event if event.date.beginning_of_day == params[:date]
        else
          event.recurring[:time].each do |time|
            events << event if time.beginning_of_day == params[:date]
          end
        end
      end
      events
    end
end
