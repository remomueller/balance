# frozen_string_literal: true

# Handles creation of transfer and charge types for accounts.
class ChargeTypesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_charge_type, only: [ :show, :edit, :update, :destroy ]
  before_action :redirect_without_charge_type, only: [ :show, :edit, :update, :destroy ]

  # GET /charge_types
  # GET /charge_types.json
  def index
    @order = scrub_order(ChargeType, params[:order], 'charge_types.name')
    @charge_types = current_user.charge_types.search(params[:search]).order(@order).page(params[:page]).per( 40 )
  end

  # GET /charge_types/1
  # GET /charge_types/1.json
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
  # POST /charge_types.json
  def create
    @charge_type = current_user.charge_types.new(charge_type_params)

    respond_to do |format|
      if @charge_type.save
        format.html { redirect_to @charge_type, notice: 'Charge Type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @charge_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @charge_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /charge_types/1
  # PUT /charge_types/1.json
  def update
    respond_to do |format|
      if @charge_type.update(charge_type_params)
        format.html { redirect_to @charge_type, notice: 'Charge Type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @charge_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /charge_types/1
  # DELETE /charge_types/1.json
  def destroy
    @charge_type.destroy

    respond_to do |format|
      format.html { redirect_to charge_types_path }
      format.json { head :no_content }
    end
  end

  private

    def set_charge_type
      @charge_type = current_user.charge_types.find_by_id(params[:id])
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
