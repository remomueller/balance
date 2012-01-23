class UpdateUsersWithAuthentication < ActiveRecord::Migration
  def self.up
    add_column :users, :confirmation_token, :string
    add_column :users, :confirmed_at, :datetime
    add_column :users, :confirmation_sent_at, :datetime
    add_column :users, :failed_attempts, :integer, :default => 0
    add_column :users, :unlock_token, :string
    add_column :users, :locked_at, :datetime
    add_column :users, :authentication_token, :string

    add_index :users, :confirmation_token, :unique => true
    add_index :users, :unlock_token, :unique => true
    add_index :users, :authentication_token, :unique => true
  end

  def self.down
    remove_index :users, :confirmation_token
    remove_index :users, :unlock_token
    remove_index :users, :authentication_token

    remove_column :users, :confirmation_token
    remove_column :users, :confirmed_at
    remove_column :users, :confirmation_sent_at
    remove_column :users, :failed_attempts
    remove_column :users, :unlock_token
    remove_column :users, :locked_at
    remove_column :users, :authentication_token
  end
end
