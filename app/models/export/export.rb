# frozen_string_literal: true

# Handles exporting user data.
module Export
  def self.launch_export!
    @time = Time.zone.now.strftime('%Y%m%d%H%M%S')
    create_data_folder
    export_users
    export_accounts
    export_charge_types
    export_entries
    export_templates
    export_template_items

    # zip -er
    FileUtils.cd(Rails.root.join('tmp', 'data'))
    `zip #{"-P #{ENV['backup_secret']}" if ENV['backup_secret'].present?} -r #{@time}.zip #{@time}`
    FileUtils.mv("#{@time}.zip", ENV['backup_location']) if ENV['backup_location'].present?
    true
  rescue
    false
  end

  def self.create_data_folder
    puts 'create'.green + ' ' + data_folder.to_s
    FileUtils.mkdir_p data_folder
  end

  def self.export_users
    object = 'users'
    puts 'export '.blue + object
    csv_file = file_base(object)
    CSV.open(csv_file, 'wb') do |csv|
      csv << ['User ID', 'First Name', 'Last Name', 'Email', 'Deleted']
      User.order(:id).each do |user|
        csv << [
          user.id,
          user.first_name,
          user.last_name,
          user.email,
          user.deleted
        ]
      end
    end
  end

  def self.export_accounts
    object = 'accounts'
    puts 'export '.blue + object
    csv_file = file_base(object)
    CSV.open(csv_file, 'wb') do |csv|
      csv << ['Account ID', 'User ID', 'Name', 'Category', 'Archived', 'Deleted']
      Account.order(:id).each do |account|
        csv << [
          account.id,
          account.user_id,
          account.name,
          account.category,
          account.archived,
          account.deleted
        ]
      end
    end
  end

  def self.export_charge_types
    object = 'charge_types'
    puts 'export '.blue + object
    csv_file = file_base(object)
    CSV.open(csv_file, 'wb') do |csv|
      csv << ['Charge Type ID', 'Name', 'Account ID', 'Counts Towards Spending', 'Deleted']
      ChargeType.order(:id).each do |charge_type|
        csv << [
          charge_type.id,
          charge_type.name,
          charge_type.account_id,
          charge_type.counts_towards_spending,
          charge_type.deleted
        ]
      end
    end
  end

  def self.export_entries
    object = 'entries'
    puts 'export '.blue + object
    csv_file = file_base(object)
    CSV.open(csv_file, 'wb') do |csv|
      csv << ['Entry ID', 'User ID', 'Charge Type ID', 'Name', 'Billing Date', 'Amount', 'Description', 'Charged', 'Deleted']
      Entry.order(:id).each do |entry|
        csv << [
          entry.id,
          entry.user_id,
          entry.charge_type_id,
          entry.name,
          entry.billing_date,
          entry.amount,
          entry.description,
          entry.charged,
          entry.deleted
        ]
      end
    end
  end

  def self.export_templates
    object = 'templates'
    puts 'export '.blue + object
    csv_file = file_base(object)
    CSV.open(csv_file, 'wb') do |csv|
      csv << ['Template ID', 'Name', 'User ID', 'Deleted']
      Template.order(:id).each do |template|
        csv << [
          template.id,
          template.name,
          template.user_id,
          template.deleted
        ]
      end
    end
  end

  def self.export_template_items
    object = 'template_items'
    puts 'export '.blue + object
    csv_file = file_base(object)
    CSV.open(csv_file, 'wb') do |csv|
      csv << ['Template Item ID', 'Name', 'Charge Type ID', 'Amount', 'Description', 'Template ID', 'Position']
      TemplateItem.order(:id).each do |template_item|
        csv << [
          template_item.id,
          template_item.name,
          template_item.charge_type_id,
          template_item.amount,
          template_item.description,
          template_item.template_id,
          template_item.position
        ]
      end
    end
  end

  def self.file_base(object)
    File.join data_folder, "#{object}.csv"
  end

  def self.data_folder
    Rails.root.join 'tmp', 'data', @time
  end
end
