class Client::TrackersController < ApplicationController
  before_action :set_tracker, only: [:show, :update, :destroy]

  # GET /trackers
  # GET /trackers.json
  def index
    facility_id = params[:facility_id]
    org_id = params[:org_id]
    opts = {
      user_facility_ids: facility_id && BSON::ObjectId(facility_id),
      user_org_ids: org_id && BSON::ObjectId(org_id),
      access_ids: params[:access_id] && BSON::ObjectId(params[:access_id]),
      status: params[:status],
      :pass_time.gte => params[:start_at],
      :pass_time.lte => params[:end_at]
    }.delete_if { |key, value| value.blank? }
    query = []
    unless params[:key].blank?
      query << { user_name: /.*#{params[:key]}.*/ }
      query << { user_sno: /.*#{params[:key]}.*/ }
      query << { user_nationality: /.*#{params[:key]}.*/ }
    end
    query << {} if query.blank?
    @trackers = paginate(Tracker.where(opts).and('$or': query))
  end

  # GET /trackers/1
  # GET /trackers/1.json
  def show
  end

  # POST /trackers
  # POST /trackers.json
  def create
    @tracker =  Guard.create(tracker_params)

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
