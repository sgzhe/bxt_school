class FaceIpsController < ApplicationController
  before_action :set_face_ip, only: [:show, :update, :destroy]

  # GET /face_ips
  # GET /face_ips.json
  def index
    parent_id = BSON::ObjectId(params[:facility_id]) unless params[:facility_id].blank?
    house_id = BSON::ObjectId(params[:house_id]) unless params[:house_id].blank?
    opts = {
        user_facility_ids: parent_id || house_id,
        :status.in => [:add, :delete]
    }.delete_if {|key, value| value.blank?}

    @face_ips = paginate(FaceIp.includes(:user).where(opts))
  end

  # GET /face_ips/1
  # GET /face_ips/1.json
  def show
  end

  # POST /face_ips
  # POST /face_ips.json
  def create
    @face_ips = FaceIp.factory(face_ip_params)

    if @face_ips
      render :show, status: :created
    else
      render json: @face_ip.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /face_ips/1
  # PATCH/PUT /face_ips/1.json
  def update
    if @face_ip.update(face_ip_params)
      render :show, status: :ok
    else
      render json: @face_ip.errors, status: :unprocessable_entity
    end
  end

  # DELETE /face_ips/1
  # DELETE /face_ips/1.json
  def destroy
    @face_ip.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_face_ip
      @face_ip = FaceIp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def face_ip_params
      params.fetch(:face_ip, {}).permit!
    end
end
