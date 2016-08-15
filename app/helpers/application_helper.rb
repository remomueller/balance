# frozen_string_literal: true

# Methods to help across all application views.
module ApplicationHelper
  def simple_date(past_date)
    return '' if past_date.blank?
    format = if past_date.year == Time.zone.today.year
               '%b %d'
             else
               '%b %d, %Y'
             end
    past_date.strftime(format)
  end
end
