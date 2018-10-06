require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'

class EventsController < ApplicationController

  private

  def google_secret
    Google::APIClient::ClientSecrets.new(
      { "web" =>
        { "access_token" => @user.google_token,
          "refresh_token" => @user.google_refresh_token,
          "client_id" => Rails.application.secrets.google_client_id,
          "client_secret" => Rails.application.secrets.google_client_secret,
        }
      }
    )
  end

  def get_calendars
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = google_secret.to_authorization
    service.authorization.refresh!

    calendar_list = service.list_calendar_lists.items
    calendar_list.each do |calendar|
    puts calendar
  end

end
