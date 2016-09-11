class AddCategoryToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :category, :string, null: false, default: 'savings'
  end
end
