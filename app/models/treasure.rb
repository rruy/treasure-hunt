class Treasure < ApplicationRecord
  validates :name, presence: true
  validates :latitude, :longitude, presence: true
end
