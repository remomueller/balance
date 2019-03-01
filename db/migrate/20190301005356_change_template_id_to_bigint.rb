class ChangeTemplateIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :templates, :id, :bigint

    change_column :template_items, :template_id, :bigint
  end

  def down
    change_column :templates, :id, :integer

    change_column :template_items, :template_id, :integer
  end
end
