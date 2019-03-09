class MenuItemsController < ApplicationController
  before_action :set_menu_item, only: [:show, :update, :destroy]

  # GET /menu_items
  # GET /menu_items.json
  def index
    @menu_items = MenuItem.traverse {|mi| mi}
  end

  # GET /menu_items/1
  # GET /menu_items/1.json
  def show
  end

  # POST /menu_items
  # POST /menu_items.json
  def create
    @menu_item = MenuItem.new(menu_item_params)

    if @menu_item.save
      render :show, status: :created, location: @menu_item
    else
      render json: @menu_item.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /menu_items/1
  # PATCH/PUT /menu_items/1.json
  def update
    if @menu_item.update(menu_item_params)
      render :show, status: :ok, location: @menu_item
    else
      render json: @menu_item.errors, status: :unprocessable_entity
    end
  end

  # DELETE /menu_items/1
  # DELETE /menu_items/1.json
  def destroy
    @menu_item.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_item
      @menu_item = MenuItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_item_params
      params.fetch(:menu_item, {}).permit!
    end
end
