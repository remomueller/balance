# frozen_string_literal: true

# Allows templates to be viewed and modified.
class TemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar"

  # # POST /template/add_item.js
  # def add_item
  # end

  def launch_template
    @template = current_user.templates.find_by(id: params[:template_id])
    billing_date = parse_date(params[:template_billing_date])
    if @template && billing_date
      @template.template_items.each do |template_item|
        @entry = current_user.entries.create(
          amount: template_item.amount,
          billing_date: billing_date,
          charge_type_id: template_item.charge_type_id,
          description: template_item.description,
          name: template_item.name,
          charged: false
        )
      end
      render 'entries/create' if @entry
    end
  end

  # GET /templates
  def index
    @templates = current_user.templates
                             .search(params[:search])
                             .page(params[:page]).per(40)
  end

  # # GET /templates/1
  # def show
  # end

  # GET /templates/new
  def new
    @template = current_user.templates.new
  end

  # # GET /templates/1/edit
  # def edit
  # end

  # POST /templates
  def create
    @template = current_user.templates.new(template_params)
    if @template.save
      redirect_to @template, notice: 'Template was successfully created.'
    else
      render :new
    end
  end

  # PATCH /templates/1
  def update
    if @template.update(template_params)
      redirect_to @template, notice: 'Template was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /templates/1
  def destroy
    @template.destroy
    redirect_to templates_path, notice: 'Template was successfully deleted.'
  end

  private

  def set_template
    @template = current_user.templates.find_by(id: params[:id])
    redirect_to root_path unless @template
  end

  def template_params
    params.require(:template).permit(
      :name,
      item_hashes: [:charge_type_id, :name, :decimal_amount, :description]
    )
  end
end
