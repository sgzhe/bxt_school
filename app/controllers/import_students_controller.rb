class ImportStudentsController < ApplicationController
  before_action :set_import_student, only: [:show, :update, :destroy]

  # GET /import_students
  # GET /import_students.json
  def index
    @import_students = ImportStudent.all
  end

  # GET /import_students/1
  # GET /import_students/1.json
  def show
  end

  # POST /import_students
  # POST /import_students.json
  def create
    @import_student = ImportStudent.new(import_student_params)

    if @import_student.save
      render :show, status: :ok, location: @import_student
    else
      render json: @import_student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /import_students/1
  # PATCH/PUT /import_students/1.json
  def update
    if @import_student.update(import_student_params)
      render :show, status: :ok, location: @import_student
    else
      render json: @import_student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /import_students/1
  # DELETE /import_students/1.json
  def destroy
    @import_student.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_import_student
      @import_student = ImportStudent.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def import_student_params
      params.fetch(:import_student, {}).permit!
    end
end
