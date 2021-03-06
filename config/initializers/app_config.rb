# frozen_string_literal: true

require 'csv'

Time::DATE_FORMATS[:on_at] = 'on %b %d, %Y at %I:%M %p'
Time::DATE_FORMATS[:on] = 'on %m.%d.%Y'
Time::DATE_FORMATS[:date] = '%m.%d.%Y'
Time::DATE_FORMATS[:long_date] = '%d %B %Y'
Time::DATE_FORMATS[:time] = '%l:%M %p'

class Integer
  def to_currency
    number = "%0.02f" % (self / 100.0)
    "$ " + number.reverse.gsub(/(\d{3})(?=\d)/, '\\1,').reverse
  end
end

class Float
  def to_currency
    self.round.to_currency
  end
end
