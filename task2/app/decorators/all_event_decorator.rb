class AllEventDecorator < Draper::Decorator
  delegate_all

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

  def all_events_count(date)
    events = Event..where('CAST(date AS text) LIKE ?', "#{date}%")
      .order(:date) if date
    events.count
  end

  def event_today?(date)
    date.to_date.today?
  end
end
