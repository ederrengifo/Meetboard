require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'
require 'fileutils'
require 'googleauth'

class EventsController < ApplicationController
  before_action :set_event, only: [:show, :update]

  def index
    set_calendar
  end
  
  def show
    set_calendar
  end

  def set_calendar
    if current_user.present? 
      # SETTING CALENDARS FROM GOOGLE + DAY VARIABLES
      @calendars = get_calendar(current_user).to_a
      @calendar_days = @calendars.group_by {|e| e.start.date_time.strftime("%Y-%m-%d").to_time}
      @today = Time.now.strftime("%Y-%m-%d").to_time
      @tomorrow = Time.now.tomorrow.strftime("%Y-%m-%d").to_time
      # UPDATING AND CREATING EVENTS FROM GOOGLE CALENDAR EVENTS
      @calendars.each do |google_event|
        event = Event.find_by(gid: google_event.id)

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
          event.save!

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
    
        else
          new_event = Event.new
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
          if google_category.include? "1:1"
            new_event.category = "One to one"
          else
            if google_category.include? "check-in"
              new_event.category = "Status Check-in"
            else
              if google_category.include? "retro"
                new_event.category = "Retrospective"
              else
                new_event.category = "General"
              end
            end
          end
          new_event.save!

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
      # SETTING EVENTS AND TASKS
      @events = Event.all
      @tasks = Task.all
      @task_grouping = @tasks.group_by {|t| t.event_id }
      @attendees = Attendee.all
      if @event.present?
        @attendee_grouping = @event.attendees.order("response ASC").group_by {|a| a.response }
      end
      

      # DIPSLAYING LATEST EVENTS
      @latest_events = @events.order("starts DESC")
     
      # CALCULATING TIME BETWEEN START AND END TIME
      if @event.present?
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
      

      # UPDATING TASK WITH EVENT NAME
      @events.each do |event|
        task = Task.find_by(event_id: event.gid)
        if task.present?
          task.event_title = event.title
          task.save!
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
                                        max_results: 30,
                                        time_min: Time.now.iso8601,).items
  
    end

    def set_event
      @event = Event.find_by_gid(params[:id])
    end

    def event_params
      params.require(:event).permit(:gid, :title, :description, :hangout_link, :note, :type)
    end

end
