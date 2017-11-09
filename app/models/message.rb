class Message < ApplicationRecord
  belongs_to :receiver, class_name: "User", foreign_key: "receiver_id", inverse_of: :income
  belongs_to :sender, class_name: "User", foreign_key: "sender_id", inverse_of: :outcome

  validates :message, :sender_id, :receiver_id, presence: true

  scope :dialog, ->(sender, receiver) do
    where('(sender_id= ? AND receiver_id= ?) OR (sender_id= ? AND receiver_id= ?)',
          sender, receiver, receiver, sender).order(:id)
  end

  scope :unread, -> { where(read: false) }
end
