class LatecomersController < ApplicationController
  before_action :set_latecomer, only: [:show, :update, :destroy]

  # GET /latecomers
  # GET /latecomers.json
  def index
    facility_id = BSON::ObjectId(params[:facility_id]) unless params[:facility_id].blank?
    org_id = BSON::ObjectId(params[:org_id]) unless params[:org_id].blank?
    opts = {
        facility_ids: facility_id,
        user_org_ids: org_id,
        access_ids: params[:facility_access_id] && BSON::ObjectId(params[:facility_access_id]),
        status: params[:status],
        :pass_time.gte => params[:start_at],
        :pass_time.lte => params[:end_at]
    }.delete_if { |key, value| value.blank? }
    query = []
    unless params[:key].blank?
      query << { user_name: /.*#{params[:key]}.*/ }
      query << { user_sno: /.*#{params[:key]}.*/ }
    end
    @latecomers = paginate(Latecomer.where(opts).or(query))
  end

  # GET /latecomers/1
  # GET /latecomers/1.json
  def show
  end

  # POST /latecomers
  # POST /latecomers.json
  def create
    @latecomer = Latecomer.new(latecomer_params)

    if @latecomer.save
      render :show, status: :created, location: @latecomer
    else
      render json: @latecomer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /latecomers/1
  # PATCH/PUT /latecomers/1.json
  def update
    if @latecomer.update(latecomer_params)
      render :show, status: :ok, location: @latecomer
    else
      render json: @latecomer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /latecomers/1
  # DELETE /latecomers/1.json
  def destroy
    @latecomer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_latecomer
      @latecomer = Latecomer.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def latecomer_params
      params.fetch(:latecomer, {}).permit!
    end
end
