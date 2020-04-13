class HomingsController < ApplicationController
  before_action :set_homing, only: [:show, :update, :destroy]

  # GET /homings
  # GET /homings.json
  def index
    org_id = BSON::ObjectId(params[:org_id]) unless params[:org_id].blank?
    facility_id = params[:dorm_id] || params[:floor_id] || params[:house_id] || params[:facility_id]
    facility_id = facility_id && BSON::ObjectId(facility_id)
    opts = {facility_ids: facility_id,
        org_ids: org_id,
        direction_at_last: params[:direction]
    }.delete_if { |key, value| value.blank? }
    query = []
    unless params[:key].blank?
      query << { name: /.*#{params[:key]}.*/ }
      query << { sno: /.*#{params[:key]}.*/ }
      query << { id_card: /.*#{params[:key]}.*/ }
    end
    query << {} if query.blank?
    @direct_stats = Student.direct_stats(opts)
    @homings = paginate(Student.includes(:dept, :dorm).where(opts).and('$or': query))
  end

  # GET /homings/1
  # GET /homings/1.json
  def show
  end

  # POST /homings
  # POST /homings.json
  def create
    @homing = Homing.new(homing_params)

    if @homing.save
      render :show, status: :created, location: @homing
    else
      render json: @homing.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /homings/1
  # PATCH/PUT /homings/1.json
  def update
    if @homing.update(homing_params)
      render :show, status: :ok, location: @homing
    else
      render json: @homing.errors, status: :unprocessable_entity
    end
  end

  # DELETE /homings/1
  # DELETE /homings/1.json
  def destroy
    @homing.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_homing
      @homing = Homing.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def homing_params
      params.fetch(:homing, {}).permit!
    end
end
