class DropAuthentications < ActiveRecord::Migration[6.0]
  def change
    drop_table :authentications do |t|
      t.integer :user_id
      t.string :provider
      t.string :uid

      t.timestamps
    end
  end
end
