class DepartmentsController < ApplicationController
  before_action :set_department, only: [:show, :update, :destroy]

  # GET /departments
  # GET /departments.json
  def index
    opts = { parent_id: params[:college_id] }.delete_if { |key, value| value.blank?}
    @departments = Department.where(opts).page(params[:page])
  end

  # GET /departments/1
  # GET /departments/1.json
  def show
  end

  # POST /departments
  # POST /departments.json
  def create
    @department = Department.new(department_params)

    if @department.save
      render :show, status: :created, location: @department
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /departments/1
  # PATCH/PUT /departments/1.json
  def update
    if @department.update(department_params)
      render :show, status: :ok, location: @department
    else
      render json: @department.errors, status: :unprocessable_entity
    end
  end

  # DELETE /departments/1
  # DELETE /departments/1.json
  def destroy
    @department.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_department
      @department = Department.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def department_params
      params.fetch(:department, {}).permit!
    end
end
