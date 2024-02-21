class User < ApplicationRecord
  include DeviseTokenAuth::Concerns::User

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable

  has_many :guesses
  validate :validate_winner_status, on: :update
  after_commit :send_winner_email, on: :update, if: :winner_changed?

  private

  def validate_winner_status
    if winner? &&
       winner_previously_changed?
      errors.add(:winner, 'User can only become a winner once')
    end
  end

  def send_winner_email
    begin
      UserMailer.with(user: current_user).winner_confirmation_email.deliver_now
    rescue
    end
  end
end
