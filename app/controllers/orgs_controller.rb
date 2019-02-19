class OrgsController < ApplicationController
  before_action :set_org, only: [:show, :update, :destroy]

  # GET /orgs
  # GET /orgs.json
  def index
    @orgs = Org.traverse do |org|
      org
    end
  end

  # GET /orgs/1
  # GET /orgs/1.json
  def show
  end

  # POST /orgs
  # POST /orgs.json
  def create
    @org = Org.new(org_params)

    if @org.save
      render :show, status: :created, location: @org
    else
      render json: @org.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /orgs/1
  # PATCH/PUT /orgs/1.json
  def update
    if @org.update(org_params)
      render :show, status: :ok, location: @org
    else
      render json: @org.errors, status: :unprocessable_entity
    end
  end

  # DELETE /orgs/1
  # DELETE /orgs/1.json
  def destroy
    @org.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_org
      @org = Org.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def org_params
      params.fetch(:org, {})
    end
end
