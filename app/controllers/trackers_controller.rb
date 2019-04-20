class TrackersController < ApplicationController
  before_action :set_tracker, only: [:show, :update, :destroy]

  # GET /trackers
  # GET /trackers.json
  def index
    opts = { facility_id: params[:facility_id] && BSON::ObjectId(params[:facility_id])}.delete_if { |key, value| value.blank? }
    @trackers = paginate(Tracker.where(opts).order_by('traces.pass_time': -1).all)
  end

  # GET /trackers/1
  # GET /trackers/1.json
  def show
  end

  # POST /trackers
  # POST /trackers.json
  def create
    @tracker = Tracker.new(tracker_params)

    if @tracker.save
      render :show, status: :created, location: @tracker
    else
      render json: @tracker.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /trackers/1
  # PATCH/PUT /trackers/1.json
  def update
    if @tracker.update(tracker_params)
      render :show, status: :ok, location: @tracker
    else
      render json: @tracker.errors, status: :unprocessable_entity
    end
  end

  # DELETE /trackers/1
  # DELETE /trackers/1.json
  def destroy
    @tracker.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tracker
    @tracker = Tracker.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def tracker_params
    params.fetch(:tracker, {}).permit!
  end
end
