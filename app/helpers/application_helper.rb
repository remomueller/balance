module ApplicationHelper

  def simple_date(past_date)
    return '' if past_date.blank?
    if past_date.year == Date.today.year
      past_date.strftime("%b %d")
    else
      past_date.strftime("%b %d, %Y")
    end
  end

end
