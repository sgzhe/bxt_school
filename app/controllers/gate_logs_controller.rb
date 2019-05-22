class GateLogsController < ApplicationController
  before_action :set_gate_log, only: [:show, :update, :destroy]

  # GET /gate_logs
  # GET /gate_logs.json
  def index
    @gate_logs = paginate(GateLog.all)
  end

  # GET /gate_logs/1
  # GET /gate_logs/1.json
  def show
  end

  # POST /gate_logs
  # POST /gate_logs.json
  def create
    @gate_log = GateLog.new(gate_log_params)

    if @gate_log.save
      render :show, status: :created, location: @gate_log
    else
      render json: @gate_log.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gate_logs/1
  # PATCH/PUT /gate_logs/1.json
  def update
    if @gate_log.update(gate_log_params)
      render :show, status: :ok, location: @gate_log
    else
      render json: @gate_log.errors, status: :unprocessable_entity
    end
  end

  # DELETE /gate_logs/1
  # DELETE /gate_logs/1.json
  def destroy
    @gate_log.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gate_log
      @gate_log = GateLog.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gate_log_params
      params.fetch(:gate_log, {}).permit!
    end
end
