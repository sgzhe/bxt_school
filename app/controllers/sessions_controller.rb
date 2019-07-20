class SessionsController < ApplicationController
  # POST /sessions.json
  def create
    user = User.or({login: params[:username]}, {sno: params[:username]}).first
    if user&.authenticate(params[:password])
      payload = { user_id: user.id }
      refresh_payload = { user_id: user.id }
      session = JWTSessions::Session.new(payload: payload, refresh_payload: refresh_payload, access_exp: 10)
      tokens = session.login
      response.set_cookie(JWTSessions.refresh_cookie,
                          value: tokens[:refresh],
                          httponly: true,
                          secure: Rails.env.production?)

      render json: tokens
    else
      render json: 'Invalid user', status: :unauthorized
    end
  end

  def update
    @user = User.find_by(id: params[:id])

    if @user.update(password: params[:new_password], password_confirmation: params[:confirm_password])
      render json: {id: @user.id}, status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    session = JWTSessions::Session.new(payload: payload)
    session.flush_by_access_payload
    render json: :ok
  end

end
