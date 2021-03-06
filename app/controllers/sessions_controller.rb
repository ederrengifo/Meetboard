require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'
require 'googleauth'

class SessionsController < ApplicationController
  
  def create
    access_token = request.env["omniauth.auth"]
    user = User.from_omniauth(access_token)
    user.google_token = access_token.credentials.token
    refresh_token = access_token.credentials.refresh_token
    user.google_refresh_token = refresh_token if refresh_token.present?
    user.save!
    session[:user_id] = user.id
    redirect_to events_path
  end

  def destroy
    reset_session
    redirect_to root_path
  end

end
