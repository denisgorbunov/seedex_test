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
end