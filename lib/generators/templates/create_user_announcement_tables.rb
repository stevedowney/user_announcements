class CreateUserAnnouncementTables < ActiveRecord::Migration
  def change
    create_table :announcements do |t|
      t.text :body
      t.datetime :starts_at
      t.datetime :ends_at
      t.boolean :active
      t.timestamps
    end
    
    create_table :user_announcements, :force => true do |t|
      t.integer :user_id
      t.integer :announcement_id
      t.timestamps
    end
  end
end