class MessageRoom < ApplicationRecord

  has_many :users_rooms
  has_many :messages

end
