class EventDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def events_count(date, current_user_id)
    events = Event.where(user_id: current_user_id).where('CAST(date AS text) LIKE ?', "#{date}%")
      .order(:date) if date
    events.count
  end

   def all_events_count(date)
    events = Event.where('CAST(date AS text) LIKE ?', "#{date}%")
      .order(:date) if date
    events.count
  end

  def message(date)
    if event_today?(date)
      "Events for today"
    else
      "Events for #{date}"
    end
  end

  def get_username(id)
    user = User.find(id)
    "#{user.name} #{user.surname}"
  end

  private

  def event_today?(date)
    date.to_date.today?
  end
end
