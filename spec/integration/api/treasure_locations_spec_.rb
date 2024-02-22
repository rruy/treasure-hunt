# require 'swagger_helper'

# RSpec.describe 'api/treasure_locations', type: :request do
#     let!(:user) { create(:user, email: 'test@example.com', password: 'password') }
#     let!(:headers) { { 'Authorization' => user.create_new_auth_token['access-token'] } }

#     path '/api/treasure_locations' do
#       # POST /api/treasure_locations
#       post('create treasure location') do
#         tags 'Treasure Locations'
#         consumes 'application/json'
#         parameter name: :treasure_location, in: :body, schema: {
#           type: :object,
#           properties: {
#             name: { type: :string },
#             latitude: { type: :number },
#             longitude: { type: :number },
#             active: { type: :boolean }
#           },
#           required: ['name', 'latitude', 'longitude', 'active']
#         }
  
#         response(201, 'successful') do
#           let(:treasure_location) { { name: 'Treasure Island', latitude: -27.4421, longitude: -48.5062, active: true } }
  
#           run_test!(headers: headers)
#         end
  
#         response(401, 'unauthorized') do
#           let(:treasure_location) { { name: 'Treasure Island', latitude: -27.4421, longitude: -48.5062, active: true } }
  
#           run_test!(headers: {})
#         end
#       end
#     end
  
#     path '/api/treasure_locations/{id}' do
#       # GET /api/treasure_locations/:id
#       get('show treasure location') do
#         tags 'Treasure Locations'
#         produces 'application/json'
#         parameter name: :id, in: :path, type: :integer
  
#         response(200, 'successful') do
#           let(:treasure_location) { create(:treasure_location) }
#           let(:id) { treasure_location.id }
  
#           run_test!(headers: headers)
#         end
#       end
  
#       # PUT /api/treasure_locations/:id
#       put('update treasure location') do
#         tags 'Treasure Locations'
#         consumes 'application/json'
#         parameter name: :id, in: :path, type: :integer
#         parameter name: :treasure_location, in: :body, schema: {
#           type: :object,
#           properties: {
#             name: { type: :string },
#             latitude: { type: :number },
#             longitude: { type: :number },
#             active: { type: :boolean }
#           }
#         }
  
#         response(200, 'successful') do
#           let(:treasure_location) { create(:treasure_location) }
#           let(:id) { treasure_location.id }
#           let(:treasure_location) { { name: 'New Name' } }
  
#           run_test!(headers: headers)
#         end
#       end
  
#       # DELETE /api/treasure_locations/:id
#       delete('destroy treasure location') do
#         tags 'Treasure Locations'
#         produces 'application/json'
#         parameter name: :id, in: :path, type: :integer
  
#         response(204, 'successful') do
#           let(:treasure_location) { create(:treasure_location) }
#           let(:id) { treasure_location.id }
  
#           run_test!(headers: headers)
#         end
#       end
#     end
  
#     path '/api/treasure_locations' do
#       # GET /api/treasure_locations
#       get('index treasure locations') do
#         tags 'Treasure Locations'
#         produces 'application/json'
  
#         response(200, 'successful') do
#           run_test!(headers: headers)
#         end
#       end
#     end
#   end

