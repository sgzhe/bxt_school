class TeachersController < ApplicationController
  before_action :set_teacher, only: [:show, :update, :destroy]

  # GET /teachers
  # GET /teachers.json
  def index
    query = []
    unless params[:key].blank?
      query << { name: /.*#{params[:key]}.*/ }
      query << { sno: /.*#{params[:key]}.*/ }
      query << { id_card: /.*#{params[:key]}.*/ }
    end
    query << {} if query.blank?
    @teachers = paginate(Teacher.and('$or' => query))
  end

  # GET /teachers/1
  # GET /teachers/1.json
  def show
  end

  # POST /teachers
  # POST /teachers.json
  def create
    @teacher = Teacher.new(teacher_params)

    if @teacher.save
      render :show, status: :created, location: @teacher
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /teachers/1
  # PATCH/PUT /teachers/1.json
  def update
    if @teacher.update(teacher_params)
      render :show, status: :ok, location: @teacher
    else
      render json: @teacher.errors, status: :unprocessable_entity
    end
  end

  # DELETE /teachers/1
  # DELETE /teachers/1.json
  def destroy
    @teacher.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_teacher
    @teacher = Teacher.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def teacher_params
    params.fetch(:teacher, {}).permit!
  end
end
