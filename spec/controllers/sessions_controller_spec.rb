require 'swagger_helper'

RSpec.describe Api::SessionsController, type: :controller do
  describe 'POST #login' do
    let!(:user) { create(:user, email: 'test@example.com', password: 'password') }

    context 'with valid credentials' do
      let(:valid_credentials) { { email: 'test@example.com', password: 'password' } }

      it 'returns the user and token' do
        post :create, params: valid_credentials
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('user', 'token')
      end
    end

    context 'with invalid credentials' do
      let(:invalid_credentials) { { email: 'test@example.com', password: 'wrong_password' } }

      it 'returns an unauthorized error' do
        post :create, params: invalid_credentials
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to include('error' => 'Invalid email or password')
      end
    end
  end
end