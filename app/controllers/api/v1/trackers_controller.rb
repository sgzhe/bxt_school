class Api::V1::TrackersController < ApplicationController
  before_action :set_api_v1_tracker, only: [:show, :update, :destroy]

  # GET /api/v1/trackers
  # GET /api/v1/trackers.json
  def index
    @api_v1_trackers = Api::V1::Tracker.all
  end

  # GET /api/v1/trackers/1
  # GET /api/v1/trackers/1.json
  def show
  end

  # POST /api/v1/trackers
  # POST /api/v1/trackers.json
  def create
    @api_v1_tracker = Api::V1::Tracker.new(api_v1_tracker_params)

    if @api_v1_tracker.save
      render :show, status: :created, location: @api_v1_tracker
    else
      render json: @api_v1_tracker.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/trackers/1
  # PATCH/PUT /api/v1/trackers/1.json
  def update
    if @api_v1_tracker.update(api_v1_tracker_params)
      render :show, status: :ok, location: @api_v1_tracker
    else
      render json: @api_v1_tracker.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/trackers/1
  # DELETE /api/v1/trackers/1.json
  def destroy
    @api_v1_tracker.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_tracker
      @api_v1_tracker = Api::V1::Tracker.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_tracker_params
      params.fetch(:api_v1_tracker, {})
    end
end
