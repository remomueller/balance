class RemoveAnnouncementsTable < ActiveRecord::Migration[4.2]
  def change
    remove_column :users, :announcement_hide_time, :datetime
    drop_table :announcements do |t|
      t.integer :user_id, null: false
      t.string :title, null: false
      t.text :message, null: false
      t.timestamps
    end
  end
end
