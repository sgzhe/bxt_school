class CollegesController < ApplicationController
  before_action :set_college, only: [:show, :update, :destroy]

  # GET /colleges
  def index
    @colleges = College.all

    render json: @colleges
  end

  # GET /colleges/1
  def show
    render json: @college
  end

  # POST /colleges
  def create
    @college = College.new(college_params)

    if @college.save
      render json: @college, status: :created, location: @college
    else
      render json: @college.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /colleges/1
  def update
    if @college.update(college_params)
      render json: @college
    else
      render json: @college.errors, status: :unprocessable_entity
    end
  end

  # DELETE /colleges/1
  def destroy
    @college.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_college
      @college = College.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def college_params
      params.fetch(:college, {})
    end
end
