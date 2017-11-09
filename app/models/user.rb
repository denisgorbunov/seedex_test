class User < ApplicationRecord
  has_many :income, class_name: "Message", foreign_key: "receiver_id", inverse_of: :receiver
  has_many :outcome, class_name: "Message", foreign_key: "sender_id", inverse_of: :sender

  validates :nickname, :last_online_at, presence: true, uniqueness: true
  before_validation :set_last_online_time, on: :create

  protected
  def set_last_online_time
    self.last_online_at ||= Time.now
  end

end
