class ChargeTypesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :set_charge_type, only: [:show, :edit, :update, :destroy]

  def index
    @order = scrub_order(ChargeType, params[:order], 'charge_types.name')
    @charge_types = current_user.charge_types.search(params[:search]).order(@order).page(params[:page]).per(20)
  end

  def show

  end

  def new
    @charge_type = current_user.charge_types.new
  end

  def edit

  end

  def create
    @charge_type = current_user.charge_types.new(post_params)

    if @charge_type.save
      redirect_to @charge_type, notice: 'Charge Type was successfully created.'
    else
      render action: :new
    end
  end

  def update
    if @charge_type.update_attributes(post_params)
      redirect_to @charge_type, notice: 'Charge Type was successfully updated.'
    else
      render action: :edit
    end
  end

  def destroy
    @charge_type.destroy if @charge_type
    redirect_to charge_types_path
  end

  private

  def post_params
    params[:charge_type] ||= {}

    unless params[:charge_type][:account_id].blank?
      account = current_user.accounts.find_by_id(params[:charge_type][:account_id])
      params[:charge_type][:account_id] = account ? account.id : nil
    end

    params[:charge_type].slice(
      :name, :account_id, :counts_towards_spending
    )
  end

  def set_charge_type
    @charge_type = current_user.charge_types.find_by_id(params[:id])
  end

end
