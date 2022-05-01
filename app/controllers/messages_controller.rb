class MessagesController < ApplicationController
  before_action :only_follow, only: [:show]

  def show
    @user = User.find(params[:id])
    message_rooms = current_user.users_rooms.pluck(:message_room_id)
    users_rooms = UsersRoom.find_by(user_id: @user.id,message_room_id: message_rooms)

    unless users_rooms.nil?
      @room = users_rooms.message_room
    else
      @room = MessageRoom.new
      @room.save
      UsersRoom.create(user_id: current_user.id, message_room_id: @room.id)
      UsersRoom.create(user_id:@user.id,message_room_id: @room.id)
    end
    @messages = @room.messages
    @message = Message.new(message_room_id: @room.id)
  end

  def create
    @message = current_user.messages.new(message_params)
    @message.save
    redirect_to request.referer
  end

  private

  def message_params
    params.require(:message).permit(:message,:message_room_id)
  end

  def only_follow
    user = User.find(params[:id])
    unless current_user.following?(user) 
      redirect_to books_path
    end
  end


end
