class UsersController < ApplicationController
  before_filter :authenticate_user!

  def dashboard
    if params[:month] and params[:year]
      @start_date = Date.parse("#{params[:year]}-#{params[:month]}-01")
      @end_date = Date.parse("#{params[:year].to_i+params[:month].to_i/12}-#{(params[:month].to_i)%12+1}-01")-1.day
      render :update do |page|
        page.replace_html 'spending', :partial => 'accounts/month_spending'
        page.replace_html 'month-breakdown', :partial => 'users/month_breakdown'
      end
    end
  end
end
