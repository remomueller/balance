class ChangeAccountIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :accounts, :id, :bigint

    change_column :charge_types, :account_id, :bigint
  end

  def down
    change_column :accounts, :id, :integer

    change_column :charge_types, :account_id, :integer
  end
end
