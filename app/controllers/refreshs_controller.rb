class RefreshsController < ApplicationController
  # before_action :authorize_refresh_by_access_request!
  before_action :authorize_refresh_request!

  # def create
  #   session = JWTSessions::Session.new(payload: claimless_payload, refresh_by_access_allowed: true)
  #   tokens  = session.refresh_by_access_payload
  #   response.set_cookie(JWTSessions.access_cookie,
  #                       value: tokens[:access],
  #                       httponly: true,
  #                       secure: Rails.env.production?)
  #
  #   render json: tokens
  # end

  def create
    p access_payload
    tokens = JWTSessions::Session.new(payload: access_payload).refresh(found_token)
    render json: tokens
  end

  def access_payload
    user = User.find_by!(id: payload["user_id"])
    { user_id: user.id }
  end
end
