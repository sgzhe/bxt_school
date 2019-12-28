class Client::DictsController < ApplicationController
  before_action :set_dict, only: [:show, :update, :destroy]

  # GET /dicts
  # GET /dicts.json
  def index
    opts = { mark: params[:dict_mark] }.delete_if { |key, value| value.blank?}
    @dicts = paginate(Dict.where(opts))
  end

  # GET /dicts/1
  # GET /dicts/1.json
  def show
  end

  # POST /dicts
  # POST /dicts.json
  def create
    @dict = Dict.new(dict_params)

    if @dict.save
      render :show, status: :created, location: @dict
    else
      render json: @dict.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /dicts/1
  # PATCH/PUT /dicts/1.json
  def update
    if @dict.update(dict_params)
      render :show, status: :ok, location: @dict
    else
      render json: @dict.errors, status: :unprocessable_entity
    end
  end

  # DELETE /dicts/1
  # DELETE /dicts/1.json
  def destroy
    @dict.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_dict
    @dict = Dict.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def dict_params
    params.fetch(:dict, {}).permit!
  end
end
