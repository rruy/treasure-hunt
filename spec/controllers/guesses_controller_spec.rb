require 'rails_helper'

RSpec.describe Api::GuessesController, type: :controller do
  describe 'POST #create' do
    let!(:treasure_location) { create(:treasure_location) }
    let(:user) { create(:user) }
    let(:valid_guess_params) { { guess: { latitude: -27.4421, longitude: -48.5062 } } }
    let(:wrong_guess_params) { { guess: { latitude: 1000, longitude: 25000 } } }
    token = nil

    before do
      token = user.create_new_auth_token['Authorization']
      request.headers['Authorization'] = token.to_s
    end

    context 'with valid parameters' do
      it 'creates a new guess and returns a success response' do
        user.update(winner: false)
        user.reload

        post :create, params: valid_guess_params
        result = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(result['message']).to eq "User #{user.email} is the new winner!"
        expect(user.reload.winner?).to eq(true)
      end

      it 'creates a new guess and returns a user not winner yet response' do
        post :create, params: wrong_guess_params
        result = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(result['message']).to eq "Sorry, #{user.email}, you is not winner yet. Try one more time!"
        expect(user.reload.winner?).to eq(true).or(eq(false))
      end

      it 'creates a new guess and returns a user already won response' do
        user.update(winner: true)
        user.reload

        post :create, params: valid_guess_params
        result = JSON.parse(response.body)

        expect(response).to have_http_status(:created)
        expect(result['message']).to eq "User #{user.email} has already won!"
        expect(user.reload.winner?).to eq(true).or(eq(false))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_guess_params) { { guess: { latitude: 'invalid', longitude: 'invalid' } } }

      it 'does not create a new guess and returns an unprocessable entity response' do
        post :create, params: invalid_guess_params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
