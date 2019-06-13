class Api::V1::FacesController < ApplicationController
  before_action :set_face, only: [:show, :update, :destroy]

  # GET /api/v1/faces
  # GET /api/v1/faces.json
  def index
    parent_id = BSON::ObjectId(params[:facility_id]) unless params[:facility_id].blank?
    opts = {
        facility_ids: parent_id
    }.delete_if {|key, value| value.blank?}
    opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?
    @faces = paginate(Student.where(opts.merge(access_status: false)))
  end

  # GET /api/v1/faces/1
  # GET /api/v1/faces/1.json
  def show
  end

  # POST /api/v1/faces
  # POST /api/v1/faces.json
  def create
    @face = Api::V1::Face.new(face_params)

    if @face.save
      render :show, status: :created, location: @face
    else
      render json: @face.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /api/v1/faces/face_id
  # PATCH/PUT /api/v1/faces/1.json
  def update
    #p face_params[:access_ips] =  
    #@face.access_ips.merge(ips)    
    if @face.update(access_ips: @face.access_ips.merge(face_params[:access_ips]))
      render :show, status: :ok, location: @face
    else
      render json: @face.errors, status: :unprocessable_entity
    end
  end

  # DELETE /api/v1/faces/1
  # DELETE /api/v1/faces/1.json
  def destroy
    @face.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_face
      @face = Student.find_by(face_id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def face_params
      params.fetch(:face, {}).permit!
    end
end
