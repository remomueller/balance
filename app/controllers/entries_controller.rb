class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_graph, only: [:overview, :earning_spending_graph]
  before_action :set_entry, only: [:show, :edit, :update, :move, :mark_charged, :destroy]

  def calendar
    @selected_date = parse_date(params[:selected_date], Date.today)
    @start_date = @selected_date.beginning_of_month
    @end_date = @selected_date.end_of_month
  end

  def averages

  end

  def current_balance

  end

  def overview
    (current_user.first_billing_date.year..Date.today.year).each do |year|
      add_to_graph(year_start_date(year), year_end_date(year))
    end
  end

  def earning_spending_graph
    params[:year] = Date.today.year if params[:year].blank?
    (1..12).each do |month|
      add_to_graph(month_start_date(params[:year], month), month_end_date(params[:year], month))
    end
  end

  def index
    @order = scrub_order(Entry, params[:order], 'billing_date desc, id desc')
    @entries = current_user.entries.where(charged: (params[:charged] == 'uncharged' ? false : [true, false])).search(params[:search]).order(@order).page(params[:page]).per(20)
  end

  def show

  end

  def new
    @entry = current_user.entries.new(post_params)
    @entry.billing_date = Date.today if @entry.billing_date.blank?
  end

  def copy
    entry = current_user.entries.find_by_id(params[:id])
    if entry
      @entry = current_user.entries.new(entry.copyable_attributes)
      render 'new'
    else
      redirect_to new_entry_path
    end
  end

  def edit

  end

  def create
    @entry = current_user.entries.new(post_params)

    respond_to do |format|
      if @entry.save
        flash[:notice] = 'Entry was successfully created.'
        if params[:from_calendar] == '1'
          format.js { render 'create' }
          format.html { redirect_to calendar_entries_path(month: @entry.billing_date.month, year: @entry.billing_date.year) }
        else
          format.html { redirect_to @entry }
        end
      else
        format.html { render 'new' }
        format.js { render 'new' }
      end
    end
  end

  def update
    if @entry.update_attributes(post_params)
      redirect_to @entry, notice: 'Entry was successfully updated.'
    else
      render action: :edit
    end
  end

  def move
    params[:entry][:billing_date] = parse_date(params[:entry][:billing_date])

    if @entry and not params[:entry][:billing_date].blank?
      @entry.update_attributes billing_date: params[:entry][:billing_date]
      render 'update'
    else
      render nothing: true
    end
  end

  def mark_charged
    @entry.update_attribute :charged, true if @entry
  end

  def destroy
    @entry.destroy if @entry
    redirect_to entries_path
  end

  def autocomplete
    @entries = current_user.entries.search(params[:search]).group('name').order('COUNT(id) DESC, name ASC').limit(8)
    render json: @entries.collect(&:name)
  end

  private

  def post_params
    params[:entry] ||= {}

    params[:entry][:billing_date] = parse_date(params[:entry][:billing_date])

    unless params[:entry][:charge_type_id].blank?
      charge_type = current_user.charge_types.find_by_id(params[:entry][:charge_type_id])
      params[:entry][:charge_type_id] = charge_type ? charge_type.id : nil
    end

    params[:entry][:decimal_amount] = params[:entry][:decimal_amount].to_s.gsub(/[\s$,]/, '')

    params[:entry].slice(
      :name, :charge_type_id, :billing_date, :decimal_amount, :description, :charged
    )
  end

  def initialize_graph
    @gross_spending = []
    @gross_income = []
    @net_profit = []
  end

  def add_to_graph(start_date, end_date)
    @gross_spending << current_user.gross(start_date, end_date, true)
    @gross_income << current_user.gross(start_date, end_date, false)
    @net_profit << current_user.net_profit(start_date, end_date)
  end

  def set_entry
    @entry = current_user.entries.find_by_id(params[:id])
  end
end
