class DeletedFlags < ActiveRecord::Migration
  def self.up
    add_column :accounts, :deleted, :boolean, :null => false, :default => false
    add_column :charge_types, :deleted, :boolean, :null => false, :default => false
    add_column :entries, :deleted, :boolean, :null => false, :default => false
    add_column :users, :deleted, :boolean, :null => false, :default => false
  end

  def self.down
    remove_column :accounts, :deleted
    remove_column :charge_types, :deleted
    remove_column :entries, :deleted
    remove_column :users, :deleted
  end
end
