class RefreshsController < ApplicationController
  before_action :authorize_refresh_request!

  def create
    tokens = JWTSessions::Session.new(payload: access_payload).refresh(found_token)
    render json: tokens
  end

  def access_payload
    user = User.find_by!(id: payload["user_id"])
    { user_id: user.id }
  end
end
