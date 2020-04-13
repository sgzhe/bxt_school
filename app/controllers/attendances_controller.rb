class AttendancesController < ApplicationController
  #before_action :set_attendance, only: [:show, :update, :destroy]

  # GET /attendances
  # GET /attendances.json
  def index
    opts = {
        access_ids: params[:access_id] && BSON::ObjectId(params[:access_id]),
        :day.gte => params[:start_at],
        :day.lte => params[:end_at]
    }.delete_if { |key, value| value.blank? }
    query = []
    unless params[:key].blank?
      query << { user_name: /.*#{params[:key]}.*/ }
    end
    query << {} if query.blank?
    @attendances = paginate(Attendance.where(opts).and('$or': query))
  end

  # GET /attendances/1
  # GET /attendances/1.json
  def show
  end

  # POST /attendances
  # POST /attendances.json
  def create
    @attendance = Attendance.new(attendance_params)

    if @attendance.save
      render :show, status: :created, location: @attendance
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /attendances/1
  # PATCH/PUT /attendances/1.json
  def update
    if @attendance.update(attendance_params)
      render :show, status: :ok, location: @attendance
    else
      render json: @attendance.errors, status: :unprocessable_entity
    end
  end

  # DELETE /attendances/1
  # DELETE /attendances/1.json
  def destroy
    @attendance.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_attendance
      @attendance = Attendance.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def attendance_params
      params.fetch(:attendance, {})
    end
end
