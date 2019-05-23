class DoorsController < ApplicationController
  before_action :set_door, only: [:show, :update, :destroy]

  # GET /doors
  # GET /doors.json
  def index
    @doors = Door.all
  end

  # GET /doors/1
  # GET /doors/1.json
  def show
  end

  # POST /doors
  # POST /doors.json
  def create
    @door = Door.new(door_params)

    if @door.save
      render :show, status: :created, location: @door
    else
      render json: @door.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /doors/1
  # PATCH/PUT /doors/1.json
  def update
    if @door.update(door_params)
      render :show, status: :ok, location: @door
    else
      render json: @door.errors, status: :unprocessable_entity
    end
  end

  # DELETE /doors/1
  # DELETE /doors/1.json
  def destroy
    @door.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_door
      @door = Door.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def door_params
      params.require(:door).permit(:title)
    end
end
