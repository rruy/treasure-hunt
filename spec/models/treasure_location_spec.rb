require 'rails_helper'

RSpec.describe TreasureLocation, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      treasure_location = build(:treasure_location)
      expect(treasure_location).to be_valid
    end

    it 'is not valid without a name' do
      treasure_location = build(:treasure_location, name: nil)
      expect(treasure_location).not_to be_valid
    end

    it 'is not valid without latitude' do
      treasure_location = build(:treasure_location, latitude: nil)
      expect(treasure_location).not_to be_valid
    end

    it 'is not valid without longitude' do
      treasure_location = build(:treasure_location, longitude: nil)
      expect(treasure_location).not_to be_valid
    end
  end
end
