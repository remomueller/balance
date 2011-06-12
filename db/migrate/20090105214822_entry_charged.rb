class EntryCharged < ActiveRecord::Migration
  def self.up
    add_column :entries, :charged, :boolean, :null => false, :default => true
  end

  def self.down
    remove_column :entries, :charged
  end
end
