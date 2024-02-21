class User < ApplicationRecord
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :confirmable, :omniauthable #, :token_authenticatable

  # Include default devise modules.
  include DeviseTokenAuth::Concerns::User

  has_many :guesses

  validate :validate_winner_status, on: :update

  private

  def validate_winner_status
    if winner_changed? &&
       winner? &&
       winner_previously_changed?
      errors.add(:winner, 'User can only become a winner once')
    end
  end
end
