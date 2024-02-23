require 'swagger_helper'

RSpec.describe 'api/sessions', type: :request do

  let!(:user) { create(:user) }
  let!(:auth_token) { user.create_new_auth_token }

  path '/api/sessions' do
    post('create session') do
      tags 'Sessions'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password', 'password_confirmation']
      }

      response(201, 'successful') do
        let(:Authorization) { "#{auth_token['Authorization']}" }
        let(:payload) { { email: user.email, password: user.password } }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil }
        let(:payload) { { email: '', password: 'password' } } # Invalid payload

        run_test! do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
