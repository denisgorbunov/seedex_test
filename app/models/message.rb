class Message < ApplicationRecord
  scope :my, ->(sender, receiver) { where("sender_id = ? AND receiver_id = ? OR ", sender,receiver)}
end
