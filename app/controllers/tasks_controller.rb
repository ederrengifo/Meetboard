require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'
require 'fileutils'
require 'googleauth'

class TasksController < ApplicationController
    before_action :set_event, only: [:create, :update]

    def create  
        set_event
        @task = @event.tasks.create(task_params)
        redirect_to @event
    end

    def edit
    end

    def update 
        @task = @event.tasks.find(params[:id])
        respond_to do |format|
            if @task.update(task_params) 
                format.html { redirect_back fallback_location: @event }
                format.json { render :show, status: :ok, location: @event }
            else
                # Error messages
            end
        end
    end

    def destroy
        set_event
        @task = @event.tasks.find(params[:id])
        @task.destroy
        redirect_back fallback_location: @event
    end

    private

    def set_event
        @event = Event.find(params[:event_id])
    end

    def task_params
        params.require(:task).permit(:title, :completed)
    end


end