module ApplicationHelper
  def cancel
    link_to image_tag('icons/cross.png', :alt => '') + 'Cancel', URI.parse(request.referer.to_s).path.blank? ? root_path : (URI.parse(request.referer.to_s).path), :class => 'button negative'
  end

  def validation_errors(obj)
    if obj and obj.errors.count > 0
      update_page_tag do |page|
        obj.errors.each do |attr,msg|
          page.replace_html "#{attr}_status", msg
        end
      end
    end
  end
  
  def draw_chart(chart_api, chart_type, values, chart_element_id, chart_params, categories)
    if chart_api == 'google'
      google_chart(chart_type, values, chart_element_id, chart_params)
    elsif chart_api == 'highcharts'
      highcharts_chart(chart_type, values, chart_element_id, chart_params, categories)
    end
  end
  
  def google_chart(chart_type, values, chart_element_id, chart_params)
    @values = values
    @chart_element_id = chart_element_id
    @chart_type = chart_type
    @chart_params = chart_params
    render :partial => 'google/google_chart'
  end
  
  def highcharts_chart(chart_type, values, chart_element_id, chart_params, categories)
    @values = values
    @chart_element_id = chart_element_id
    @chart_type = chart_type
    @chart_params = chart_params
    @categories = categories
    render :partial => 'charts/highcharts_chart'
  end

  def simple_date(past_date)
    return '' if past_date.blank?
    if past_date.year == Date.today.year
      past_date.strftime("%b %d")
    else
      past_date.strftime("%b %d, %Y")
    end
  end

end
