class CreateAccounts < ActiveRecord::Migration
  def self.up
    create_table :accounts do |t|
      t.integer :user_id, :null => false
      t.string :name, :null => false
    end
  end

  def self.down
    drop_table :accounts
  end
end
