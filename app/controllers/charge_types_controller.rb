# frozen_string_literal: true

# Handles creation of transfer and charge types for accounts.
class ChargeTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_charge_type_or_redirect, only: [:show, :edit, :update, :destroy]

  # GET /charge_types
  def index
    @order = scrub_order(ChargeType, params[:order], 'charge_types.name, accounts.name')
    @charge_types = current_user.charge_types.search(params[:search]).order(@order).page(params[:page]).per( 40 )
  end

  # GET /charge_types/1
  def show
  end

  # GET /charge_types/new
  def new
    @charge_type = current_user.charge_types.new
  end

  # GET /charge_types/1/edit
  def edit
  end

  # POST /charge_types
  def create
    @charge_type = current_user.charge_types.new(charge_type_params)
    if @charge_type.save
      redirect_to @charge_type, notice: 'Charge Type was successfully created.'
    else
      render :new
    end
  end

  # PATCH /charge_types/1
  def update
    if @charge_type.update(charge_type_params)
      redirect_to @charge_type, notice: 'Charge Type was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /charge_types/1
  def destroy
    @charge_type.destroy
    redirect_to charge_types_path
  end

  private

  def find_charge_type_or_redirect
    @charge_type = current_user.charge_types.find_by_id params[:id]
    redirect_without_charge_type
  end

  def redirect_without_charge_type
    empty_response_or_root_path(charge_types_path) unless @charge_type
  end

  def charge_type_params
    params[:charge_type] ||= {}
    unless params[:charge_type][:account_id].blank?
      account = current_user.accounts.find_by_id(params[:charge_type][:account_id])
      params[:charge_type][:account_id] = account ? account.id : nil
    end
    params.require(:charge_type).permit(
      :name, :account_id, :counts_towards_spending
    )
  end
end
