class CreateTemplateItems < ActiveRecord::Migration
  def change
    create_table :template_items do |t|
      t.string :name
      t.integer :charge_type_id
      t.integer :amount
      t.text :description
      t.integer :template_id
      t.integer :position, null: false, default: 0

      t.timestamps null: false
    end

    add_index :template_items, :charge_type_id
    add_index :template_items, :template_id
    add_index :template_items, :position
  end
end
