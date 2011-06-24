class AccountsController < ApplicationController
  before_filter :authenticate_user!

  def index
    # current_user.update_attribute :accounts_per_page, params[:accounts_per_page].to_i if params[:accounts_per_page].to_i >= 10 and params[:accounts_per_page].to_i <= 200
    account_scope = current_user.accounts
    @search_terms = params[:search].to_s.gsub(/[^0-9a-zA-Z]/, ' ').split(' ')
    @search_terms.each{|search_term| account_scope = account_scope.search(search_term) }
    @accounts = account_scope.page(params[:page]).per(20) # current_user.accounts_per_page)
  end

  # def search
  #   if params[:search]
  #     @accounts = current_user.accounts.paginate( :order => 'name', :per_page => 20, :page => params[:page],
  #       :conditions => [ 'LOWER(name) LIKE ?', '%' + params['search'].downcase.split(' ').join('%') + '%' ])
  #     render :update do |page|
  #       page.replace_html 'account_search', :partial => 'search'
  #     end
  #   end
  # end

  def show
    @account = current_user.accounts.find(params[:id])
  end

  def new
    @account = current_user.accounts.new
  end

  def edit
    @account = current_user.accounts.find(params[:id])
  end

  def create
    @account = current_user.accounts.new(params[:account])
    if @account.save
      flash[:notice] = 'Account was successfully created.'
      redirect_to @account
    else
      render :action => :new
    end
  end

  def update
    @account = current_user.accounts.find(params[:id])
    if @account.update_attributes(params[:account])
      flash[:notice] = 'Account was successfully updated.'
      redirect_to @account
    else
      render :action => :edit
    end
  end

  def destroy
    @account = current_user.accounts.find(params[:id])
    @account.destroy
    redirect_to accounts_url
  end
end
