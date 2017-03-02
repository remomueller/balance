class AddLastBackupAtToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :last_backup_at, :datetime
    add_column :users, :last_backup_entry_id, :integer, null: false, default: 0
  end
end
