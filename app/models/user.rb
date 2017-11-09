class User < ApplicationRecord
  has_many :income, class_name: "Message", foreign_key: "receiver_id", inverse_of: :receiver
  has_many :outcome, class_name: "Message", foreign_key: "sender_id", inverse_of: :sender

  validates :nickname, presence: true, uniqueness: true

end
