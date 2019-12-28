class Client::StudentsController < ApplicationController
  before_action :set_student, only: [:show, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    org_id = params[:org_id]
    facility_id = params[:facility_id] || params[:dorm_id] || params[:floor_id] || params[:house_id]
    opts = {
      facility_ids: facility_id && BSON::ObjectId(facility_id),
      org_ids: org_id && BSON::ObjectId(org_id),
    }.delete_if { |key, value| value.blank?}
    query = []
    unless params[:key].blank?
      query << { name: /.*#{params[:key]}.*/ }
      query << { sno: /.*#{params[:key]}.*/ }
      query << { id_card: /.*#{params[:key]}.*/ }
    end

    @students = paginate(Student.includes(:dept, :dorm).where(opts).or(query).order(id: -1))
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
