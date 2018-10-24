require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'
require 'fileutils'
require 'googleauth'

class CalendarsController < ApplicationController

  def show
    # Showing calendars when current user is logged
    if current_user.present? 
      @calendars = get_calendar(current_user).to_a
      @calendar_days = @calendars.group_by {|e| e.start.date_time.strftime("%Y-%m-%d").to_time}
      @today = Time.now.strftime("%Y-%m-%d").to_time
      @tomorrow = Time.now.tomorrow.strftime("%Y-%m-%d").to_time

      # Creating a new event for each item of the event_list is being called
      @calendars.each do |google_event|
        event = Event.find_by(gid: google_event.id)

        # Creating a new element only if this doesn't exist
        if event.present?
        else
          new_event = Event.new
          new_event.gid = google_event.id
          new_event.title = google_event.summary
          new_event.description = google_event.description
          new_event.hangout_link = google_event.hangout_link
          new_event.save!
        end
      end

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