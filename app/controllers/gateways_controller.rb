class GatewaysController < ApplicationController
  before_action :set_gateway, only: [:show, :update, :destroy]

  # GET /gateways
  # GET /gateways.json
  def index
    @gateways = paginate(Gateway.all)
  end

  # GET /gateways/1
  # GET /gateways/1.json
  def show
  end

  # POST /gateways
  # POST /gateways.json
  def create
    @gateway = Gateway.new(gateway_params)

    if @gateway.save
      render :show, status: :created, location: @gateway
    else
      render json: @gateway.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gateways/1
  # PATCH/PUT /gateways/1.json
  def update
    if @gateway.update(gateway_params)
      render :show, status: :ok, location: @gateway
    else
      render json: @gateway.errors, status: :unprocessable_entity
    end
  end

  # DELETE /gateways/1
  # DELETE /gateways/1.json
  def destroy
    @gateway.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gateway
      @gateway = Gateway.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gateway_params
      params.require(:gateway).permit(:title, :desc)
    end
end
