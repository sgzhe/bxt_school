class CollegesController < ApplicationController
  before_action :authorize_access_request!
  before_action :set_college, only: [:show, :update, :destroy]

  # GET /colleges
  # GET /colleges.json
  def index
    opts = {
    }.delete_if { |key, value| value.blank? }
    opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?

    @colleges = paginate(College.where(opts))
  end

  # GET /colleges/1
  # GET /colleges/1.json
  def show
  end

  # POST /colleges
  # POST /colleges.json
  def create
    @college = College.new(college_params)

    if @college.save
      render :show, status: :created, location: @college
    else
      render json: @college.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /colleges/1
  # PATCH/PUT /colleges/1.json
  def update
    if @college.update(college_params)
      render :show, status: :ok, location: @college
    else
      render json: @college.errors, status: :unprocessable_entity
    end
  end

  # DELETE /colleges/1
  # DELETE /colleges/1.json
  def destroy
    @college.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_college
      @college = College.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def college_params
      params.fetch(:college, {}).permit!
    end
end
