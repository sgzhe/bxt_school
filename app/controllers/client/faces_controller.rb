class Client::FacesController < ApplicationController
  before_action :set_face, only: [:show, :update, :destroy]
@@logger = Logger.new("#{Rails.root}/log/face.log")
@@logger.level = Logger::DEBUG

  # GET /faces
  # GET /faces.json
  def index
    parent_id = BSON::ObjectId(params[:facility_id]) unless params[:facility_id].blank?
    house_id = BSON::ObjectId(params[:house_id]) unless params[:house_id].blank?
    opts = {
        facility_ids: parent_id || house_id,
    }.delete_if {|key, value| value.blank?}
    @faces = paginate(Face.in(status: [:add, :delete]).where(opts))
  end

  # GET /faces/1
  # GET /faces/1.json
  def show
  end

  # POST /faces
  # POST /faces.json
  def create

    @face = Face.new(face_params)

    if @face.save
      render :show, status: :created, location: @face
    else
      render json: @face.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /faces/1
  # PATCH/PUT /faces/1.json
  def update
    @@logger.info("#{@face.id}: "+ face_params.to_json)
    @face.access_ips.merge!(face_params[:access_ips])
    @@logger.info("success: "+ @face.errors.massages)
    if @face.save
      @@logger.info("success: "+ @face.access_ips)
      render :show, status: :ok, location: @face
    else
      render json: @face.errors, status: :unprocessable_entity
    end
  end

  # DELETE /faces/1
  # DELETE /faces/1.json
  def destroy
    @face.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_face
      @face = Face.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def face_params
      params.fetch(:face, {}).permit!
    end
end
