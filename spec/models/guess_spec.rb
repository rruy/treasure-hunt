require 'rails_helper'

RSpec.describe Guess, type: :model do
  # Ensure that the Guess model belongs to a user
  it { should belong_to(:user) }

  # Validate presence of latitude and longitude
  it { should validate_presence_of(:latitude) }
  it { should validate_presence_of(:longitude) }

  # Validate numericality of latitude and longitude
  it { should validate_numericality_of(:latitude) }
  it { should validate_numericality_of(:longitude) }
end