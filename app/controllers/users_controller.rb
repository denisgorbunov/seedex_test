class UsersController < ApplicationController
  def create
    errors = []
    data = JSON.parse(request.body.read)
    errors << "NICKNAME_EMPTY" unless data['nickname']
    errors << "NICKNAME_TAKEN" if User.find_by(nickname: data['nickname'])
    if errors.empty?
      user = User.new(nickname: data['nickname'], last_online_at: Time.now)
      if user.save
        render json: {
            success: true
        }, status: 200
      end
    else
      render json: {
          success: false,
          error: errors
      }, status: 400
    end
  end

  def index
    users = []
    User.all.map do |m|
      attr = m.attributes.to_h
      attr[:unread_messages] = getUnread(m.id).size
      users << attr
    end
    render json: {
        success: true,
        users: users
    }, status: 200
  end

  def getUnread(user)
    Message.where(receiver_id: user, read: false)
  end
end