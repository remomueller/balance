module ApplicationHelper

  def include_css(css)
    content_for :css_includes do
      stylesheet_link_tag css
    end
  end
  
  def include_js(js)
    content_for :js_includes do
      javascript_include_tag js
    end
  end

  def cancel
    link_to 'cancel', (request.referer || dashboard_path)
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
  
  def announcements?
    not announcements.empty?
  end
  
  def announcements
    @announcements ||= begin
      if current_user.announcement_hide_time
        Announcement.where(['updated_at > ?', current_user.announcement_hide_time]).order('updated_at desc')
      else
        Announcement.order('updated_at desc')
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

end
