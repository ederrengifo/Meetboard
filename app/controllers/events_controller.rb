require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'
require 'fileutils'
require 'googleauth'

class EventsController < ApplicationController
  before_action :require_login
  before_action :set_event, only: [:show, :update, :set_calendar]

  def index
    set_calendar
  end
  
  def show
    set_calendar
  end

  def set_calendar
    from_google
    update_from_google
    set_tasks
    calculate_time
  end

  # Set events directly from Google Calendar API
  def from_google
    @calendars = get_calendar(current_user).to_a
    @calendar_days = @calendars.group_by {|e| 
      if e.start.date_time != nil 
        e.start.date_time.strftime("%Y-%m-%d").to_time
      end
    }
    @today = Time.now.strftime("%Y-%m-%d").to_time
    @tomorrow = Time.now.tomorrow.strftime("%Y-%m-%d").to_time
  end

  # Create events and ateendees from Calendar List
  def update_from_google
    @calendars.each do |google_event|
      event = Event.find_by(gid: google_event.id)
      # Update existing event with updated Calendar info
      if event.present?
        event.title = google_event.summary
        event.description = google_event.description
        event.hangout_link = google_event.hangout_link
        event.starts = google_event.start.date_time
        event.ends = google_event.end.date_time
        if google_event.organizer.display_name == nil 
          event.creator = google_event.organizer.email
        else
          event.creator = google_event.organizer.display_name
        end
        event.location = google_event.location
        google_category = google_event.summary.downcase
        if ["1:1", "1-to-1", "one-to-one"].include? google_category
          event.category = "1:1"
        elsif ["standup", "stand-up", "stand up", "check-in", "check in"].include? google_category 
          event.category = "check-in"
        else
          event.category = "general"
        end
        event.save!
        # Update attendees list
        if google_event.attendees != nil
          google_event.attendees.each do |google_attendee|
            attendee = Attendee.find_by(email: google_attendee.email, event_id: google_event.id)
            if attendee.present?
              attendee.email = google_attendee.email
              attendee.name = google_attendee.display_name
              attendee.response = google_attendee.response_status
              attendee.save!
            else
              new_attendee = Attendee.new
              new_attendee.event_id = google_event.id
              new_attendee.gid = google_attendee.id
              new_attendee.email = google_attendee.email
              new_attendee.name = google_attendee.display_name
              new_attendee.organizer = google_attendee.organizer
              new_attendee.response = google_attendee.response_status
              new_attendee.save!
            end
          end
        end
      # Create a new event in case this doesn't exist yet
      else
        if google_event.start.date_time != nil
          new_event = current_user.events.new
          new_event.gid = google_event.id
          new_event.title = google_event.summary
          new_event.description = google_event.description
          new_event.hangout_link = google_event.hangout_link
          new_event.starts = google_event.start.date_time
          new_event.ends = google_event.end.date_time
          if google_event.organizer.display_name == nil
            new_event.creator = google_event.organizer.email
          else
            new_event.creator = google_event.organizer.display_name
          end
          new_event.location = google_event.location
          google_category = google_event.summary.downcase
          if ["1:1", "1-to-1", "one-to-one"].include? google_category
            new_event.category = "1:1 meeting"
          elsif ["standup", "stand-up", "stand up", "check-in", "check in"].include? google_category
            new_event.category = "Check-in / Stand-up"
          else
            new_event.category = "General"
          end
          new_event.save!
        end
        # Create attendees list
        if google_event.attendees != nil
          google_event.attendees.each do |google_attendee|
            new_attendee = Attendee.new
            new_attendee.event_id = google_event.id
            new_attendee.gid = google_attendee.id
            new_attendee.email = google_attendee.email
            new_attendee.name = google_attendee.display_name
            new_attendee.organizer = google_attendee.organizer
            new_attendee.response = google_attendee.response_status
            new_attendee.save!
          end
        end
      end
    end
  end
  # Create methods for display tasks from events
  def set_tasks
    @events = current_user.events.all
    @tasks = current_user.tasks.all
    @task_grouping = @tasks.group_by {|t| t.event_id }
    @attendees = current_user.attendees.all
    if @event.present?
      @attendee_grouping = @event.attendees.order("response ASC").group_by {|a| a.response }
    end
      
    @latest_events = @events.order("starts DESC").first(60)

    @events.each do |event|
      task = Task.find_by(event_id: event.gid)
      if task.present?
        task.event_title = event.title
        task.save!
      end
    end
  end
  # Calculate meeting time lapse
  def calculate_time
    if @event.present? && @event.ends != nil
      event_time = @event.ends - @event.starts
      
      if event_time < 3600
        difference = ((event_time / 60) % 60)
        @event_difference = "#{difference.round(0)} minutes"
      else
        difference = event_time / (60 * 60)
        if difference == 1 
          @event_difference = "#{difference.round(0)} hour"
        else
          @event_difference = "#{difference.round(1)} hours"
        end
      end
    end
  end

  def update 
    @event = Event.find_by_gid(params[:id])
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Changes saved' }
        format.json { render :show, status: :ok, location: @event }
      else
        # Error messages
      end
    end
  end

  def destroy
    @event = Event.find_by_gid(params[:id])
    @event.destroy
    redirect_to root_path
  end

  def update_theme
    set_event
    user = current_user
    if user.theme == "dark"
      user.theme = "snow"
      user.save!
    elsif user.theme == "snow"
      user.theme = "dark"
      user.save!
    end
    redirect_back fallback_location: root_path
  end

  private

    def google_secret(user)
      Google::APIClient::ClientSecrets.new(
        { "web" =>
          { 
            "access_token" => user.google_token,
            "refresh_token" => user.google_refresh_token,
            "client_id" => ENV["GOOGLE_CLIENT_ID"],
            "client_secret" => ENV["GOOGLE_CLIENT_SECRET"],
            "auth_uri" => "https://accounts.google.com/o/oauth2/auth",
            "token_uri" => "https://accounts.google.com/o/oauth2/token",
            "scope" => Google::Apis::CalendarV3::AUTH_CALENDAR,
            "redirect_uris" => ["https://meetboard.herokuapp.com/auth/google_oauth2/callback"]
          }
        }
      )
    end

    def get_calendar(user)  
      service = Google::Apis::CalendarV3::CalendarService.new
      service.authorization = google_secret(user).to_authorization
      service.authorization.refresh!
      
      event_list = service.list_events('primary',
                                        single_events: true, 
                                        order_by: 'startTime', 
                                        max_results: 20,
                                        time_min: Time.now.iso8601,).items      
      
    end

    def set_event
      @event = Event.find_by_gid(params[:id])
    end

    def event_params
      params.require(:event).permit(:gid, :title, :description, :hangout_link, :note, :type)
    end

end
