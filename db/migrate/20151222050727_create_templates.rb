class CreateTemplates < ActiveRecord::Migration
  def change
    create_table :templates do |t|
      t.string :name
      t.integer :user_id
      t.boolean :deleted, null: false, default: false

      t.timestamps null: false
    end

    add_index :templates, :user_id
    add_index :templates, :deleted
  end
end
