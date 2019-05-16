class FloorsController < ApplicationController
  before_action :set_floor, only: [:show, :update, :destroy]

  # GET /floors
  # GET /floors.json
  def index
    parent_id = params[:house_id]
    opts = { parent_ids: parent_id && BSON::ObjectId(parent_id), floor_mark: params[:floor_mark]}.delete_if {|key, value| value.blank?}
    opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?

    @floors = paginate(Floor.includes(:house).where(opts))
  end

  # GET /floors/1
  # GET /floors/1.json
  def show
  end

  # POST /floors
  # POST /floors.json
  def create
    @floor = Floor.new(floor_params)

    if @floor.save
      render :show, status: :created, location: @floor
    else
      render json: @floor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /floors/1
  # PATCH/PUT /floors/1.json
  def update
    if @floor.update(floor_params)
      render :show, status: :ok, location: @floor
    else
      render json: @floor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /floors/1
  # DELETE /floors/1.json
  def destroy
    @floor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_floor
      @floor = Floor.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def floor_params
      params.fetch(:floor, {}).permit!
    end
end
