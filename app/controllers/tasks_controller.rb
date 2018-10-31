require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'
require 'fileutils'
require 'googleauth'

class TasksController < ApplicationController

    def create  
        set_event
        @task = @event.tasks.create(task_params)
        redirect_to @event
    end

    def destroy
        set_event
        @task = @event.tasks.find(params[:id])
        @task.destroy
        redirect_to @event
    end

    private

    def set_event
        @event = Event.find(params[:event_id])
    end

    def task_params
        params.require(:task).permit(:title)
    end


end