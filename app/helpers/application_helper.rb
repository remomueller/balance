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

  def th_sort_field(order, sort_field, display_name, extra_class: '')
    sort_params = params.permit(:search)
    sort_field_order = (order == sort_field) ? "#{sort_field} desc" : sort_field
    if order == sort_field
      selected_class = 'sort-selected'
    elsif order == "#{sort_field} desc nulls last" || order == "#{sort_field} desc"
      selected_class = 'sort-selected'
    end
    content_tag(:th, class: [selected_class, extra_class]) do
      link_to url_for(sort_params.merge(order: sort_field_order)), style: 'text-decoration:none' do
        display_name.to_s.html_safe
      end
    end.html_safe
  end

  def simple_check(checked)
    content_tag(:i, "", class: "fa #{checked ? "fa-check-square-o" : "fa-square-o"}")
  end
end
