# frozen_string_literal: true

# Allows users to modify and edit existing accounts.
class AccountsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_account_or_redirect, only: [:show, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar"

  # GET /accounts
  def index
    scope = current_user.accounts
    scope = scope_includes(scope)
    scope = scope_filter(scope)
    @accounts = scope_order(scope).page(params[:page]).per(40)
  end

  # # GET /accounts/1
  # def show
  # end

  # GET /accounts/new
  def new
    @account = current_user.accounts.new
  end

  # # GET /accounts/1/edit
  # def edit
  # end

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
    @account = current_user.accounts.find_by(id: params[:id])
    redirect_without_account
  end

  def redirect_without_account
    empty_response_or_root_path(accounts_path) unless @account
  end

  def account_params
    params.require(:account).permit(:name, :category, :archived)
  end

  def scope_includes(scope)
    scope.includes(:charge_types)
  end

  def scope_filter(scope)
    scope.search(params[:search])
  end

  def scope_order(scope)
    @order = scrub_order(
      Account, params[:order],
      'accounts.archived, accounts.category desc, accounts.name'
    )
    scope.order(@order)
  end
end
