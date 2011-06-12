class CreateEntries < ActiveRecord::Migration
  def self.up
    create_table :entries do |t|
      t.integer :user_id, :null => false
      t.integer :charge_type_id, :null => false
      t.string :name, :null => false
      t.date :billing_date, :null => false
      t.float :amount, :null => false
      t.text :description
    end
  end

  def self.down
    drop_table :entries
  end
end
