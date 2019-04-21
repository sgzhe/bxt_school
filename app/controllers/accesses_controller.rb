class AccessesController < ApplicationController
  before_action :set_access, only: [:show, :update, :destroy]

  # GET /accesses
  # GET /accesses.json
  def index
    @accesses = paginate(Access.all)
  end

  # GET /accesses/1
  # GET /accesses/1.json
  def show
  end

  # POST /accesses
  # POST /accesses.json
  def create
    @access = Access.new(access_params)

    if @access.save
      render :show, status: :created, location: @access
    else
      render json: @access.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accesses/1
  # PATCH/PUT /accesses/1.json
  def update
    if @access.update(access_params)
      render :show, status: :ok, location: @access
    else
      render json: @access.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accesses/1
  # DELETE /accesses/1.json
  def destroy
    @access.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_access
      @access = Access.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def access_params
      params.fetch(:access, {}).permit!
    end
end
