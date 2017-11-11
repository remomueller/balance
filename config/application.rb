# frozen_string_literal: true

require_relative "boot"

require "rails/all"

# Require the gems listed in gems.rb, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Balance
  # Tracks personal finances.
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rails time:zones" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = "Eastern Time (US & Canada)"

    # Overwrite Rails errors to use Bootstrap CSS classes
    config.action_view.field_error_proc = Proc.new do |html_tag, instance|
      "<span class=\"has-error\">#{html_tag}</span>".html_safe
    end

    # Add export module to path
    config.autoload_paths << Rails.root.join("app", "models", "export")
  end
end
