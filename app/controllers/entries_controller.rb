class EntriesController < ApplicationController
  before_filter :authenticate_user!

  def overview
    @today = Date.today.year
    @year = @today.year
    @month = @today.month
    @entries = []
    @gross_spending = []
    @gross_income = []
    @net_profit = []
    (current_user.first_billing_date.year..Date.today.year).each do |year|
      @entries << current_user.entries.with_date_for_calendar(year_start_date(year), year_end_date(year))
      @gross_spending << -(@entries.last.select{|e| e.charge_type.counts_towards_spending?}.sum{|e| e.amount})
      @gross_income << @entries.last.select{|e| not e.charge_type.counts_towards_spending?}.sum{|e| e.amount}
      @net_profit << @gross_income.last + @gross_spending.last
    end
  end
  
  def earning_spending_graph
    @year = params[:year].to_i
    @month = params[:month].to_i
    if params[:month] and params[:year]
      @entries = []
      @gross_spending = []
      @gross_income = []
      @net_profit = []
      (1..12).each do |month|
        @entries << current_user.entries.with_date_for_calendar(month_start_date(params[:year], month), month_end_date(params[:year], month))
        @gross_spending << -(@entries.last.select{|e| e.charge_type.counts_towards_spending?}.sum{|e| e.amount})
        @gross_income << @entries.last.select{|e| not e.charge_type.counts_towards_spending?}.sum{|e| e.amount}
        @net_profit << @gross_income.last + @gross_spending.last
      end
    else
      render :nothing => true
    end
  end
  
  def index
    # current_user.update_attribute :entries_per_page, params[:entries_per_page].to_i if params[:entries_per_page].to_i >= 10 and params[:entries_per_page].to_i <= 200
    entry_scope = current_user.entries.with_charged(params[:charged] == "1")
    @search_terms = params[:search].to_s.gsub(/[^0-9a-zA-Z]/, ' ').split(' ')
    @search_terms.each{|search_term| entry_scope = entry_scope.search(search_term) }
    @entries = entry_scope.page(params[:page]).per(20) # current_user.entries_per_page)
  end
  
  # def search
  #   if params[:search]
  #     @entries = current_user.entries.with_charged(params[:charged] == "1").paginate(:per_page => 20, :page => params[:page],
  #       :conditions => [ 'LOWER(name) LIKE ?', '%' + params['search'].downcase.split(' ').join('%') + '%' ])
  #     render :update do |page|
  #       page.replace_html 'entry_search', :partial => 'search'
  #     end
  #   end
  # end

  def show
    @entry = current_user.entries.find_by_id(params[:id])
  end

  def new
    params[:entry] = {} if params[:entry].blank?
    @entry = current_user.entries.new(params[:entry])
    @entry.billing_date = Date.today if @entry.billing_date.blank?
  end

  def edit
    @entry = current_user.entries.find_by_id(params[:id])
  end

  def create
    params[:entry][:billing_date] = Date.strptime(params[:entry][:billing_date], "%m/%d/%Y") if params[:entry] and not params[:entry][:billing_date].blank?
    
    @entry = current_user.entries.new(params[:entry])
    if @entry.save
      flash[:notice] = 'Entry was successfully created.'
      redirect_to @entry
    else
      render :action => :new
    end
  end

  def update
    params[:entry][:billing_date] = Date.strptime(params[:entry][:billing_date], "%m/%d/%Y") if params[:entry] and not params[:entry][:billing_date].blank?
    
    @entry = current_user.entries.find_by_id(params[:id])
    if @entry.update_attributes(params[:entry])
      flash[:notice] = 'Entry was successfully updated.'
      redirect_to @entry
    else
      render :action => :edit
    end
  end

  def mark_charged
    @entry = current_user.entries.find_by_id(params[:id])
    @entry.update_attribute :charged, true if @entry
  end

  def destroy
    @entry = current_user.entries.find_by_id(params[:id])
    @entry.destroy if @entry
    redirect_to entries_url
  end
  
  def autocomplete
    @entries = Entry.with_user(current_user.id).group('name').order('COUNT(id) DESC, name ASC').where(['LOWER(name) LIKE ?', '%' + params[:term].downcase.split(' ').join('%') + '%']).limit(8)
  end
end
