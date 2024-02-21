class Guess < ApplicationRecord
  belongs_to :user

  validates :latitude, :longitude, presence: true
  validates :latitude, :longitude, numericality: true
end
