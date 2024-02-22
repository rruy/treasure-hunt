require 'swagger_helper'

RSpec.describe 'API::TreasureLocationsController', type: :request do

  let!(:user) { create(:user) }
  let!(:auth_token) { user.create_new_auth_token }

  path '/api/treasure_locations' do
    get('List all treasure locations') do
      tags 'Treasure Locations'
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

  post('create new resource') do
    tags 'Treasure Locations'
    consumes 'application/json'
    produces 'application/json'
    parameter name: :payload, in: :body, schema: {
      type: :object,
      properties: {
        name: { type: :string },
        latitude: { type: :bigdecimal },
        longitude: { type: :bigdecimal },
        active: { type: :boolean }
      },
      required: ['name', 'latitude', 'longitude']
    }
    parameter name: 'Authorization', in: :header, type: :string, required: true

    response(201, 'successful') do
      let(:Authorization) { "#{auth_token['Authorization']}" }
      let(:payload) { { name: 'Location 1', latitude: '9.00', longitude: '9.99' } }
      run_test!
    end

    response(401, 'unauthorized') do
      let(:Authorization) { nil } # Unauthorized request
      let(:payload) { { name: 'Location 1', latitude: '9.00', longitude: '9.99' } }
      run_test! do
        expect(response).to have_http_status(:unauthorized)
      end
    end
   end
  end

  path '/api/treasure_locations/{id}' do
    put('Update resource') do
      tags 'Treasure Locations'
      consumes 'application/json'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: :payload, in: :body, schema: {
        type: :object,
        properties: {
          name: { type: :string },
          latitude: { type: :bigdecimal },
          longitude: { type: :bigdecimal },
          active: { type: :boolean }
        },
        required: ['name', 'latitude', 'longitude']
      }
      parameter name: 'Authorization', in: :header, type: :string, required: true

      response(200, 'successful') do
        let(:Authorization) { "#{auth_token['Authorization']}" }
        let(:id) { create(:treasure_location).id }
        let(:payload) { { name: 'Location 1', latitude: '9.00', longitude: '9.99', active: true } }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil } # Unauthorized request
        let(:id) { create(:treasure_location).id }
        let(:payload) { { name: 'Location 1', latitude: '9.00', longitude: '9.99', active: true } }

        run_test! do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end

    get('get treasure location') do
      tags 'Treasure Locations'
      produces 'application/json'
      parameter name: :id, in: :path, type: :integer
      parameter name: 'Authorization', in: :header, type: :string, required: true

      response(200, 'successful') do
        let(:Authorization) { "#{auth_token['Authorization']}" }
        let(:id) { create(:treasure_location).id }

        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil }
        let(:id) { create(:treasure_location).id }

        run_test! do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end
