class EntriesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :initialize_graph, only: [:overview, :earning_spending_graph]

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
    # current_user.update_attribute :entries_per_page, params[:entries_per_page].to_i if params[:entries_per_page].to_i >= 10 and params[:entries_per_page].to_i <= 200
    entry_scope = current_user.entries.with_charged(params[:charged] == "1")
    @search_terms = params[:search].to_s.gsub(/[^0-9a-zA-Z]/, ' ').split(' ')
    @search_terms.each{|search_term| entry_scope = entry_scope.search(search_term) }

    @order = scrub_order(Entry, params[:order], 'billing_date desc, id desc')
    entry_scope = entry_scope.order(@order)

    @entries = entry_scope.page(params[:page]).per(20) # current_user.entries_per_page)
  end

  def show
    @entry = current_user.entries.find_by_id(params[:id])
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
    @entry = current_user.entries.find_by_id(params[:id])
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
    @entry = current_user.entries.find_by_id(params[:id])
    if @entry.update_attributes(post_params)
      flash[:notice] = 'Entry was successfully updated.'
      redirect_to @entry
    else
      render action: :edit
    end
  end

  def move
    @entry = current_user.entries.find_by_id(params[:id])
    params[:entry][:billing_date] = parse_date(params[:entry][:billing_date])

    if @entry and not params[:entry][:billing_date].blank?
      @entry.update_attributes billing_date: params[:entry][:billing_date]
      render 'update'
    else
      render nothing: true
    end
  end

  def mark_charged
    @entry = current_user.entries.find_by_id(params[:id])
    @entry.update_attribute :charged, true if @entry
  end

  def destroy
    @entry = current_user.entries.find_by_id(params[:id])
    @entry.destroy if @entry
    redirect_to entries_path
  end

  def autocomplete
    @entries = Entry.with_user(current_user.id).search(params[:search]).group('name').order('COUNT(id) DESC, name ASC').limit(8)
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
end
