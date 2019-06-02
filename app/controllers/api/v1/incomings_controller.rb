class Api::V1::IncomingsController < ApplicationController
  before_action :set_api_v1_incoming, only: [:show, :update, :destroy]

  # GET /api/v1/incomings
  # GET /api/v1/incomings.json
  def index
    @api_v1_incomings = Api::V1::Incoming.all
  end

  # GET /api/v1/incomings/1
  # GET /api/v1/incomings/1.json
  def show
  end

  # POST /api/v1/incomings
  # POST /api/v1/incomings.json
  def create
    @api_v1_incoming = Api::V1::Incoming.new(api_v1_incoming_params)

    if @api_v1_incoming.save
      render :show, status: :created, location: @api_v1_incoming
    else
      render json: @api_v1_incoming.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/incomings/1
  # PATCH/PUT /api/v1/incomings/1.json
  def update
    if @api_v1_incoming.update(api_v1_incoming_params)
      render :show, status: :ok, location: @api_v1_incoming
    else
      render json: @api_v1_incoming.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/incomings/1
  # DELETE /api/v1/incomings/1.json
  def destroy
    @api_v1_incoming.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_incoming
      @api_v1_incoming = Api::V1::Incoming.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_incoming_params
      params.fetch(:api_v1_incoming, {})
    end
end
