require 'rails_helper'

RSpec.describe Treasure, type: :model do
  describe 'validations' do
    it 'is valid with valid attributes' do
      treasure = build(:treasure)
      expect(treasure).to be_valid
    end

    it 'is not valid without a name' do
      treasure = build(:treasure, name: nil)
      expect(treasure).not_to be_valid
    end

    it 'is not valid without latitude' do
      treasure = build(:treasure, latitude: nil)
      expect(treasure).not_to be_valid
    end

    it 'is not valid without longitude' do
      treasure = build(:treasure, longitude: nil)
      expect(treasure).not_to be_valid
    end
  end
end
