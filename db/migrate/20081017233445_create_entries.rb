class CreateEntries < ActiveRecord::Migration[4.2]
  def change
    create_table :entries do |t|
      t.integer :user_id, null: false
      t.integer :charge_type_id, null: false
      t.string :name, null: false
      t.date :billing_date, null: false
      t.float :amount, null: false
      t.text :description
    end
  end
end
