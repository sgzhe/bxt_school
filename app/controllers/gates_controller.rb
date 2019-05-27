class GatesController < ApplicationController
  before_action :set_gate, only: [:show, :update, :destroy]

  # GET /gates
  # GET /gates.json
  def index
    parent_id = params[:facility_id]
    opts = {
        parent_ids: parent_id && BSON::ObjectId(parent_id)
    }.delete_if {|key, value| value.blank?}
    opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?
    @gates = paginate(Gate.where(opts))
  end

  # GET /gates/1
  # GET /gates/1.json
  def show
  end

  # POST /gates
  # POST /gates.json
  def create
    @gate = Gate.new(gate_params)

    if @gate.save
      render :show, status: :created, location: @gate
    else
      render json: @gate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /gates/1
  # PATCH/PUT /gates/1.json
  def update
    if @gate.update(gate_params)
      render :show, status: :ok, location: @gate
    else
      render json: @gate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /gates/1
  # DELETE /gates/1.json
  def destroy
    @gate.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_gate
      @gate = Gate.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def gate_params
      params.fetch(:gate, {}).permit!
    end
end
