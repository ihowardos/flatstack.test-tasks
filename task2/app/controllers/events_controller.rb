class EventsController < ApplicationController
  before_action :authenticate_user!, only: [:edit, :new, :destroy]

  expose_decorated :event
  expose_decorated :events, -> { fetch_events }

  def index
    @date = params[:date] ? Date.parse(params[:date]) : Date.today
  end

  def create
    event.user_id = current_user.id
    if event.save
      redirect_to event, notice: 'Event was successfully created.'
    else
      render :new
    end
  end

  def update
    if event.update(event_params)
      redirect_to event, notice: 'Event was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    event.destroy
    redirect_to events_url, notice: 'Event was successfully destroyed.'
  end

  private
    def fetch_events
      events = Event.all
      events = Event.where(user_id: current_user.id) if !current_user.nil?
      events
    end

    def event_params
      params.require(:event).permit(:title, :description, :date)
    end
end
