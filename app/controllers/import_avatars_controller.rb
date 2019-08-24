class ImportAvatarsController < ApplicationController
  before_action :set_import_avatar, only: [:show, :update, :destroy]

  # GET /import_avatars
  # GET /import_avatars.json
  def index
    @import_avatars = ImportAvatar.all
  end

  # GET /import_avatars/1
  # GET /import_avatars/1.json
  def show
  end

  # POST /import_avatars
  # POST /import_avatars.json
  def create
    #p request.form_data?
    #p YAML.load(request.body_stream)
    #p request.body_stream.size
    # File.open('d:/data.jpg', 'w') do |f|
    #   f.puts(request.body_stream.read)
    # end

    p import_avatar_params
    # uploaded_io = import_avatar_params
    # File.open(Rails.root.join('public', 'uploads', uploaded_io.original_filename), 'wb') do |file|
    #   file.write(uploaded_io.read)
    # end
    #
    # s = Student.find_by(sno: 'S318107024')
    # s.avatar = import_avatar_params
    # s.save
    @import_avatar = ImportAvatar.new(import_avatar_params)

    if @import_avatar.save
      render :show, status: :created, location: @import_avatar
    else
      render json: @import_avatar.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /import_avatars/1
  # PATCH/PUT /import_avatars/1.json
  def update
    if @import_avatar.update(import_avatar_params)
      render :show, status: :ok, location: @import_avatar
    else
      render json: @import_avatar.errors, status: :unprocessable_entity
    end
  end

  # DELETE /import_avatars/1
  # DELETE /import_avatars/1.json
  def destroy
    @import_avatar.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_import_avatar
      @import_avatar = ImportAvatar.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def import_avatar_params
      params.fetch(:avatar, {})
    end
end
