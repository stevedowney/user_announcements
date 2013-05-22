class CreateUsers < ActiveRecord::Migration
  def up
    create_table :users, :force => true do |t|
      t.string :name
      t.timestamps
    end
  end

  def down
  end
end