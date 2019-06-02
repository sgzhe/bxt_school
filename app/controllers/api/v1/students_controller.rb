class Api::V1::StudentsController < ApplicationController
  before_action :set_api_v1_student, only: [:show, :update, :destroy]

  # GET /api/v1/students
  # GET /api/v1/students.json
  def index
    @api_v1_students = Api::V1::Student.all
  end

  # GET /api/v1/students/1
  # GET /api/v1/students/1.json
  def show
  end

  # POST /api/v1/students
  # POST /api/v1/students.json
  def create
    @api_v1_student = Api::V1::Student.new(api_v1_student_params)

    if @api_v1_student.save
      render :show, status: :created, location: @api_v1_student
    else
      render json: @api_v1_student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/students/1
  # PATCH/PUT /api/v1/students/1.json
  def update
    if @api_v1_student.update(api_v1_student_params)
      render :show, status: :ok, location: @api_v1_student
    else
      render json: @api_v1_student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/students/1
  # DELETE /api/v1/students/1.json
  def destroy
    @api_v1_student.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_student
      @api_v1_student = Api::V1::Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_student_params
      params.fetch(:api_v1_student, {})
    end
end
