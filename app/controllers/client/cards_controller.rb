class Client::CardsController < ApplicationController
  before_action :set_card, only: [:show, :update, :destroy]
  rescue_from Mongoid::Errors::DocumentNotFound, with: :rescue_document_not_found

  # GET /cards
  # GET /cards.json
  def index
    parent_id = BSON::ObjectId(params[:facility_id]) unless params[:facility_id].blank?
    house_id = BSON::ObjectId(params[:house_id]) unless params[:house_id].blank?
    opts = {
        facility_ids: parent_id || house_id,
        :status.in => [:add, :delete]
    }.delete_if {|key, value| value.blank?}
    opts[:status] = params[:status] if params[:status].present?

    @cards = paginate(Card.where(opts))
  end

  # GET /cards/1
  # GET /cards/1.json
  def show
  end

  # POST /cards
  # POST /cards.json
  def create
    @card = Card.new(card_params)

    if @card.save
      render :show, status: :created, location: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /cards/1
  # PATCH/PUT /cards/1.json
  def update
    ips = @card.card_access_ips.merge(card_params[:card_access_ips])
    @card.attributes = (card_params.merge({card_access_ips: ips}))
    if @card.save(validate: false)
      render :show, status: :ok, location: @card
    else
      render json: @card.errors, status: :unprocessable_entity
    end
  end

  # DELETE /cards/1
  # DELETE /cards/1.json
  def destroy
    @card.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_card
    @card = Card.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def card_params
    params.fetch(:card, {}).permit!
  end

  def rescue_document_not_found
    render json: 'document not found', status: :ok
  end
end
