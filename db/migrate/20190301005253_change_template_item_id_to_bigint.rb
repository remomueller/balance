class ChangeTemplateItemIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :template_items, :id, :bigint
  end

  def down
    change_column :template_items, :id, :integer
  end
end
