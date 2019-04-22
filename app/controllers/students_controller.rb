class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    facility_id = params[:room_id]
    opts = { facility_id: facility_id && BSON::ObjectId(facility_id)}.delete_if { |key, value| value.blank?}
    query = []
    unless params[:key].blank?
      query << { name: /.*#{params[:key]}.*/ }
      query << { sno: /.*#{params[:key]}.*/ }
      query << { id_card: /.*#{params[:key]}.*/ }
    end
    @students = paginate(Student.where(opts).or(query))
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    if @student.save
      render :show, status: :created, location: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    if @student.update(student_params)
      render :show, status: :ok, location: @student
    else
      render json: @student.errors, status: :unprocessable_entity
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_student
    begin
      BSON::ObjectId(params[:id])
      @student = Student.find(params[:id])
    rescue StandardError
      @student = Student.find_by(sno: params[:id])
    end
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.fetch(:student, {}).permit!
  end
end
