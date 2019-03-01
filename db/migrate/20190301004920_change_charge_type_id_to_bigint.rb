class ChangeChargeTypeIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :charge_types, :id, :bigint

    change_column :entries, :charge_type_id, :bigint
    change_column :template_items, :charge_type_id, :bigint
  end

  def down
    change_column :charge_types, :id, :integer

    change_column :entries, :charge_type_id, :integer
    change_column :template_items, :charge_type_id, :integer
  end
end
