class ReportsController < ApplicationController
    before_action :set_event, only: [:show, :download]

    def show
        set_event
    end

    def download
        set_event
    end

    private

    def set_event
        @event = Event.find(params[:event_id])
    end

    def report_params
        params.require(:report).permit(:title)
    end

end