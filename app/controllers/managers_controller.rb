class ManagersController < ApplicationController
  before_action :set_manager, only: [:show, :update, :destroy]

  # GET /managers
  # GET /managers.json
  def index
    @managers = Manager.all
  end

  # GET /managers/1
  # GET /managers/1.json
  def show
  end

  # POST /managers
  # POST /managers.json
  def create
    @manager = Manager.new(manager_params)

    if @manager.save
      render :show, status: :created, location: @manager
    else
      render json: @manager.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /managers/1
  # PATCH/PUT /managers/1.json
  def update
    if @manager.update(manager_params)
      render :show, status: :ok, location: @manager
    else
      render json: @manager.errors, status: :unprocessable_entity
    end
  end

  # DELETE /managers/1
  # DELETE /managers/1.json
  def destroy
    @manager.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_manager
      @manager = Manager.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def manager_params
      params.fetch(:manager, {})
    end
end
