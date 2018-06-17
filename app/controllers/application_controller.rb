# frozen_string_literal: true

# Main application controller for Balance.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :devise_login?
  before_action :configure_permitted_parameters, if: :devise_controller?

  def version
    render layout: "layouts/full_page"
  end

  protected

  def devise_login?
    params[:controller] == 'devise/sessions' && params[:action] == 'create'
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(
      :sign_up,
      keys: [:first_name, :last_name, :email, :password, :password_confirmation]
    )
  end

  def parse_date(date_string, default_date = '')
    format = if date_string.to_s.split('/').last.size == 2
               '%m/%d/%y'
             else
               '%m/%d/%Y'
             end
    Date.strptime(date_string, format)
  rescue
    default_date
  end

  def scrub_order(model, params_order, default_order)
    (params_column, params_direction) = params_order.to_s.strip.downcase.split(' ')
    direction = (params_direction == 'desc' ? 'DESC' : nil)
    column_name = model.column_names
                       .collect { |c| "#{model.table_name}.#{c}" }
                       .find { |c| c == params_column }
    order = column_name.blank? ? default_order : [column_name, direction].compact.join(' ')
    order
  end

  def month_start_date(year, month)
    Date.parse("#{year}-#{month}-01")
  end

  def month_end_date(year, month)
    month_start_date(year, month).end_of_month
  end

  def year_start_date(year)
    Date.parse("#{year}-01-01")
  end

  def year_end_date(year)
    year_start_date(year).end_of_year
  end

  private

  def empty_response_or_root_path(path = root_path)
    respond_to do |format|
      format.html { redirect_to path }
      format.js { head :ok }
      format.json { head :no_content }
    end
  end
end
