class MakeAmountInteger < ActiveRecord::Migration[4.2]
  def up
    change_column :entries, :amount, :integer, null: false
  end

  def down
    change_column :entries, :amount, :float, null: false
  end
end
