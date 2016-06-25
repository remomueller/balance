# frozen_string_literal: true

namespace :data do
  desc 'Export data to CSV'
  task export: :environment do
    Export.launch_export!
  end
end
