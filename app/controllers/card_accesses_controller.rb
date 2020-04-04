class CardAccessesController < ApplicationController
  before_action :set_card_access, only: [:show, :update, :destroy]

  # GET /card_accesses
  # GET /card_accesses.json
  def index
    parent_id = params[:facility_id]
    opts = {
        parent_ids: parent_id && BSON::ObjectId(parent_id)
    }.delete_if {|key, value| value.blank?}
    opts[:title] = /.*#{params[:key]}.*/ unless params[:key].blank?
    @card_accesses = paginate(CardAccess.where(opts))
  end

  # GET /card_accesses/1
  # GET /card_accesses/1.json
  def show
  end

  # POST /card_accesses
  # POST /card_accesses.json
  def create
    @card_access = CardAccess.new(card_access_params)

    if @card_access.save
      render :show, status: :created, location: @card_access
    else
      render json: @card_access.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /card_accesses/1
  # PATCH/PUT /card_accesses/1.json
  def update
    if @card_access.update(card_access_params)
      render :show, status: :ok, location: @card_access
    else
      render json: @card_access.errors, status: :unprocessable_entity
    end
  end

  # DELETE /card_accesses/1
  # DELETE /card_accesses/1.json
  def destroy
    @card_access.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_card_access
      @card_access = CardAccess.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def card_access_params
      params.fetch(:card_access, {}).permit!
    end
end
