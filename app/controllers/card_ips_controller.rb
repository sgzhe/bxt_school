class CardIpsController < ApplicationController
  before_action :set_card_ip, only: [:show, :update, :destroy]

  # GET /card_ips
  # GET /card_ips.json
  def index
    parent_id = BSON::ObjectId(params[:facility_id]) unless params[:facility_id].blank?
    house_id = BSON::ObjectId(params[:house_id]) unless params[:house_id].blank?
    opts = {
        user_facility_ids: parent_id || house_id,
        :status.in => [:add, :delete]
    }.delete_if {|key, value| value.blank?}

    @card_ips = paginate(CardIp.includes(:user).where(opts))
  end

  # GET /card_ips/1
  # GET /card_ips/1.json
  def show
  end

  # POST /card_ips
  # POST /card_ips.json
  def create
    @card_ips = CardIp.factory(card_ip_params)

    if @card_ips.save
      render :show, status: :created
    else
      render json: @card_ip.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /card_ips/1
  # PATCH/PUT /card_ips/1.json
  def update
    if @card_ip.update(card_ip_params)
      render :show, status: :ok, location: @card_ip
    else
      render json: @card_ip.errors, status: :unprocessable_entity
    end
  end

  # DELETE /card_ips/1
  # DELETE /card_ips/1.json
  def destroy
    @card_ip.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_ip
      @card_ip = CardIp.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def card_ip_params
      params.fetch(:card_ip, {}).permit!
    end
end
