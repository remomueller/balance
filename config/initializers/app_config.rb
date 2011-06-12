Time::DATE_FORMATS[:on_at] = "on %b %d, %Y at %I:%M %p"
Time::DATE_FORMATS[:on] = "on %m.%d.%Y"
Time::DATE_FORMATS[:date] = "%m.%d.%Y"
Time::DATE_FORMATS[:long_date] = "%d %B %Y"
Time::DATE_FORMATS[:time] = "%l:%M %p"

Date::DATE_FORMATS[:long_date] = "%d %B %Y"

class Integer
  def to_currency
    "$ %0.02f" % (self / 100.0)
  end
end

class Float
  def to_currency
    self.round.to_currency
  end
end