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
    messages = []
    errors << "CURRENT_USER_NOT_FOUND" unless User.find_by(id: params['current_user_id'])
    errors << "TARGET_USER_NOT_FOUND" unless User.find_by(id: params['target_user_id'])
    messages << Message.where(sender_id: params['target_user_id'], receiver_id: params['current_user_id'])
    messages << Message.where(sender_id: params['current_user_id'], receiver_id: params['target_user_id'])
    unread = Message.where(receiver_id: params['current_user_id'], read: false)
    unread.each do |m|
      m.update(read: true)
      User.find(params['current_user_id']).update(last_online_at: Time.now)
    end
    if !messages.empty?
      render json: {
          success: true,
          messages: messages
      }, status: 200
    else
      render json: {
          success: false,
          errors: errors
      }
    end
  end
end

#TODO: переделать этот бред..

