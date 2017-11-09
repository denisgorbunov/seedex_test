class MessagesController < ApplicationController
  def create
    errors = []
    data = JSON.parse(request.body.read)
    sender = User.find_by(id: data['from'])
    receiver = User.find_by(id: data['to'])
    message = Message.new(message: data['message'], sender_id: data['from'], receiver_id: data['to'])
    errors << "USER_NOT_FOUND" if (!sender || !receiver)
    if errors.empty? && message.save
      sender.update(last_online_at: Time.now)
      render json: {
          success: true,
          payload: {
              id: data['from']
          }
      }, status: 200
    else
      render json: {
          success: false,
          error: errors
      }, status: 404
    end
  end

  def show
    errors = []
    current_user = params['current_user_id']
    target_user = params['target_user_id']
    errors << "CURRENT_USER_NOT_FOUND" unless User.find_by(id: current_user)
    errors << "TARGET_USER_NOT_FOUND" unless User.find_by(id: target_user)
    if errors.empty?
      messages = Message.dialog(current_user, target_user)
      errors << "NOT_FOUND" unless messages.nil?
      unread = Message.where(receiver_id: current_user, read: false)
      if not messages.empty?
        unread.each do |m|
          m.update(read: true)
          User.find(current_user).update(last_online_at: Time.now)
        end
        render json: {
            success: true,
            messages: messages
        }, status: 200
      else
        render json: {
            success: false,
            errors: errors
        }, status: 404
      end
    else
      render json: {
          success: false,
          errors: errors
      }, status: 404
    end
  end
end

