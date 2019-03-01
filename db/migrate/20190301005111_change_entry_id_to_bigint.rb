class ChangeEntryIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :entries, :id, :bigint

    change_column :users, :last_backup_entry_id, :bigint
  end

  def down
    change_column :entries, :id, :integer

    change_column :users, :last_backup_entry_id, :integer
  end
end
