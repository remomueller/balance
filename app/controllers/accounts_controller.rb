# frozen_string_literal: true

# Allows users to modify and edit existing accounts.
class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_account_or_redirect, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  def index
    @order = scrub_order(
      Account, params[:order],
      'accounts.archived, accounts.category desc, accounts.name'
    )
    @accounts = current_user.accounts.search(params[:search])
                            .order(@order)
                            .page(params[:page]).per(40)
  end

  # GET /accounts/1
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
  def create
    @account = current_user.accounts.new(account_params)
    if @account.save
      redirect_to @account, notice: 'Account was successfully created.'
    else
      render :new
    end
  end

  # PATCH /accounts/1
  def update
    if @account.update(account_params)
      redirect_to @account, notice: 'Account was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /accounts/1
  def destroy
    @account.destroy
    redirect_to accounts_path
  end

  private

  def find_account_or_redirect
    @account = current_user.accounts.find_by_id params[:id]
    redirect_without_account
  end

  def redirect_without_account
    empty_response_or_root_path(accounts_path) unless @account
  end

  def account_params
    params.require(:account).permit(:name, :category, :archived)
  end
end
