class AddArchivedToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :archived, :boolean, null: false, default: false
    add_index :accounts, :archived
  end
end
