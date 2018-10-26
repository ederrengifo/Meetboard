# TEST!

require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'
require 'fileutils'
require 'googleauth'

class EventsController < ApplicationController
  # before_action :set_event
  before_action :set_event, only: [:show]

  def index
    if current_user.present? 
      set_calendar
      # Creating a new event for each item of the event_list is being called
      @calendars.each do |google_event|
        event = Event.find_by(gid: google_event.id)
        # Creating a new element only if this doesn't exist
        if event.present?
          # TODO : Add instructions to update existing events
        else
          new_event = Event.new
          new_event.gid = google_event.id
          new_event.title = google_event.summary
          new_event.description = google_event.description
          new_event.hangout_link = google_event.hangout_link
          new_event.starts = google_event.start.date_time
          new_event.ends = google_event.end.date_time
          new_event.save!
        end
      end
    end
    @events = Event.all
  end
  
  def show
    set_calendar
  end

  def set_calendar
    @calendars = get_calendar(current_user).to_a
    @calendar_days = @calendars.group_by {|e| e.start.date_time.strftime("%Y-%m-%d").to_time}
    @today = Time.now.strftime("%Y-%m-%d").to_time
    @tomorrow = Time.now.tomorrow.strftime("%Y-%m-%d").to_time

    @calendars.each do |google_event_link|
      @event_link = Event.find_by(gid: google_event_link.id)
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

    def set_event
      @event = Event.find(params[:id])
    end

    def event_params
      params.require(:event).permit(:gid, :title, :description, :hangout_link)
    end

end
