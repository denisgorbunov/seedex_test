class Message < ApplicationRecord
  scope :dialog, ->(sender, receiver) do
    where('(sender_id= ? AND receiver_id= ?) OR (sender_id= ? AND receiver_id= ?)',
          sender, receiver, receiver, sender).order(:id)
  end
end
