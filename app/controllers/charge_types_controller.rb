class ChargeTypesController < ApplicationController
  before_filter :authenticate_user!

  def index
    # current_user.update_attribute :charge_types_per_page, params[:charge_types_per_page].to_i if params[:charge_types_per_page].to_i >= 10 and params[:charge_types_per_page].to_i <= 200
    charge_type_scope = current_user.charge_types
    @search_terms = params[:search].to_s.gsub(/[^0-9a-zA-Z]/, ' ').split(' ')
    @search_terms.each{|search_term| charge_type_scope = charge_type_scope.search(search_term) }

    @order = scrub_order(ChargeType, params[:order], 'charge_types.name')
    charge_type_scope = charge_type_scope.order(@order)

    @charge_types = charge_type_scope.page(params[:page]).per(20) # current_user.charge_types_per_page)
  end

  def show
    @charge_type = current_user.charge_types.find(params[:id])
  end

  def new
    @charge_type = current_user.charge_types.new
  end

  def edit
    @charge_type = current_user.charge_types.find(params[:id])
  end

  def create
    @charge_type = current_user.charge_types.new(post_params)

    if @charge_type.save
      flash[:notice] = 'Charge Type was successfully created.'
      redirect_to @charge_type
    else
      render action: :new
    end
  end

  def update
    @charge_type = current_user.charge_types.find(params[:id])

    if @charge_type.update_attributes(post_params)
      flash[:notice] = 'Charge Type was successfully updated.'
      redirect_to @charge_type
    else
      render action: :edit
    end
  end

  def destroy
    @charge_type = current_user.charge_types.find(params[:id])
    @charge_type.destroy

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
end
