class EntriesController < ApplicationController
  before_action :authenticate_user!
  before_action :initialize_graph, only: [ :overview, :earning_spending_graph ]
  before_action :set_entry, only: [ :show, :edit, :update, :move, :mark_charged, :destroy ]
  before_action :redirect_without_entry, only: [ :show, :edit, :update, :move, :mark_charged, :destroy ]

  def calendar
    @date = Date.strptime(params[:date], "%Y%m%d") rescue @date = Date.today
    @selected_date = @date # parse_date(params[:selected_date], Date.today)

    @start_month = @selected_date.beginning_of_month
    @end_month = @selected_date.end_of_month

    @start_date = @start_month.beginning_of_week - 1.day
    @end_date = @end_month.end_of_week - 1.day
  end

  def averages
  end

  def current_balance
  end

  def overview
    (current_user.first_billing_date.year..Date.today.year).each do |year|
      add_to_graph(year_start_date(year), year_end_date(year))
    end
    @year_json = {
      title: "Full Overview",
      y_title: "Dollars",
      categories: (current_user.first_billing_date.year..Date.today.year).to_a,
      series: [
        {
          name: 'Gross Income',
          data: @gross_income,
          color: '#3c763d'
        },
        {
          name: 'Gross Spending',
          data: @gross_spending,
          color: '#a94442'
        },
        {
          name: 'Net Profit',
          data: @net_profit,
          color: '#5cb85c',
          negativeColor: '#d9534f'
        }
      ]
    }
  end

  def earning_spending_graph
    params[:year] = Date.today.year if params[:year].blank?
    (1..12).each do |month|
      add_to_graph(month_start_date(params[:year], month), month_end_date(params[:year], month))
    end
    @month_json = {
      title: "#{params[:year]} Overview",
      y_title: "Dollars",
      categories: ["Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"],
      series: [
        {
          name: 'Gross Income',
          data: @gross_income,
          color: '#3c763d'
        },
        {
          name: 'Gross Spending',
          data: @gross_spending,
          color: '#a94442'
        },
        {
          name: 'Net Profit',
          data: @net_profit,
          color: '#5cb85c',
          negativeColor: '#d9534f'
        }
      ]
    }
  end


  # GET /entries
  # GET /entries.json
  def index
    @order = scrub_order(Entry, params[:order], 'billing_date desc, id desc')
    @entries = current_user.entries.where(charged: (params[:charged] == 'uncharged' ? false : [true, false])).search(params[:search]).order(@order).page(params[:page]).per( 40 )
  end

  # GET /entries/1
  # GET /entries/1.json
  def show
  end

  # GET /entries/new
  def new
    @entry = current_user.entries.new(entry_params)
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

  # GET /entries/1/edit
  def edit
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = current_user.entries.new(entry_params)

    respond_to do |format|
      if @entry.save
        format.html { redirect_to @entry, notice: 'Entry was successfully created.' }
        format.js { render 'create' }
      else
        format.html { render 'new' }
        format.js { render 'new' }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    respond_to do |format|
      if @entry.update(entry_params)
        format.html { redirect_to @entry, notice: 'Entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  def move
    params[:entry][:billing_date] = parse_date(params[:entry][:billing_date])

    if @entry and not params[:entry][:billing_date].blank?
      @entry.update billing_date: params[:entry][:billing_date]
      redirect_via_turbolinks_to calendar_path(date: @entry.billing_date.strftime("%Y%m%d"))
      # render 'update'
    else
      render nothing: true
    end
  end

  def mark_charged
    @entry.update charged: true
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry.destroy

    respond_to do |format|
      format.html { redirect_to entries_path }
      format.json { head :no_content }
    end
  end

  def autocomplete
    # TODO: Change to make sure it lists the most commonly entered first.
    @entries = current_user.entries.search(params[:search]).group('name, id').order('COUNT(id) DESC, name ASC').limit(8)
    render json: @entries.collect(&:name)
  end

  private

    def set_entry
      @entry = current_user.entries.find_by_id(params[:id])
    end

    def redirect_without_entry
      empty_response_or_root_path(entries_path) unless @entry
    end

    def entry_params
      params[:entry] ||= {}

      params[:entry][:billing_date] = parse_date(params[:entry][:billing_date])

      unless params[:entry][:charge_type_id].blank?
        charge_type = current_user.charge_types.find_by_id(params[:entry][:charge_type_id])
        params[:entry][:charge_type_id] = charge_type ? charge_type.id : nil
      end

      params[:entry][:decimal_amount] = params[:entry][:decimal_amount].to_s.gsub(/[\s$,]/, '')

      params.require(:entry).permit(
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
