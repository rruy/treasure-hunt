# require 'swagger_helper'

# RSpec.describe 'api/auth', type: :request do

#   path '/api/sign_up' do
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

#   path '/api/sign_in' do
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
