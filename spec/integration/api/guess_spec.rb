# require 'swagger_helper'

# RSpec.describe 'api/guesses', type: :request do
  
#   path '/api/guesses' do
#     post('create guess') do
#       tags 'Guesses'
#       consumes 'application/json'
#       parameter name: :guess, in: :body, schema: {
#         type: :object,
#         properties: {
#           latitude: { type: :number },
#           longitude: { type: :number }
#         },
#         required: ['latitude', 'longitude']
#       }

#       response(201, 'successful') do
#         let(:user) { create(:user, email: 'test2@example.com', password: 'password') }
#         let(:guess) { { latitude: -27.4421, longitude: -48.5062 } }

#         run_test!(headers: { 'Authorization' => user.create_new_auth_token['Authorization'] })
#       end

#       response(401, 'unauthorized') do
#         let(:guess) { { latitude: -27.4421, longitude: -48.5062 } }

#         run_test! do
#           expect(response).to have_http_status(:unauthorized)
#         end
#       end
#     end
#   end
# end