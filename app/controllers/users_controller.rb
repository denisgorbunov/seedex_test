class UsersController < ApplicationController
  def create
    data = JSON.parse(request.body.read)
    user = User.new(nickname: data['nickname'], last_online_at: Time.now)
    if user.save
      render json: {
          success: true
      }, status: 200
    else
      render json: {
          success: false,
          error: @user.errors
      }, status: 400
    end
  end
end

#TODO: Обработка ошибок