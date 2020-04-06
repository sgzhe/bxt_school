class MassagesController < ApplicationController
  before_action :set_massage, only: [:show, :update, :destroy]

  # GET /massages
  # GET /massages.json
  def index
    @massages = Massage.all
  end

  # GET /massages/1
  # GET /massages/1.json
  def show
  end

  # POST /massages
  # POST /massages.json
  def create
    @massage = Massage.new(massage_params)

    if @massage.save
      render :show, status: :created, location: @massage
    else
      render json: @massage.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /massages/1
  # PATCH/PUT /massages/1.json
  def update
    if @massage.update(massage_params)
      render :show, status: :ok, location: @massage
    else
      render json: @massage.errors, status: :unprocessable_entity
    end
  end

  # DELETE /massages/1
  # DELETE /massages/1.json
  def destroy
    @massage.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_massage
      @massage = Massage.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def massage_params
      params.fetch(:massage, {})
    end
end
