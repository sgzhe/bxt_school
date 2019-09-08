class ExchangesController < ApplicationController
  before_action :set_exchange, only: [:show, :update, :destroy]

  # GET /exchanges
  # GET /exchanges.json
  def index
    opts = { activated: false }
    @exchanges = paginate(Student.unscoped.where(opts))
  end

  # GET /exchanges/1
  # GET /exchanges/1.json
  def show
  end

  # POST /exchanges
  # POST /exchanges.json
  def create
    @exchange = Student.new(exchange_params)

    if @exchange.save
      render :show, status: :created, location: @exchange
    else
      render json: @exchange.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /exchanges/1
  # PATCH/PUT /exchanges/1.json
  def update
    if @exchange.update(exchange_params)
      render :show, status: :ok, location: @exchange
    else
      render json: @exchange.errors, status: :unprocessable_entity
    end
  end

  # DELETE /exchanges/1
  # DELETE /exchanges/1.json
  def destroy
    @exchange.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exchange
      begin
        @exchange = Student.unscoped.find(params[:id])
      rescue StandardError
        @exchange = Student.unscoped.find_by(sno: params[:id])
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def exchange_params
      params.fetch(:exchange, {})
    end
end
