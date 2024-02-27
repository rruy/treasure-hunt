require 'swagger_helper'

RSpec.describe 'Api::WinnersController', type: :request do
  let!(:user) { create(:user) }
  let!(:auth_token) { user.create_new_auth_token }

  path '/api/winners' do
    get('List winners') do
      tags 'Winners'
      produces 'application/json'
      parameter name: :page, in: :query, type: :integer

      response(200, 'successful') do
        let(:Authorization) { "#{auth_token['Authorization']}" }
        let(:page) { 1 }
        run_test!
      end

      response(401, 'unauthorized') do
        let(:Authorization) { nil } # Unauthorized request
        let(:page) { 1 }
        run_test! do
          expect(response).to have_http_status(:unauthorized)
        end
      end
    end
  end
end