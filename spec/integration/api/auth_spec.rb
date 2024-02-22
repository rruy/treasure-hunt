# require 'swagger_helper'

# RSpec.describe 'api/auth', type: :request do
#   path '/api/login' do
#     post('login in') do
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
