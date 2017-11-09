require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it 'создание пользователя' do
    expect(user).to be_valid
  end
  it 'установка даты/времени последнего входа при создании пользователя' do
    expect(user.last_online_at.strftime("%d/%m/%Y %H:%M:%S")).to eq Time.now.strftime("%d/%m/%Y %H:%M:%S")
  end

end
