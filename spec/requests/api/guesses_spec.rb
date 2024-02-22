require 'swagger_helper'

RSpec.describe 'api/guesses', type: :request do

  let!(:user) { create(:user) }
  let!(:auth_token) { user.create_new_auth_token }

  path '/api/guesses' do
    get('List all Guesses') do
      tags 'Guesses'
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
  end

  path '/api/guesses/{id}' do
    get('Get Guess by ID') do
      tags 'Guesses'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: 'Authorization', in: :header, type: :string, required: true
  
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
