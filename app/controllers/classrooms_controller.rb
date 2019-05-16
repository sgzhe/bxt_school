class ClassroomsController < ApplicationController
  before_action :set_classroom, only: [:show, :update, :destroy]

  # GET /classrooms
  # GET /classrooms.json
  def index
    parent_id = params[:department_id] || params[:college_id]
    opts = {
      parent_id: parent_id && BSON::ObjectId(parent_id)
    }.delete_if { |key, value| value.blank? }
    opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?

    @classrooms = paginate(Classroom.where(opts))
  end

  # GET /classrooms/1
  # GET /classrooms/1.json
  def show
  end

  # POST /classrooms
  # POST /classrooms.json
  def create
    @classroom = Classroom.new(classroom_params)

    if @classroom.save
      render :show, status: :created, location: @classroom
    else
      render json: @classroom.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /classrooms/1
  # PATCH/PUT /classrooms/1.json
  def update
    if @classroom.update(classroom_params)
      render :show, status: :ok, location: @classroom
    else
      render json: @classroom.errors, status: :unprocessable_entity
    end
  end

  # DELETE /classrooms/1
  # DELETE /classrooms/1.json
  def destroy
    @classroom.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_classroom
      @classroom = Classroom.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def classroom_params
      params.fetch(:classroom, {}).permit!
    end
end
