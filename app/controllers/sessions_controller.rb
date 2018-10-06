class SessionsController < ApplicationController
  def create
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    # log_in(user)
    session[:user_id] = user.id

    user.google_token = access_token.credentials.token
    refresh_token = access_token.credentials.refresh_token
    user.google_refresh_token = refresh_token if refresh_token.present?
    user.save
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

end
