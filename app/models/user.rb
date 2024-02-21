class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
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
