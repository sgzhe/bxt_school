class PackagesController < ApplicationController
  before_action :set_package, only: [:show, :update, :destroy]

  # GET /packages
  # GET /packages.json
  def index
    @packages = paginate(Package.all)
  end

  # GET /packages/1
  # GET /packages/1.json
  def show
  end

  # POST /packages
  # POST /packages.json
  def create
    @package = Package.new(package_params)

    if @package.save
      render :show, status: :created, location: @package
    else
      render json: @package.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /packages/1
  # PATCH/PUT /packages/1.json
  def update
    if @package.update(package_params)
      render :show, status: :ok, location: @package
    else
      render json: @package.errors, status: :unprocessable_entity
    end
  end

  # DELETE /packages/1
  # DELETE /packages/1.json
  def destroy
    @package.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_package
      @package = Package.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def package_params
      params.require(:package).permit!
    end
end
