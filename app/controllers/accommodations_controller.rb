class AccommodationsController < ApplicationController

  def index
    @houses = House.all
  end

end
