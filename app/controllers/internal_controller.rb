# frozen_string_literal: true

# Tasks for logged in user.
class InternalController < ApplicationController
  before_action :authenticate_user!

  # GET /backup
  def backup
  end

  # POST /generate_backup
  def generate_backup
    if Rails.env.test?
      redirect_to backup_succeeded_path
    else
      if Export.launch_export!
        redirect_to backup_succeeded_path
      else
        redirect_to backup_failed_path
      end
    end
  end
end
