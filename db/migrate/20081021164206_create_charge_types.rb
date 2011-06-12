class CreateChargeTypes < ActiveRecord::Migration
  def self.up
    create_table :charge_types do |t|
      t.string :name, :null => false
      t.integer :account_id, :null => false
      t.boolean :counts_towards_spending, :null => false, :default => true
    end
  end

  def self.down
    drop_table :charge_types
  end
end
