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

  def simple_check(checked)
    if checked
      '<span class="glyphicon glyphicon-ok"></span>'.html_safe
    else
      '<span class="glyphicon glyphicon-unchecked text-muted"></span>'.html_safe
    end
  end
end
