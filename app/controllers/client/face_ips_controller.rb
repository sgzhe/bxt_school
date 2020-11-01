class Client::FaceIpsController < ApplicationController
  before_action :set_client_face_ip, only: [:show, :update, :destroy]

  # GET /client/face_ips
  # GET /client/face_ips.json
  def index
    parent_id = BSON::ObjectId(params[:facility_id]) unless params[:facility_id].blank?
    house_id = BSON::ObjectId(params[:house_id]) unless params[:house_id].blank?
    opts = {
        user_facility_ids: parent_id || house_id,
        :status.in => [:add, :delete]
    }.delete_if {|key, value| value.blank?}

    @client_face_ips = paginate(FaceIp.includes(:user).where(opts))
  end

  # GET /client/face_ips/1
  # GET /client/face_ips/1.json
  def show
  end

  # POST /client/face_ips
  # POST /client/face_ips.json
  def create
    @client_face_ips = FaceIp.factory(client_face_ip_params)

    if @client_face_ips
      render :show, status: :created
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client/face_ips/1
  # PATCH/PUT /client/face_ips/1.json
  def update
    if @client_face_ip.update(client_face_ip_params)
      render :show, status: :ok
    else
      render json: @client_face_ip.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client/face_ips/1
  # DELETE /client/face_ips/1.json
  def destroy
    @client_face_ip.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_face_ip
      @client_face_ip = FaceIp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_face_ip_params
      params.fetch(:face_ip, {}).permit!
    end
end
