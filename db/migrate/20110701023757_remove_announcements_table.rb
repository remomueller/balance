class RemoveAnnouncementsTable < ActiveRecord::Migration
  def up
    remove_column :users, :announcement_hide_time
    drop_table :announcements
  end

  def down
    create_table :announcements do |t|
      t.integer :user_id, :null => false
      t.string :title, :null => false
      t.text :message, :null => false
      t.timestamps
    end
    add_column :users, :announcement_hide_time, :datetime
  end
end
