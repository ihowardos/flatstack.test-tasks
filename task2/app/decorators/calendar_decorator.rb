class CalendarDecorator < Draper::Decorator
  delegate_all

  def calendar(date = Date.today, &block)
    Calendar.new(self, date, block).table
  end
  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
