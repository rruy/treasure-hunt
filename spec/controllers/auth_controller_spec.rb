# spec/controllers/api/auth_controller_spec.rb
require 'rails_helper'

RSpec.describe Api::AuthController, type: :controller do
  describe 'POST #sign_up' do
    context 'with valid params' do
      let(:valid_params) { { email: 'test@example.com', password: 'password', password_confirmation: 'password' } }

      it 'creates a new user' do
        post :sign_up, params: valid_params
        expect(response).to have_http_status(:created)
        expect(User.count).to eq(1)
      end

      it 'returns the user and token' do
        post :sign_up, params: valid_params
        expect(response).to have_http_status(:created)
        expect(JSON.parse(response.body)).to include('user', 'token')
      end
    end

    context 'with invalid params' do
      let(:invalid_params) { { email: 'test_example.com', password: 'password' } }

      it 'does not create a new user' do
        post :sign_up, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(User.count).to eq(0)
      end

      it 'returns errors' do
        post :sign_up, params: invalid_params
        expect(response).to have_http_status(:unprocessable_entity)
        expect(JSON.parse(response.body)).to include('errors')
      end
    end
  end

  describe 'POST #sign_in' do
    let!(:user) { create(:user, email: 'test@example.com', password: 'password') }

    context 'with valid credentials' do
      let(:valid_credentials) { { email: 'test@example.com', password: 'password' } }

      it 'returns the user and token' do
        post :sign_in, params: valid_credentials
        expect(response).to have_http_status(:ok)
        expect(JSON.parse(response.body)).to include('user', 'token')
      end
    end

    context 'with invalid credentials' do
      let(:invalid_credentials) { { email: 'test@example.com', password: 'wrong_password' } }

      it 'returns an unauthorized error' do
        post :sign_in, params: invalid_credentials
        expect(response).to have_http_status(:unauthorized)
        expect(JSON.parse(response.body)).to include('error' => 'Invalid email or password')
      end
    end
  end
end
