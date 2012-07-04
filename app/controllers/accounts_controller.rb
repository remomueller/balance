class AccountsController < ApplicationController
  before_filter :authenticate_user!

  def index
    # current_user.update_attribute :accounts_per_page, params[:accounts_per_page].to_i if params[:accounts_per_page].to_i >= 10 and params[:accounts_per_page].to_i <= 200
    account_scope = current_user.accounts
    @search_terms = params[:search].to_s.gsub(/[^0-9a-zA-Z]/, ' ').split(' ')
    @search_terms.each{|search_term| account_scope = account_scope.search(search_term) }

    @order = scrub_order(Account, params[:order], 'accounts.name')
    account_scope = account_scope.order(@order)

    @accounts = account_scope.page(params[:page]).per(20) # current_user.accounts_per_page)
  end

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
    @account = current_user.accounts.new(post_params)
    if @account.save
      flash[:notice] = 'Account was successfully created.'
      redirect_to @account
    else
      render action: :new
    end
  end

  def update
    @account = current_user.accounts.find(params[:id])
    if @account.update_attributes(post_params)
      flash[:notice] = 'Account was successfully updated.'
      redirect_to @account
    else
      render action: :edit
    end
  end

  def destroy
    @account = current_user.accounts.find(params[:id])
    @account.destroy
    redirect_to accounts_path
  end

  private

  def post_params
    params[:account] ||= {}

    params[:account].slice(
      :name
    )
  end

end
