class Client::CardIpsController < ApplicationController
  before_action :set_client_card_ip, only: [:show, :update, :destroy]

  # GET /client/card_ips
  # GET /client/card_ips.json
  def index
    parent_id = BSON::ObjectId(params[:facility_id]) unless params[:facility_id].blank?
    house_id = BSON::ObjectId(params[:house_id]) unless params[:house_id].blank?
    opts = {
        user_facility_ids: parent_id || house_id,
        :status.in => [:add, :delete]
    }.delete_if {|key, value| value.blank?}

    @client_card_ips = paginate(CardIp.includes(:user).where(opts))
  end

  # GET /client/card_ips/1
  # GET /client/card_ips/1.json
  def show
  end

  # POST /client/card_ips
  # POST /client/card_ips.json
  def create
    @client_card_ips = CardIp.factory(client_card_ip_params)

    if @client_card_ips
      render :show, status: :created
    else
      render json: {}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /client/card_ips/1
  # PATCH/PUT /client/card_ips/1.json
  def update
    if @client_card_ip.update(client_card_ip_params)
      render :show, status: :ok
    else
      render json: @client_card_ip.errors, status: :unprocessable_entity
    end
  end

  # DELETE /client/card_ips/1
  # DELETE /client/card_ips/1.json
  def destroy
    @client_card_ip.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_client_card_ip
      @client_card_ip = CardIp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def client_card_ip_params
      params.fetch(:card_ip, {}).permit!
    end
end
