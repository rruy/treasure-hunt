# spec/controllers/api/auth_controller_spec.rb
require 'swagger_helper'

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


# require 'rails_helper'
# require 'swagger_helper'

# RSpec.describe 'Api::', type: :request do
#   path '/sign_up' do
#     post('sign up') do
#       tags 'Authentication'
#       consumes 'application/json'
#       parameter name: :user, in: :body, schema: {
#         type: :object,
#         properties: {
#           email: { type: :string },
#           password: { type: :string },
#           password_confirmation: { type: :string }
#         },
#         required: ['email', 'password', 'password_confirmation']
#       }

#       response(201, 'successful') do
#         let(:user) { { email: 'test@example.com', password: 'password', password_confirmation: 'password' } }

#         run_test!
#       end

#       response(422, 'unprocessable entity') do
#         let(:user) { { email: '', password: '', password_confirmation: '' } }

#         run_test!
#       end
#     end
#   end

#   path '/sign_in' do
#     post('sign in') do
#       tags 'Authentication'
#       consumes 'application/json'
#       parameter name: :credentials, in: :body, schema: {
#         type: :object,
#         properties: {
#           email: { type: :string },
#           password: { type: :string }
#         },
#         required: ['email', 'password']
#       }

#       response(200, 'successful') do
#         let(:user) { create(:user, email: 'test@example.com', password: 'password') }
#         let(:credentials) { { email: user.email, password: 'password' } }

#         run_test!
#       end

#       response(401, 'unauthorized') do
#         let(:user) { create(:user, email: 'test@example.com', password: 'password') }
#         let(:credentials) { { email: user.email, password: 'wrong_password' } }

#         run_test!
#       end
#     end
#   end
# end