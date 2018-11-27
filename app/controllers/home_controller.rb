require 'google/api_client/client_secrets.rb'
require 'google/apis/calendar_v3'
require 'fileutils'
require 'googleauth'

class HomeController < ApplicationController

  def show
    if current_user
      redirect_to events_path
    end
  end


end
