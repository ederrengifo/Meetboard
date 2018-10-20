# coding: utf-8
class SessionsController < ApplicationController
  def new
  end

  # First search of an active session. That is a session for the users.email
  # that hasn´t expired and returned that.
  def create
    if session[:id].present?
      session = Session.find(session[:id])
      if sesion.expired?
        session.refresh
      end
    else
      auth = request.env["omniauth.auth"]
      safety_margin = 10.seconds
      expiration_date = DateTime.now + auth.credentials.expires_at.seconds - safety_margin
      user = User.from_oauth(auth)
      session = Session.new(token: auth.credentials.token,
                            refresh_token: auth.credentials.token,
                            expires_at: expiration_date,
                            user_id: user.id)
      session.save
      session[:id] = session.id
    end
    redirect_back fallback_location: root_path
  end

  def destroy
    session = Session.find(session[:id])
    session.destroy
    session[:id] = nil
    redirect_to root_path
  end

  def current_user
    if session[:session_id]
      @current_user ||= Session.find(session[:user_id]).user
    end
  end
end
