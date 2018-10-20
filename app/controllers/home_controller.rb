require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'
require 'fileutils'
require 'googleauth'

class HomeController < ApplicationController

  def index
    unless signed_in?
      redirect_to new_session_path
    end
    # @calendars = get_calendar(current_user)
  end
  
  private

  def google_secret(user)
    Google::APIClient::ClientSecrets.new(
      { "web" =>
        { "access_token" => user.google_token,
          "refresh_token" => user.google_refresh_token,
          "client_id" => Rails.application.secrets.google_client_id,
          "client_secret" => Rails.application.secrets.google_client_secret,
        }
      }
    )
  end

  def get_calendar(user)
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = google_secret(user).to_authorization
    # service.authorization.refresh!
    
    event_list = service.list_events('primary',
                                      single_events: true, 
                                      order_by: 'startTime', 
                                      max_results: 20,
                                      time_min: Time.now.iso8601,).items

  end
end
