class DeletedFlags < ActiveRecord::Migration[4.2]
  def change
    add_column :accounts, :deleted, :boolean, null: false, default: false
    add_column :charge_types, :deleted, :boolean, null: false, default: false
    add_column :entries, :deleted, :boolean, null: false, default: false
    add_column :users, :deleted, :boolean, null: false, default: false
  end
end
