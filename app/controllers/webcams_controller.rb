class WebcamsController < ApplicationController
  before_action :set_webcam, only: [:show, :update, :destroy]

  # GET /webcams
  # GET /webcams.json
  def index
    parent_id = params[:facility_id]
    opts = {
        parent_ids: parent_id && BSON::ObjectId(parent_id)
    }.delete_if {|key, value| value.blank?}
    opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?
    @webcams = paginate(Webcam.where(opts))
  end

  # GET /webcams/1
  # GET /webcams/1.json
  def show
  end

  # POST /webcams
  # POST /webcams.json
  def create
    @webcam = Webcam.new(webcam_params)

    if @webcam.save
      render :show, status: :created, location: @webcam
    else
      render json: @webcam.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /webcams/1
  # PATCH/PUT /webcams/1.json
  def update
    if @webcam.update(webcam_params)
      render :show, status: :ok, location: @webcam
    else
      render json: @webcam.errors, status: :unprocessable_entity
    end
  end

  # DELETE /webcams/1
  # DELETE /webcams/1.json
  def destroy
    @webcam.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_webcam
      @webcam = Webcam.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def webcam_params
      params.fetch(:webcam, {}).permit!
    end
end
