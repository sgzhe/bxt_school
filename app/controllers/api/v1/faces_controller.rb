class Api::V1::FacesController < ApplicationController
  before_action :set_api_v1_face, only: [:show, :update, :destroy]

  # GET /api/v1/faces
  # GET /api/v1/faces.json
  def index
    @api_v1_faces = paginate(Student.where(access_status: nil))
  end

  # GET /api/v1/faces/1
  # GET /api/v1/faces/1.json
  def show
  end

  # POST /api/v1/faces
  # POST /api/v1/faces.json
  def create
    @api_v1_face = Api::V1::Face.new(api_v1_face_params)

    if @api_v1_face.save
      render :show, status: :created, location: @api_v1_face
    else
      render json: @api_v1_face.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/faces/1
  # PATCH/PUT /api/v1/faces/1.json
  def update
    if @api_v1_face.update(api_v1_face_params)
      render :show, status: :ok, location: @api_v1_face
    else
      render json: @api_v1_face.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/faces/1
  # DELETE /api/v1/faces/1.json
  def destroy
    @api_v1_face.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_api_v1_face
      @api_v1_face = Api::V1::Face.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def api_v1_face_params
      params.fetch(:api_v1_face, {})
    end
end
