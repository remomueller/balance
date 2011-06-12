class ChargeTypesController < ApplicationController
  before_filter :authenticate_user!
  
  def search
    if params[:search]
      @charge_types = current_user.charge_types.paginate(:per_page => 20, :page => params[:page],
        :conditions => [ 'LOWER(charge_types.name) LIKE ?', '%' + params['search'].downcase.split(' ').join('%') + '%' ])
      render :update do |page|
        page.replace_html 'charge_type_search', :partial => 'search'
      end
    end
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
    @charge_type = current_user.charge_types.new(params[:charge_type])

    if @charge_type.save
      flash[:notice] = 'Charge Type was successfully created.'
      redirect_to @charge_type
    else
      render :action => :new
    end
  end

  def update
    @charge_type = current_user.charge_types.find(params[:id])

    if @charge_type.update_attributes(params[:charge_type])
      flash[:notice] = 'Charge Type was successfully updated.'
      redirect_to @charge_type
    else
      render :action => :edit
    end
  end

  def destroy
    @charge_type = current_user.charge_types.find(params[:id])
    @charge_type.destroy

    redirect_to charge_types_url
  end
end
