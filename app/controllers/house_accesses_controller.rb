class HouseAccessesController < ApplicationController

  # GET /house_accesses
  # GET /house_accesses.json
  def index
    @house_accesses = HouseAccess.all
  end

end
