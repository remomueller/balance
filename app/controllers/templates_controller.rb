# Allows templates to be viewed and modified
class TemplatesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_template, only: [:show, :edit, :update, :destroy]

  # GET /templates
  def index
    @templates = current_user.templates.page(params[:page]).per(40)
  end

  # GET /templates/1
  def show
  end

  # GET /templates/new
  def new
    @template = current_user.templates.new
  end

  # GET /templates/1/edit
  def edit
  end

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
    redirect_to templates_path, notice: 'Template was successfully destroyed.'
  end

  private

  def set_template
    @template = current_user.templates.find_by_id params[:id]
    redirect_to root_path unless @template
  end

  def template_params
    params.require(:template).permit(:name)
  end
end
