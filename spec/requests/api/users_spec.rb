require 'swagger_helper'

RSpec.describe 'API::UsersController', type: :request do

  let!(:user) { create(:user) }
  let!(:auth_token) { user.create_new_auth_token }

  path '/api/users' do
    get('List all users') do
      tags 'Users'
      produces 'application/json'
      parameter name: 'Authorization', in: :header, type: :string, required: true

      response(200, 'successful') do
        let(:Authorization) { "#{auth_token['Authorization']}" }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil } # Unauthorized request
        run_test! do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    post('create new user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string },
          password_confirmation: { type: :string }
        },
        required: ['email', 'password', 'password_confirmation']
      }

      response(201, 'successful') do
        let(:Authorization) { nil } # Unauthorized request
        let(:payload) { { email: 'test@example.com', password: 'password', password_confirmation: 'password' } }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:Authorization) { nil } # Unauthorized request
        let(:payload) { { email: '', password: 'password' } } # Invalid payload
        run_test!
      end
    end
  end

  path '/api/users/{id}' do
    put('Update user') do
      tags 'Users'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          email: { type: :string },
          password: { type: :string }
        },
        required: ['email', 'password']
      }
      parameter name: 'Authorization', in: :header, type: :string, required: true

      response(200, 'successful') do
        let(:Authorization) { "#{auth_token['Authorization']}" }
        let(:id) { create(:user).id }
        let(:payload) { { email: 'updated@example.com', password: 'newpassword' } }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil } # Unauthorized request
        let(:id) { create(:user).id }
        let(:payload) { { email: 'updated@example.com', password: 'newpassword' } }

        run_test! do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    get('get user') do
      tags 'Users'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: 'Authorization', in: :header, type: :string, required: true

      response(200, 'successful') do
        let(:Authorization) { "#{auth_token['Authorization']}" }
        let(:id) { create(:user).id }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil }
        let(:id) { create(:user).id }

        run_test! do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end