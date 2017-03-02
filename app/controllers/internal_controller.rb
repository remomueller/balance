# frozen_string_literal: true

# Tasks for logged in user.
class InternalController < ApplicationController
  before_action :authenticate_user!
  before_action :skip_backup_for_test, only: :generate_backup

  # # GET /backup
  # def backup
  # end

  # POST /generate_backup
  def generate_backup
    if Export.launch_export!
      current_user.update(
        last_backup_at: Time.zone.now,
        last_backup_entry_id: current_user.last_entry_id
      )
      redirect_to backup_succeeded_path
    else
      redirect_to backup_failed_path
    end
  end

  private

  def skip_backup_for_test
    redirect_to backup_succeeded_path if Rails.env.test?
  end
end
