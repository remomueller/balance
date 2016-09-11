class CreateAnnouncements < ActiveRecord::Migration[4.2]
  def change
    create_table :announcements do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :message, null: false
      t.timestamps
    end
    add_column :users, :announcement_hide_time, :datetime
  end
end
