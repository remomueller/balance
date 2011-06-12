class MakeAmountInteger < ActiveRecord::Migration
  def self.up
    Entry.all.each do |entry|
      entry.update_attribute :amount, entry.amount * 100.0
    end
    change_column :entries, :amount, :integer, :null => false
  end

  def self.down
    change_column :entries, :amount, :float, :null => false
    Entry.all.each do |entry|
      entry.update_attribute :amount, entry.amount / 100.0
    end
  end
end
