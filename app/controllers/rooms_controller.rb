class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :update, :destroy]

  # GET /rooms
  # GET /rooms.json
  def index
    parent_id = params[:parent_id] || params[:facility_id] || params[:floor_id] || params[:house_id]
    opts = { parent_ids: parent_id && BSON::ObjectId(parent_id)}.delete_if {|key, value| value.blank?}
    opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?

    @rooms = paginate(Room.where(opts))
    match = { parent_ids: parent_id && BSON::ObjectId(parent_id) }.delete_if { |key, value| value.blank? }
    @bed_stats = Room.bed_stats(match)

  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    if @room.save
      render :show, status: :created, location: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    if @room.update(room_params)
      render :show, status: :ok, location: @room
    else
      render json: @room.errors, status: :unprocessable_entity
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_room
    @room = Room.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def room_params
    params.fetch(:room, {}).permit(:id, :parent_id, :title, :desc, :mark, :seq, :dorm_type, :dorm_toward, beds: [:id, :mark, :desc, :owner_id, :owner_name])
  end
end
