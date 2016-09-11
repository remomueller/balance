class EntryCharged < ActiveRecord::Migration[4.2]
  def change
    add_column :entries, :charged, :boolean, null: false, default: true
  end
end
