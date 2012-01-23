class DeviseCreateUsers < ActiveRecord::Migration
  def self.up
    drop_table :users

    create_table(:users) do |t|
      ## Database authenticatable
      t.string :email,              :null => false, :default => ""
      t.string :encrypted_password, :null => false, :default => ""

      ## Recoverable
      t.string   :reset_password_token
      # t.datetime :reset_password_sent_at # Added in a later migration

      ## Rememberable
      t.string :remember_token # Removed in later migration...
      t.datetime :remember_created_at

      ## Trackable
      t.integer  :sign_in_count, :default => 0
      t.datetime :current_sign_in_at
      t.datetime :last_sign_in_at
      t.string   :current_sign_in_ip
      t.string   :last_sign_in_ip

      ## Encryptable
      t.string :password_salt

      ## Confirmable
      # t.string   :confirmation_token # Added in later migration
      # t.datetime :confirmed_at # Added in later migration
      # t.datetime :confirmation_sent_at # Added in later migration
      # t.string   :unconfirmed_email # Only if using reconfirmable # Added in a later migration

      ## Lockable
      # t.integer  :failed_attempts, :default => 0 # Only if lock strategy is :failed_attempts # Added in later migration
      # t.string   :unlock_token # Only if unlock strategy is :email or :both
      # t.datetime :locked_at  # Added in later migration

      # Token authenticatable
      # t.string :authentication_token  # Added in later migration


      t.timestamps
    end

    add_index :users, :email,                :unique => true
    add_index :users, :reset_password_token, :unique => true
    # add_index :users, :confirmation_token,   :unique => true # Added in later migration
    # add_index :users, :unlock_token,         :unique => true # Added in later migration
    add_index :users, :authentication_token, :unique => true

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
