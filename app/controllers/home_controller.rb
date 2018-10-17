require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'
require 'fileutils'
require 'googleauth'

class HomeController < ApplicationController

  def show
    if current_user.present? 
      @calendars = get_calendar(current_user)
    end
  end

  private
  
  def google_secret(user)
    Google::APIClient::ClientSecrets.new(
      { "web" =>
        { "access_token" => user.google_token,
          "refresh_token" => user.google_refresh_token,
          "client_id" => Rails.application.secrets.google_client_id,
          "client_secret" => Rails.application.secrets.google_client_secret,
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://accounts.google.com/o/oauth2/token",
        }
      }
    )
  end

  def get_calendar(user)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.client_options.application_name = "Meetboard"
    service.authorization = google_secret(user).to_authorization

    event_list = service.list_events('primary',
                                      single_events: true, 
                                      order_by: 'startTime', 
                                      max_results: 10,
                                      time_min: Time.now.iso8601).items
  end

end
