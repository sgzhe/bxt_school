class IncomingsController < ApplicationController

  # GET /incomings
  # GET /incomings.json
  def index
    @users = paginate(Student.order_by(pass_time_at_last: -1).all)
  end

end
