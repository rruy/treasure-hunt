require 'rails_helper'

RSpec.describe GameLogicService do
  describe '#calculate_distance' do
    subject(:game_logic_service) { described_class.new }

    let(:treasure_latitude) { -27.4421 }
    let(:treasure_longitude) { -48.5062 }

    EXPECT_DISTANCE_SC = 0
    EXPECT_DISTANCE_SP = 471710

    context 'when given valid latitude and longitude' do
      # Santa Catarina City Location
      let(:user_latitude) { -27.4421 }
      let(:user_longitude) { -48.5062 }

      it 'calculates the correct distance to the treasure' do
        distance = game_logic_service.calculate_distance(user_latitude.to_f, user_longitude.to_f).to_i
        expect(distance).to eq EXPECT_DISTANCE_SC
      end
    end

    context 'when given invalid latitude and longitude' do
      # Sao Paulo City Location
      let(:user_latitude) { -23.5489 }
      let(:user_longitude) { -46.6388 }

      it 'Calculate the correct distance to the treasure' do
        distance = game_logic_service.calculate_distance(user_latitude.to_f, user_longitude.to_f).to_i
        expect(distance).to eq EXPECT_DISTANCE_SP
      end
    end
  end
end
