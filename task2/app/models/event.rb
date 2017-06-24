class Event < ApplicationRecord
  belongs_to :user

  validates :title, :description, :date, presence: true
  validates :title, length: { in: 4..32 }
  validates :description, length: { in: 16..256 }

  serialize :recurring, Hash

  def recurring=(value)
    if RecurringSelect.is_valid_rule?(value)
      super(RecurringSelect.dirty_hash_to_rule(value).to_hash)
    else
      super(nil)
    end
  end

  def rule
    IceCube::Rule.from_hash recurring
  end

  {:validations=>{}, :rule_type=>"IceCube::DailyRule", :interval=>3}
  {:validations=>{:day=>[0, 1, 4, 5]}, :rule_type=>"IceCube::WeeklyRule", :interval=>3, :week_start=>0}
  {:validations=>{:day_of_week=>{1=>[2, 3], 2=>[1], 3=>[3], 4=>[2]}}, :rule_type=>"IceCube::MonthlyRule", :interval=>3}
  {:validations=>{:day_of_month=>[10, 19, 20, 23, 25, -1]}, :rule_type=>"IceCube::MonthlyRule", :interval=>3}
  {:validations=>{}, :rule_type=>"IceCube::YearlyRule", :interval=>3}


  def rule_monthly
    start_time = date
    end_time = end_date

    recurring[:time] = []

    if !recurring[:validations][:day_of_month].nil?
      while start_time <= end_time
        mday = start_time.beginning_of_month
        stop_of_month = start_time.end_of_month

        while mday <= stop_of_month
          recurring[:validates][:day_of_month].each do |day|
            if day == mday.day && mday >= date
              recurring[:time] << mday
            end
          end
          mday += 1.day
        end
        start_time += recurring[:interval].month
      end
    end
  end

  def rule_daily
    start_time = date
    end_time = end_date

    recurring[:time] = []

    while start_time <= end_time do
      recurring[:time] << start_time
      start_time += recurring[:interval].day
    end
  end

  def rule_weekly
    start_time = date
    end_time = end_date

    recurring[:time] = []

    if recurring[:validation].nil?
      while start_time <= end_time
        recurring[:time] << start_time
        start_time += recurring[:interval].week
      end
    else
      days = recurring[:validations][:day]
      wdays_hash = { 0 => "Sunday", 1 => "Monday", 2 => "Tuesdays", 3 => "Wednesdays",
        4 => "Thursdays", 5=> "Fridays", 6 => "Saturdays" }

      while start_time <= end_time do
        wday = start_time.beginning_of_week
        stop_of_week = start_time.end_of_week

        while wday <= stop_of_week do
          days.each do |x|
            if x == wday.wday && wday >= date
              recurring[:time] << wday
            end
          end
          wday += 1.day
        end
        start_time += recurring[:interval].week
      end
    end
  end

  def rule_yearly
    start_time = date
    end_time = end_date

    recurring[:time] = []

    while start_time <= end_time
      recurring[:time] << start_time
      start_time += recurring[:interval].year
    end
  end

end
