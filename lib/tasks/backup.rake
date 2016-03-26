# frozen_string_literal: true

namespace :backup do
  desc 'Import a CSV backup'
  task import: :environment do
    if folder.blank?
      puts "Please specify a folder, ex:\n" +
           '  bundle exec rake backup:import FOLDER=20160320173700'.colorize(:blue)
      next
    elsif !File.exist? data_folder
      puts 'Folder ' + data_folder.to_s.colorize(:red) + ' does not exist.'
      next
    else
      puts 'Folder ' + data_folder.to_s.colorize(:green)
    end
    import_users
    import_accounts
    import_charge_types
    import_entries
    import_templates
    import_template_items
  end

  def import_users
    object = 'users'
    csv_file = file_base(object)
    ActiveRecord::Base.connection.execute("TRUNCATE #{object} RESTART IDENTITY")
    CSV.parse(File.open(csv_file, 'r:iso-8859-1:utf-8') { |f| f.read }, headers: true) do |line|
      User.create(
        id: line['User ID'],
        first_name: line['First Name'],
        last_name: line['Last Name'],
        email: line['Email'],
        password: "#{folder}-#{SecureRandom.hex(8)}",
        deleted: (line['Deleted'] == 'true')
      )
    end
    restart_sequence(object)
    puts 'imported ' + "#{User.count} user#{'s' if User.count != 1}".colorize(:green)
  end

  def import_accounts
    object = 'accounts'
    csv_file = file_base(object)
    ActiveRecord::Base.connection.execute("TRUNCATE #{object} RESTART IDENTITY")
    CSV.parse(File.open(csv_file, 'r:iso-8859-1:utf-8') { |f| f.read }, headers: true) do |line|
      Account.create(
        id: line['Account ID'],
        user_id: line['User ID'],
        name: line['Name'],
        deleted: (line['Deleted'] == 'true')
      )
    end
    restart_sequence(object)
    puts 'imported ' + "#{Account.count} account#{'s' if Account.count != 1}".colorize(:green)
  end

  def import_charge_types
    object = 'charge_types'
    csv_file = file_base(object)
    ActiveRecord::Base.connection.execute("TRUNCATE #{object} RESTART IDENTITY")
    CSV.parse(File.open(csv_file, 'r:iso-8859-1:utf-8') { |f| f.read }, headers: true) do |line|
      ChargeType.create(
        id: line['Charge Type ID'],
        name: line['Name'],
        account_id: line['Account ID'],
        counts_towards_spending: line['Counts Towards Spending'],
        deleted: (line['Deleted'] == 'true')
      )
    end
    restart_sequence(object)
    puts 'imported ' + "#{ChargeType.count} charge type#{'s' if ChargeType.count != 1}".colorize(:green)
  end

  def import_entries
    object = 'entries'
    csv_file = file_base(object)
    ActiveRecord::Base.connection.execute("TRUNCATE #{object} RESTART IDENTITY")
    CSV.parse(File.open(csv_file, 'r:iso-8859-1:utf-8') { |f| f.read }, headers: true) do |line|
      Entry.create(
        id: line['Entry ID'],
        user_id: line['User ID'],
        charge_type_id: line['Charge Type ID'],
        name: line['Name'],
        billing_date: line['Billing Date'],
        amount: line['Amount'],
        description: line['Description'],
        charged: (line['Charged'] == 'true'),
        deleted: (line['Deleted'] == 'true')
      )
    end
    restart_sequence(object)
    puts 'imported ' + "#{Entry.count} #{Entry.count == 1 ? 'entry' : 'entries'}".colorize(:green)
  end

  def import_templates
    object = 'templates'
    csv_file = file_base(object)
    ActiveRecord::Base.connection.execute("TRUNCATE #{object} RESTART IDENTITY")
    CSV.parse(File.open(csv_file, 'r:iso-8859-1:utf-8') { |f| f.read }, headers: true) do |line|
      Template.create(
        id: line['Template ID'],
        name: line['Name'],
        user_id: line['User ID'],
        deleted: (line['Deleted'] == 'true')
      )
    end
    restart_sequence(object)
    puts 'imported ' + "#{Template.count} template#{'s' if Template.count != 1}".colorize(:green)
  end

  def import_template_items
    object = 'template_items'
    csv_file = file_base(object)
    ActiveRecord::Base.connection.execute("TRUNCATE #{object} RESTART IDENTITY")
    CSV.parse(File.open(csv_file, 'r:iso-8859-1:utf-8') { |f| f.read }, headers: true) do |line|
      TemplateItem.create(
        id: line['Template Item ID'].to_i,
        name: line['Name'],
        charge_type_id: line['Charge Type ID'],
        amount: line['Amount'],
        description: line['Description'],
        template_id: line['Template ID'],
        position: line['Position']
      )
    end
    restart_sequence(object)
    puts 'imported ' + "#{TemplateItem.count} template item#{'s' if TemplateItem.count != 1}".colorize(:green)
  end

  def folder
    @folder ||= begin
      folder_arg = ARGV.find { |arg| /^FOLDER=/ =~ arg }
      folder_arg.to_s.gsub('FOLDER=', '')
    end
  end

  def file_base(object)
    File.join data_folder, "#{object}.csv"
  end

  def data_folder
    Rails.root.join 'tmp', 'data', folder
  end

  def restart_sequence(object)
    ActiveRecord::Base.connection.execute(
      "SELECT setval('#{object}_id_seq', (SELECT MAX(id) FROM #{object}));"
    )
  end
end
