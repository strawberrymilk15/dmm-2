class CreateUsersRooms < ActiveRecord::Migration[6.1]
  def change
    create_table :users_rooms do |t|

      t.integer :user_id
      t.integer :message_room_id

      t.timestamps
    end
  end
end
