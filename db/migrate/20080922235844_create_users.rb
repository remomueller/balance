class CreateUsers < ActiveRecord::Migration[4.2]
  def change
    create_table :users, force: true do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, limit: 40
      t.column :salt,                      :string, limit: 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
    end
  end
end
