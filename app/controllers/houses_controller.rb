class HousesController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_house, only: [:show, :update, :destroy]

  # GET /houses
  # GET /houses.json
  def index
    opts = {
    }.delete_if { |key, value| value.blank? }
    opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?

    @houses = House.where(opts).select do |house|
      current_user.allow?(house.id, :view)
    end
    @houses = paginate(Kaminari.paginate_array(@houses))
  end

  # GET /houses/1
  # GET /houses/1.json
  def show
  end

  # POST /houses
  # POST /houses.json
  def create
    @house = House.new(house_params)

    if @house.save
      render :show, status: :created, location: @house
    else
      render json: @house.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /houses/1
  # PATCH/PUT /houses/1.json
  def update
    if @house.update(house_params)
      render :show, status: :ok, location: @house
    else
      render json: @house.errors, status: :unprocessable_entity
    end
  end

  # DELETE /houses/1
  # DELETE /houses/1.json
  def destroy
    @house.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_house
    @house = House.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def house_params
    params.fetch(:house, {}).permit!
  end
end
