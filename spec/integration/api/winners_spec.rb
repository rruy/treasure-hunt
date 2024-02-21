# require 'swagger_helper'

# RSpec.describe 'Winners API', type: :request do

#   path '/api/winners' do
#     get('list winners') do
#       tags 'Winners'
#       produces 'application/json'

#       response(200, 'successful') do
#         schema type: :object,
#                properties: {
#                  winners: {
#                    type: :array,
#                    items: {
#                      type: :object,
#                      properties: {
#                        id: { type: :integer },
#                        name: { type: :string },
#                        distance: { type: :number }
#                      },
#                      required: %w[id name distance]
#                    }
#                  }
#                }

#         let(:winners) { create_list(:user, 5, winner: true) }

#         before do
#           winners.each_with_index do |winner, index|
#             winner.update(distance: index * 100)
#           end

#           get '/api/winners?sort_column=distance&sort_direction=asc'
#         end

#         run_test!
#       end
#     end
#   end
# end
