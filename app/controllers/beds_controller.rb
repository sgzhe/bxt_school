class BedsController < ApplicationController
  #before_action :authorize_access_request!
  before_action :set_bed, only: [:show, :update, :destroy]

  # GET /beds
  # GET /beds.json
  def index
    parent_id = params[:room_id] || params[:floor_id] || params[:house_id]
    opts = {parent_ids: parent_id && BSON::ObjectId(parent_id)}.delete_if {|key, value| value.blank?}
    @beds = paginate(Bed.where(opts))
  end

  # GET /beds/1
  # GET /beds/1.json
  def show
  end

  # POST /beds
  # POST /beds.json
  def create
    @bed = Bed.new(bed_params)

    if @bed.save
      render :show, status: :created, location: @bed
    else
      render json: @bed.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /beds/1
  # PATCH/PUT /beds/1.json
  def update
    if @bed.update(bed_params)
      render :show, status: :ok, location: @bed
    else
      render json: @bed.errors, status: :unprocessable_entity
    end
  end

  # DELETE /beds/1
  # DELETE /beds/1.json
  def destroy
    @bed.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bed
      @bed = Bed.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def bed_params
      params.fetch(:bed, {}).permit!
    end
end
