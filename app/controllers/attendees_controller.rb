class AttendeesController < ApplicationController
    before_action :set_event, only: [:create, :update]

    def create  
    end

    def edit
    end

    def update 
    end

    def destroy
    end

    private

    def set_event
        @event = Event.find(params[:event_id])
    end

    def task_params
        params.require(:attendee).permit(:gid, :email, :name, :organizer, :response)
    end


end