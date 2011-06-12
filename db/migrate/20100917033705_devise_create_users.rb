class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    drop_table :users
    
    create_table(:users) do |t|
      t.database_authenticatable :null => false
      t.recoverable
      t.rememberable
      t.trackable

      # t.confirmable
      # t.lockable :lock_strategy => :failed_attempts, :unlock_strategy => :both
      # t.token_authenticatable


      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true
    # add_index :users, :unlock_token,         :unique => true
    
    add_column :users, :announcement_hide_time, :datetime
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :deleted, :boolean, :null => false, :default => false
  end

  def self.down
    drop_table :users
    
    create_table "users", :force => true do |t|
      t.column :login,                     :string
      t.column :email,                     :string
      t.column :crypted_password,          :string, :limit => 40
      t.column :salt,                      :string, :limit => 40
      t.column :created_at,                :datetime
      t.column :updated_at,                :datetime
      t.column :remember_token,            :string
      t.column :remember_token_expires_at, :datetime
    end
    
    add_column :users, :announcement_hide_time, :datetime
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :deleted, :boolean, :null => false, :default => false
    
  end
end
