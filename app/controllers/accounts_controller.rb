class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  def index
    @order = scrub_order(Account, params[:order], 'accounts.name')
    @accounts = current_user.accounts.search(params[:search]).order(@order).page(params[:page]).per(20)
  end

  def show

  end

  def new
    @account = current_user.accounts.new
  end

  def edit

  end

  def create
    @account = current_user.accounts.new(post_params)
    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render action: :new
    end
  end

  def update
    if @account.update_attributes(post_params)
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render action: :edit
    end
  end

  def destroy
    @account.destroy if @account
    redirect_to accounts_path
  end

  private

  def post_params
    params[:account] ||= {}

    params[:account].slice(
      :name
    )
  end

  def set_account
    @account = current_user.accounts.find_by_id(params[:id])
  end

end
