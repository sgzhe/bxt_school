class FaceAccessesController < ApplicationController
  before_action :set_access, only: [:show, :update, :destroy]

  # GET /accesses
  # GET /accesses.json
  def index
    parent_id = params[:facility_id]
    opts = {
        parent_ids: parent_id && BSON::ObjectId(parent_id)
    }.delete_if {|key, value| value.blank?}
    opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?
    @face_accesses = paginate(FaceAccess.where(opts))
  end

  # GET /accesses/1
  # GET /accesses/1.json
  def show
  end

  # POST /accesses
  # POST /accesses.json
  def create
    @face_access = FaceAccess.new(access_params)

    if @face_access.save
      render :show, status: :created, location: @face_access
    else
      render json: @face_access.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /accesses/1
  # PATCH/PUT /accesses/1.json
  def update
    if @face_access.update(access_params)
      render :show, status: :ok, location: @face_access
    else
      render json: @face_access.errors, status: :unprocessable_entity
    end
  end

  # DELETE /accesses/1
  # DELETE /accesses/1.json
  def destroy
    @face_access.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_access
    unless params[:ip].blank?
      @face_access = FaceAccess.find_by(ip: params[:ip])
    else   
      @face_access = FaceAccess.find(params[:id])
    end 

  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def access_params
    params.fetch(:face_access, {}).permit!
  end
end
