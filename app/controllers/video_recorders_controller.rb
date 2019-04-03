class VideoRecordersController < ApplicationController
  before_action :set_video_recorder, only: [:show, :update, :destroy]

  # GET /video_recorders
  # GET /video_recorders.json
  def index
    @video_recorders = paginate(VideoRecorder.all)
  end

  # GET /video_recorders/1
  # GET /video_recorders/1.json
  def show
  end

  # POST /video_recorders
  # POST /video_recorders.json
  def create
    @video_recorder = VideoRecorder.new(video_recorder_params)

    if @video_recorder.save
      render :show, status: :created, location: @video_recorder
    else
      render json: @video_recorder.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /video_recorders/1
  # PATCH/PUT /video_recorders/1.json
  def update
    if @video_recorder.update(video_recorder_params)
      render :show, status: :ok, location: @video_recorder
    else
      render json: @video_recorder.errors, status: :unprocessable_entity
    end
  end

  # DELETE /video_recorders/1
  # DELETE /video_recorders/1.json
  def destroy
    @video_recorder.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_video_recorder
      @video_recorder = VideoRecorder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def video_recorder_params
      params.fetch(:video_recorder, {})
    end
end
