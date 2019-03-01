class ChangeUserIdToBigint < ActiveRecord::Migration[6.0]
  def up
    change_column :users, :id, :bigint

    change_column :accounts, :user_id, :bigint
    change_column :entries, :user_id, :bigint
    change_column :templates, :user_id, :bigint
  end

  def down
    change_column :users, :id, :integer

    change_column :accounts, :user_id, :integer
    change_column :entries, :user_id, :integer
    change_column :templates, :user_id, :integer
  end
end
