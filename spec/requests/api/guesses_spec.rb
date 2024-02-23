require 'swagger_helper'

RSpec.describe 'api/guesses', type: :request do

  let!(:user) { create(:user) }
  let!(:auth_token) { user.create_new_auth_token }
  let!(:treasure) { create(:treasure) }

  path '/api/guesses' do
    get('List all Guesses') do
      tags 'Guesses'
      produces 'application/json'

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

    post('Create new Guess') do
      tags 'Guesses'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          latitude: { type: :number, format: :float },
          longitude: { type: :number, format: :float }
        },
        required: ['latitude', 'longitude']
      }

      response(201, 'successful') do
        let(:Authorization) { "Bearer #{auth_token['Authorization']}" }
        let(:payload) { { latitude: -27.4421, longitude: -48.5062 } }
        run_test!
      end

      response(422, 'unprocessable entity') do
        let(:Authorization) { "Bearer #{auth_token['Authorization']}" }
        let(:payload) { { latitude: '', longitude: '' } } # Invalid payload
        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil } # Unauthorized request
        let(:payload) { { latitude: -27.4421, longitude: -48.5062 } }

        run_test! do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end

  path '/api/guesses/{id}' do
    get('Get Guess by ID') do
      tags 'Guesses'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer

      response(200, 'successful') do
        let(:Authorization) { "#{auth_token['Authorization']}" }
        let!(:guess) { create(:guess) }
        let(:id) { guess.id }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil } # Unauthorized request
        let!(:guess) { create(:guess) }
        let(:id) { guess.id }

        run_test! do
          expect(response).to have_http_status(:unauthorized)
        end
      end

      response(404, 'not found') do
        let(:Authorization) { "#{auth_token['Authorization']}" }
        let(:id) { -1 } # Invalid ID

        run_test! do
          expect(response).to have_http_status(:not_found)
        end
      end
    end
  end
end

