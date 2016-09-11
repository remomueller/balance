class CreateAccounts < ActiveRecord::Migration[4.2]
  def change
    create_table :accounts do |t|
      t.integer :user_id, null: false
      t.string :name, null: false
    end
  end
end
