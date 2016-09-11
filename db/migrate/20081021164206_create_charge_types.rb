class CreateChargeTypes < ActiveRecord::Migration[4.2]
  def change
    create_table :charge_types do |t|
      t.string :name, null: false
      t.integer :account_id, null: false
      t.boolean :counts_towards_spending, null: false, default: true
    end
  end
end
