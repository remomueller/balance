class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_account, only: [ :show, :edit, :update, :destroy ]
  before_action :redirect_without_account, only: [ :show, :edit, :update, :destroy ]

  # GET /accounts
  # GET /accounts.json
  def index
    @order = scrub_order(Account, params[:order], 'accounts.name')
    @accounts = current_user.accounts.search(params[:search]).order(@order).page(params[:page]).per( 40 )
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
  end

  # GET /accounts/new
  def new
    @account = current_user.accounts.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = current_user.accounts.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to @account, notice: 'Account was successfully created.' }
        format.json { render action: 'show', status: :created, location: @account }
      else
        format.html { render action: 'new' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to @account, notice: 'Account was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_path }
      format.json { head :no_content }
    end
  end

  private

    def set_account
      @account = current_user.accounts.find_by_id(params[:id])
    end

    def redirect_without_account
      empty_response_or_root_path(accounts_path) unless @account
    end

    def account_params
      params.require(:account).permit( :name )
    end

end
