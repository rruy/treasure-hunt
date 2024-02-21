require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:password) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  describe 'associations' do
    it { should have_many(:guesses) }
  end

  describe 'callbacks' do
    let(:user) { FactoryBot.create(:user) }

    xit 'sends winner email after update' do
      expect {
        user.update(winner: true)
      }.to have_enqueued_mail(UserMailer, :winner_confirmation_email)
    end
  end

  describe 'custom validations' do
    let(:user) { FactoryBot.create(:user) }

    it 'prevents user from becoming winner more than once' do
      user.update(winner: true)
      user.update(winner: true) # Try to set winner to true again
      expect(user.errors[:winner]).to include('User can only become a winner once')
    end
  end
end
